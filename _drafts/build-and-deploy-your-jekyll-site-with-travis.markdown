After transitioning my blog to Jekyll the next goal was to build and deploy the site via an external service which is triggered by pushing to a certain GitHub branch (in my case `master`). I wanted local configuration to be well documented such as in the case of a hosting server switch I don't have to figure out everything again and maybe also help others who stumble upon this article. The CI service of choice was [Travis](https://travis-ci.org/) because I'm using it for [jekyll_asset_pipeline](https://github.com/matthodan/jekyll-asset-pipeline) and some other open source side projects I'm working on.

## Build

Building a piece of software usually consists of the build part itself followed by testing. The actual build part in Jekyll's case is straight forward, even the command is called `jekyll build`, but I was wondering about the second part: as opposed to an application what can you test on a static site? The answer came as [html-proofer](https://github.com/gjtorikian/html-proofer) which checks your site's HTML files for the correctness of inbound and outbound links, image references, the presence of alt tags on the images, etc.

Continuous integration of a Jekyll site with Travis is [very well documented](https://jekyllrb.com/docs/continuous-integration/travis-ci/) so I will stick to describing what I needed to change.

I decided to run html-proofer via rake instead of a stand alone command as described in the article above so I could add some configuration. My *Rakefile* looks like this:

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

I disabled checking of external links because I have a blog with ancient content which contain links that died a long time ago. The /feed/ directory is redirected from the vhost config so I set that to be ignored.

Please note that you'll have to add `rake` and `html-proofer` to your *Gemfile*.

My .travis.yml at this point read:

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

I'd say it's self explanatory.

Don't forget to add `vendor` to your `exclude:` list in Jekyll's \_config.yml or else all hell will break loose.

At this point after pushing to the master branch the project would successfully build.

https://github.com/janosrusiczki/janosrusiczki/commit/24acd18d0f5fc2f840d9982021e0d8dcbfc55d31
https://github.com/janosrusiczki/janosrusiczki/commit/768bbad083fe76d5878dce91dff0514a3b385f9b

## Deploy

On to the deploy part which is based on [this article](https://oncletom.io/2016/travis-ssh-deploy/).

We'll be deploying the *\_site* directory which we built during the previous step to our server via a secure SSH connection. For this we'll need to generate an RSA key pair, add it as trusted on our hosting server and give Travis the private key. Wait, what? But how do we protect it from the public eye? Never fear, Travis provides us the means to encrypt it. This can be done by using the [travis gem](https://github.com/travis-ci/travis.rb) which we'll have to install to the machine which we built our Jekyll site on by running `gem install travis` - we'll call this the local machine.

Let's get to work!

First of all it is recommended to create a separate deploy user on the hosting server and set the directory from which your site is served from writable by this user. Then generate the RSA keypair by running the following command in your project's directory on your local machine

    $ ssh-keygen -t rsa -b 4096 -C 'build@travis-ci.org' -f ./deploy_rsa

This results in deploy_rsa and deploy_rsa.pub, the private and public keys, respectively. Whatever you do, don't check these into your site's git repository and don't build your site while they're sitting there. We'll delete them shortly.

    $ travis encrypt-file deploy_rsa --add
    encrypting deploy_rsa for janosrusiczki/janosrusiczki
    storing result as deploy_rsa.enc
    storing secure env variables for decryption

If this is the first time you're running the travis utility you will get:

    not logged in - try running travis login --org

Which you should do in order to associate your Travis build with this directory and make your life easier in the future.

But what happened? The travis utility created a deploy_rsa.enc (an encrypted version of the private key), with a decryption key that it stored as an environment variable on Travis and also added some lines to your *.travis.yml* file which will decrypt the private key file during build.

Now add the public key to the list of accepted keys on your hosting server.

    $ ssh-copy-id -i deploy_rsa.pub <ssh-user>@<deploy-host>

Once this is done the unencrypted private key as well as the public key can be deleted from the local machine:

    $ rm -f deploy_rsa deploy_rsa.pub

Once you do this the previous non-check-in / non-build ban is lifted.

Now edit .travis.yml and move the decryption line from the `script:` section to the `before_deploy:` section and modify as follows:

    before_deploy:
    - openssl aes-256-cbc -K $encrypted_<...>_key -iv $encrypted_<...>_iv -in deploy_rsa.enc -out /tmp/deploy_rsa -d
    - eval "$(ssh-agent -s)"
    - chmod 600 /tmp/deploy_rsa
    - ssh-add /tmp/deploy_rsa

This ensures that before a deploy is attempted the private key is decrypted and loaded into memory.

What's left to do is doing the deployment itself. This will be done via rsync and we want to keep the deployment host, user and directory secret because we don't want script kiddies sniffing around our hosting server, do we?

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

`skip_cleanup` ensures that the result of the build is not deleted before we want to transfer it. `--delete-after`'s effect is that it will clean the directory on the hosting server before uploading the freshly built site so that there are no left overs or forgotten files.

And with this we're done!