---
layout: post
title: A new blogging engine
categories:
- Blog
- Ruby
- Technical
---
The last entry about a blogging software switch was called '[Keeping up with the times](http://www.rusiczki.net/2009/04/02/keeping-up-with-the-times/)' and I could have called this one the same. Back then, I finally realized that maintaining my Movable Type installation was a pain as I knew next to no Perl, but since I was an established PHP developer the migration to Wordpress was logical. Now I'm 'admitting' that I slowly transitioned to being a Ruby developer so I'm embracing Jekyll.

So what were the other reasons for the switch?

* I was getting a little paranoid about Wordpress and the extensions I was using. I wasn't terribly excited about the perspective that if a security hole appears and I'm not updating / patching in time (if a patch is available at all) my server gets f!@#ed.
* It takes Jekyll about one minute to generate the whole site but since the resulting files are vanilla HTMLs they're served much faster than the Wordpress equivalents. I haven't even configured the web server for this site to include the PHP interpreter.

What was holding me back?

* Not being a dynamic, database backed system comments had to be served by a third party system. I have Disqus although I'm a little paranoia to give all my comments to a third party service.
* Search was missing but I discovered Algolia.
* I'm badly missing a media manager.

Actually the migration began back in 2014 when I discovered Jekyll but I only finished it today. The second wave of motivation came because I wanted to use jekyll_asset_pipeline somewhere. The majority of the posts were created by an import from Wordpress but they were sub-par with lots of junk in them.
* Enter cleaner scripts written in Ruby.
* Removed useless YAML attributes and converted binary dates generated.
* Updated the formatting of lots of posts. It was due since 2009 when I switched to Wordpress but I though I'll do it one by one as I stumble upon posts with broken formatting. Which I did, but it wasn't enough. It was the Algolia search that prompted me to do this clean-up as the indexer wasn't accepting long paragraphs and some of my unformatted older posts came to be one long paragraph.
* Updated internal dead links. Lots of posts were still containing links to other posts using the old permalink style - /blog/archives/year/month/day/post_name. Now they all point to the correct format - /year/month/day/post-name/

Puts the content through jekyll-tidy to generate wonderfully delicious HTML pages.
