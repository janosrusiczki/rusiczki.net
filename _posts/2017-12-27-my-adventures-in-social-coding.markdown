---
layout: post
title: My adventures in social coding
author: János
categories:
- Ruby
- Technical
- Work
---
At the beginning of 2014 I accepted to work on a project for a friend and since it was a simple presentation site I decided to build it in Jekyll[<sup>1</sup>](#1). (Throughout this post I will add explanations for non technical people as footnotes.) By the time I got started on this project I was kind of spoiled by [Rails](http://rubyonrails.org/)' asset pipeline[<sup>2</sup>](#2) functionality which was missing from Jekyll, but I quickly found [an add-on](https://github.com/matthodan/jekyll-asset-pipeline) which promised to deliver this. Taking a closer look at the GitHub repository of the add-on I noticed that the original author has not touched it for half a year or so and some of the pull requests[<sup>3</sup>](#3) were pretty straight forward so I decided to fork[<sup>4</sup>](#4) the repository and integrate those changes. Thanks to the magic of git and the Internet, I can "retrace" the timeline of what happened to my fork:

*   January 8, 2014 - I start committing code, one of the main tasks being renaming the add-on from jekyll\_asset\_pipeline to [japr](https://github.com/janosrusiczki/japr) (Jekyll Asset Pipeline Reborn).
*   January 14, 2014 - Thanks to my guerilla marketing campaign which involved leaving comments with links to my repository on the original repository's issues and pull requests the first contributions by other people appear on my fork.
*   March 7, 2014 - More contributions by third parties.
*   May 27, 2014 - A contributor adds [Rubocop](https://github.com/bbatsov/rubocop) which is a code quality checker that analyzes your code and reports "offenses" where it's not written as it should be. He also rewrites the code in some places.
*   September 9, 2014 - Even more contributions.
*   ... silence for a long time during which my fork gets abandoned and incompatible with the latest version of Jekyll ...
*   May 7, 2017 - A kind soul submits a pull request to fix the compatibility issues but due to lack of time I ignore it.
*   November 24, 2017 - While browsing around I notice a fork of my fork with changes that make it compatible with the current Jekyll version - I leave a comment on the author's fork that if he wants he can submit a pull request...

Which he did and from this point forward things sprang into motion: I got motivated to fix the outstanding Rubocop offenses, one of them being to write documentation for the classes and modules of the library. While doing this I actually understood the flow of the code - what it does and how it does it, after 3 years of pretending that I'm a maintainer... But better later than never, right? Another ambition got its resolution when I managed to bump the automated test coverage to 100%, which means that each and every line of the library is covered by tests, the risk of inadvertently breaking something without noticing while adding a new feature or fixing something being minimal. After releasing this version, I remember that I had an uplifting feeling while I was walking around town, looking at people and thinking "heh, you might not know, but I just released an opensource library doing some good for the community". This was a high point of the euphoria roller coaster that followed.

I then researched a little bit and noticed that there at least two more libraries focused on providing the same thing (an asset pipeline for Jekyll) one of them being minimalist and the other, well, the "everything but the kitchen sink" type. This was a low point, but I soon realized that the library I'm maintaining sits somewhere in between them having a medium amount of features.

A few short days later I'm laying in bed one night and after unsuccessfully waiting for sleep to come I decide to open up my phone and I notice an email. Written by the original author of the library I forked, in which he tells me that he noticed that I continued maintaining it and as he doesn't have the time, he wants to pass on the baton of the original library to a maintainer. I almost screamed a little. The highest point of the roller coaster - and it kind of stayed here from that point forward.

I got into my pre-Christmas mini vacation and after two or three afternoons of work I integrated the changes of my fork back into the original repository. And now I'm happily smiling as an author on the [gem's page](https://rubygems.org/gems/jekyll_asset_pipeline). Another bucket list item checked off.

**Footnotes**

1.  <a id="1"></a> [Jekyll](https://jekyllrb.com/) is a tool that generates a site based on a template and some post files which contain the actual content of the pages. It sits somewhere between writing your site by hand in HTML and using a full-blown CMS like WordPress.
2.  <a id="2"></a> The simple explanation for an asset pipeline is that it takes a bunch of CSS or JS files, pre-processes them, merges them together, minifies the result, etc. The obvious benefit is that instead of multiple requests there will be one request for CSS and one for JavaScript, easing the load on the server and making the page load faster.
3.  <a id="3"></a> A pull request is a way to propose your changes to a repository of code. Before making their way into the code base these changes have to be accepted by the owner of said repository.
4.  <a id="4"></a> A fork is a copy of a repository of code.
