---
layout: post
status: publish
published: true
title: So much spam so little time...
author: János
wordpress_id: 207
wordpress_url: http://www.rusiczki.net/wp/?p=207
date: !binary |-
  MjAwMy0xMi0wMSAyMjo0ODo1OSArMDEwMA==
date_gmt: !binary |-
  MjAwMy0xMi0wMSAxOTo0ODo1OSArMDEwMA==
categories:
- Technical
tags: []
comments: []
---
<p>Fighting spam is always actual. Because once you think that, yes!, I finally found the ultimate tool to filter all that nasty spam out, spammers figure out a way to avoid the filter the majority is using applying various methods, some of them rather dumb others quite clever. That's why I gave up on using the <a href="http://www.statalabs.com/products/saproxy/overview.php">SpamAssassin proxy</a>. It was letting an increasing number of messages through into my Inbox and the only way to make it catch them would have been to lower the spam score to a ridiculously low level. This in turn would meant lots of false positives (completely harmless mail identified as SPAM) which I was getting anyway meaning I had to fiddle with the whitelist... All this fiddling meant work, work and more work. And who likes work? Who doesn't like comfort?<br />
So after spending some time browsing <a href="http://www.spamotomy.com" title="Spamotomy: Cutting junk mail out of your life">Spamotomy</a> here's the new solution, <a href="http://popfile.sourceforge.net">POPFile</a>. It's a program based on <a href="http://www.paulgraham.com/better.html">bayesian filters</a> which means that it's quite stupid out of the box and you have to train it to identify spam. In fact it's not designed to identify just spam because it can learn to sort any kind of incoming mail whether it is from various mailing lists, newsletters, colleagues, friends, etc. A fair amount of training and you have a very powerful mail sorter tool. I was amazed how quickly it caught what is spam and what's legitimate mail. The configuration is a lot easier than that of the SpamAssassin proxy because it shows up in your browser and it is really straightforward once you get a grip of the basics. So for the moment this is the tool for me! And since it can <i>learn</i> I think I will be using it for some time...<br />
As the ultimate method I'm thinking about chaining up the 2 tools, so that POPFile would receive the email already processed by the SpamAssassin proxy which will run set at a reasonably high score to avoid false positives.<br />
The ultimate goal? 0 spam in my Inbox. Yeah right...</p>
