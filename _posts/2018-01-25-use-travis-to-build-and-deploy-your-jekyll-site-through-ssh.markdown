---
layout: post
title: Use Travis to build and deploy your Jekyll site through SSH
date: 2018-01-25 11:45:00 +0200
categories:
- Blog
- Ruby
- Technical
image: https://content.rusiczki.net/2018/01/bricks-jekyll-github-travis.jpg
description: How to use Travis to build and deploy your Jekyll site to your VPS through SSH.
---
![An image of bricks with the Jekyll, GitHub and Travis logos on it](https://content.rusiczki.net/2018/01/bricks-jekyll-github-travis.jpg)

After [transitioning my blog to Jekyll](https://www.rusiczki.net/2018/01/08/a-new-blogging-engine/) my next goal was to have the site built and deployed via an external service which is automatically triggered by pushing to a certain GitHub branch (in my case *master*).

I achieved this a few years ago by using [DeployBot](https://deploybot.com/) but their free plan only supports the deployment of one site and it wasn't ideal anyway because I had to run the build on my end, so I started researching how can this be done with one of the continuous integration services out there which support unlimited open source builds.

While searching around I found plenty of articles out there dealing with deploying to GitHub pages (this looks to be the most popular scenario) but only a handful about deploying to your own server so once I managed to do it I wanted to document my solution so that if I happen to change the hosting I don't have to figure out everything again and maybe also help others who stumble upon this article.

I choose [Travis](https://travis-ci.org/) as the CI service because I've used it for [jekyll_asset_pipeline](https://github.com/matthodan/jekyll-asset-pipeline) and some other open source side projects I'm working on.

## Build

Building a piece of software usually consists of the build part itself followed by testing. The actual build part in Jekyll's case is straight forward, the command is actually `jekyll build`, but I was wondering about the second part: as opposed to an application what can you test on a static site? The answer came as [html-proofer](https://github.com/gjtorikian/html-proofer) which checks your site's HTML files for the correctness of local and outbound links, image references, the presence of alt tags on the images, etc.

Continuous integration of a Jekyll site with Travis is [documented](https://jekyllrb.com/docs/continuous-integration/travis-ci/) on the official site so I will only describe what I changed.

I decided to run html-proofer through rake instead of a stand alone command as described in the article above so I could add configuration more easily. My *Rakefile* looks like this:

    require 'html-proofer'
    task :test do
      options = {
        disable_external: true,
        url_ignore: [
          '/feed/'
        ]
      }
      HTMLProofer.check_directory("./_site/", options).run
    end

I disabled the checking of external links because this blog has some ancient content with links that died a long time ago. The */feed/* directory is redirected from the vhost config so I set that to be ignored.

Try it out by running `rake test` (after running `jekyll build` of course). Does it pass? Great! It doesn't? Get editing!

At this point my *.travis.yml* read:

    language: ruby
    rvm:
    - 2.4
    env:
      global:
      - NOKOGIRI_USE_SYSTEM_LIBRARIES=true # speeds up installation of html-proofer
    branches:
      only:
      - master
    script:
      - bundle exec jekyll build
      - bundle exec rake test

I'd say it's pretty self explanatory. The one line that isn't comes with a comment.

Don't forget to add `rake` and `html-proofer` to your *Gemfile* to be able to run the build on Travis. Also don't forget to add `vendor` to your `exclude:` list in Jekyll's *\_config.yml* or else all hell will break loose. I warned you.

After pushing to the master branch on GitHub the project should successfully build on Travis.

## Deploy

On to the deploy part which is based on [this article](https://oncletom.io/2016/travis-ssh-deploy/).

In this step we'll be deploying the *\_site* directory which we generated during the previous step to our hosting server through a secure SSH connection. To be able to do this we'll need to generate an RSA key pair, add the public key as trusted to our hosting server and give Travis the private key. Wait, what? But how do we protect it from the public eye? Never fear, Travis provides us with the means to encrypt it, by using the [travis utility](https://github.com/travis-ci/travis.rb) which has to be installed to the local machine by running `gem install travis`.

Let's get to work!

First of all it is recommended to create a separate deploy user on the hosting server and set the directory which the site is served from to be writable by this user. Then generate the RSA keypair by running the following command in the project's directory on the local machine:

    $ ssh-keygen -t rsa -b 4096 -C 'build@travis-ci.org' -f ./deploy_rsa

This results in *deploy_rsa* and *deploy_rsa.pub*, the private and public keys respectively. Whatever you do, don't check these into your site's git repository and don't build your site while they're sitting there. We'll delete them soon.

Now encrypt the private key:

    $ travis encrypt-file deploy_rsa --add

If this is the first time you're running the travis utility you will get:

    not logged in - try running travis login --org

Which should be done in order to associate the Travis build with this directory and make our life easier in the future.

But what happened? The utility created a *deploy_rsa.enc* (an encrypted version of the private key), with a decryption key that it stored as an environment variable on Travis and also added some lines to the *.travis.yml* file which will decrypt the private key file during the build.

Now add the public key to the list of accepted keys on the hosting server:

    $ ssh-copy-id -i deploy_rsa.pub <ssh-user>@<deploy-host>

The unencrypted private key as well as the public key can now be deleted from the local machine:

    $ rm -f deploy_rsa deploy_rsa.pub

Once this is done the previous no-check-in / no-build ban is lifted so add *deploy_rsa.enc* to the git repository.

Now edit .travis.yml and move the decryption line from the `script:` section to the `before_deploy:` section and modify as follows:

    before_deploy:
    - openssl aes-256-cbc -K $encrypted_<...>_key -iv $encrypted_<...>_iv
      -in deploy_rsa.enc -out /tmp/deploy_rsa -d
    - eval "$(ssh-agent -s)"
    - chmod 600 /tmp/deploy\_rsa
    - ssh-add /tmp/deploy\_rsa

This ensures that before the deploy is done the private key is decrypted and loaded into memory.

What's left to do is the deployment itself. This will be done with rsync and we want to keep the deployment host, user and directory secret because we don't want script kiddies sniffing around our hosting server now, do we?

Run these on the local machine in the project directory:

    $ travis encrypt DEPLOY_DIRECTORY=<deploy directory> --add
    $ travis encrypt DEPLOY_HOST=<deploy host> --add
    $ travis encrypt DEPLOY_USER=<deploy user> --add

These will add three lines starting with `- secure` to the `env.global:` section of *.travis.yml*. Add the following to the `before_deploy:` section of the same file:

    - echo $DEPLOY_HOST > ~/.ssh/known_hosts

This ensures that the deploy process doesn't hang waiting for user input.

And now for the grand finale! Add to the end of *.travis.yml*:

    deploy:
      provider: script
      skip_cleanup: true
      script: rsync -r --quiet --delete-after _site/* $DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_DIRECTORY
      on:
        branch: master

`skip_cleanup` ensures that the result of the build is not deleted before we transfer it. `--delete-after`'s effect is that it will clean the directory on the hosting server before uploading the freshly built site so that there are no left overs or forgotten files.

And with this we're done! Push to the master branch on GitHub and sit back and relax while your site is automagically deployed by Jenkins. Well, possibly it won't happen on the first try, but hey, once it does I guarantee an overwhelming feeling of satisfaction for the nerd inside you.

As an additional note, when I'm proof reading my site and making small changes to many files by multiple commits through the GitHub web interface I usually add `[ci skip]` to the commit messages so that I don't overwhelm Travis. They're giving me something for free and I tend to respect that by not abusing their service.

Header image by Alan Levine, [found on Flickr](https://www.flickr.com/photos/cogdog/14927881517/).
