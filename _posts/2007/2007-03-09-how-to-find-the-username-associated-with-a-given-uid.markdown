---
layout: post
title: How to find the username associated with a given UID
date: 2007-03-09 14:07:48.000000000 +01:00
categories:
- technical
---
In Unix based systems, obviously...

I was curious one day to find where do some of the queued e-mail messages on a server originate from and since qmail only outputs something like "qmail x invoked by uid y" (where x and y are numbers obviously) I had to find out which user corresponds to y. After fiddling for a while without getting anywhere I resorted to asking around. And as usual the answer came quick from a good friend:

grep y /etc/passwd

Hmmm. Magic!
