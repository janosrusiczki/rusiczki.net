---
layout: post
status: publish
published: true
title: How to find the username associated with a given UID
author:
  display_name: Janos
  login: janos
  email: 
  url: http://rusiczki.net
author_login: janos
author_email: 
author_url: http://rusiczki.net
wordpress_id: 453
wordpress_url: http://www.rusiczki.net/wp/?p=453
date: !binary |-
  MjAwNy0wMy0wOSAxNDowNzo0OCArMDEwMA==
date_gmt: !binary |-
  MjAwNy0wMy0wOSAxMTowNzo0OCArMDEwMA==
categories:
- Technical
tags: []
comments: []
---
<p>In Unix based systems, obviously...<br />
I was curious one day to find where do some of the queued e-mail messages on a server originate from and since qmail only outputs something like "qmail x invoked by uid y" (where x and y are numbers obviously) I had to find out which user corresponds to y. After fiddling for a while without getting anywhere I resorted to asking around. And as usual the answer came quick from a good friend:<br />
grep y /etc/passwd<br />
Hmmm. Magic!</p>
