---
layout: post
title: A new blogging engine
categories:
- Blog
- Ruby
- Technical
---
My last entry about a blogging software switch was called '[Keeping up with the times](http://www.rusiczki.net/2009/04/02/keeping-up-with-the-times/)' and I could have called this one the same. Back then, I finally realized that maintaining my Movable Type installation was a pain as I knew next to no Perl but since I was an established PHP developer the migration to Wordpress was logical. Now I'm 'admitting' that I slowly transitioned to being a Ruby developer so I'm embracing [Jekyll](https://jekyllrb.com/).

So what were the other reasons for the switch?

* I was getting a little paranoid about Wordpress and the extensions I was using. I wasn't terribly excited about the perspective that if a security hole appears and I'm not updating in time (if an update is available at all) my server gets f!@#ed.
* It takes Jekyll about one minute to generate the whole site but as the resulting files are vanilla HTMLs they're served much faster than their Wordpress equivalents. I haven't even configured the web server for this site to include the PHP interpreter.

What are the downsides?

* Not being a dynamic, database backed system comments have to be served by a third party system. There might be self hosted alternatives out there, but I haven't researched them since I had Disqus installed for a long while anyway, although I'm not entirely comfortable to give all my comments to a third party service (up until now, additionally to Disqus they were saved locally too by Wordpress).
* For searching I discovered Algolia which is awesome and much faster than the Wordpress search was.
* I have to admit, Wordpress' media manager was great and I'm badly missing it.

Actually the migration began back in 2014 when I discovered Jekyll. The second wave of motivation came because I wanted to use jekyll_asset_pipeline somewhere. The majority of the posts were created by an import from Wordpress 4 years ago but they were sub-par with lots of junk in them.

So I hacked together a few cleaner scripts in Ruby which:

* Removed useless YAML attributes and converted binary dates generated.
* Updated the formatting of tong of posts. This was due since 2009 when I switched to Wordpress but I though I'll do it on a need by need as I stumble upon posts with broken formatting. Which I did, but it wasn't nearly enough. It was the Algolia search that prompted me to do this clean-up as the indexer wasn't accepting long paragraphs and some of my unformatted older posts were generated as one long paragraph.
* Updated internal dead links. Lots of posts were still containing links to other posts using the old permalink style - /blog/archives/year/month/day/post_name. Now they all point to the correct format - /year/month/day/post-name/ 

Puts the content through jekyll-tidy to generate wonderfully delicious HTML pages.
