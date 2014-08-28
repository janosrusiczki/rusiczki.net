---
layout: post
status: publish
published: true
title: Unicode annoyances
author:
  display_name: Janos
  login: janos
  email: 
  url: http://rusiczki.net
author_login: janos
author_email: 
author_url: http://rusiczki.net
wordpress_id: 341
wordpress_url: http://www.rusiczki.net/wp/?p=341
date: !binary |-
  MjAwNC0xMi0xNyAxODo1OTo1NCArMDEwMA==
date_gmt: !binary |-
  MjAwNC0xMi0xNyAxNTo1OTo1NCArMDEwMA==
categories:
- Technical
tags: []
comments:
- id: 178
  author: stk
  author_email: 
  author_url: http://127.0.0.1/
  date: !binary |-
    MjAwNC0xMi0xNyAxOTo1NDoyNiArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0xMi0xNyAxNjo1NDoyNiArMDEwMA==
  content: ! 'yeap. sad. this is life. get used with it.

'
- id: 179
  author: Gabriel Radic
  author_email: 
  author_url: http://www.timbru.com/
  date: !binary |-
    MjAwNC0xMi0yMSAxNjoxNzo1MCArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0xMi0yMSAxMzoxNzo1MCArMDEwMA==
  content: ! 'Find more here .

    See a Romanian feeds index here

'
- id: 180
  author: Gabriel Radic
  author_email: 
  author_url: http://www.timbru.com/
  date: !binary |-
    MjAwNC0xMi0yMSAxNjoxOToxMCArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0xMi0yMSAxMzoxOToxMCArMDEwMA==
  content: ! 'Uhm, the addresses were stripped out. Here they are again

    Sh & Tz documentation

    <a href="http://www.secarica.ro/html/s-uri_si_t-uri.html" rel="nofollow">http://www.secarica.ro/html/s-uri_si_t-uri.html</a>

    The Romanian feeds index

    <a href="http://rss.mioritics.ro/" rel="nofollow">http://rss.mioritics.ro/</a>

'
- id: 181
  author: Janos
  author_email: 
  author_url: http://www.rusiczki.net/blog/
  date: !binary |-
    MjAwNC0xMi0yMSAxNjozNjoyMSArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0xMi0yMSAxMzozNjoyMSArMDEwMA==
  content: ! 'Thanks a lot Gabriel, I once read the page on secarica.com but I even
    searched for it before writing this very entry but I couldn''t find it. Now I
    bookmarked it.

    Concerning the other link take a look here: <a href="http://www.rusiczki.net/rfs/"
    rel="nofollow">http://www.rusiczki.net/rfs/</a> - but that''s not even an alpha,
    since only the crawler / XML feed fetcher is in place for now... :-)

'
---
<p>I'm trying to hack together a small and simple search engine for the (not so) few Romanian RSS and Atom feeds that exist today. But the special characters are killing me slowly and painfully.<br />
For starters <a href="http://bucovina.chem.tue.nl/page_8.htm">here's a well documented page with the Romanian alphabet using the correct Unicode characters</a>. Looks nice on Firefox but when you load it Microsoft's one and only browser some of the special characters get replaced with nice empty boxes. In times like this I wish I could scream like that guy from Two Stupid Dogs: "Now, ain't that cute? BUT IT'S WRONG!"<br />
To make it simple: <strong>Q:</strong> What do you get when you mix together a powerful Redmond based company and the Romanian alphabet? <strong>A:</strong> An incorrect Romanian alphabet. I wish to remind everyone that we're not Turkish, our "sh" sound is written using a "<a href="http://www.eki.ee/letter/chardata.cgi?ucode=0219">letter s with  comma below</a>" not a "<a href="http://www.eki.ee/letter/chardata.cgi?ucode=015F">letter s with cedilla</a>" even if we see this error in almost every document we read on- or offline. I'm referring here to offline documents produced by the almighty MS Word which everybody in Romania uses, because at least the publications (or most of them) use the right version of the letter and I guess this is because they're edited on Macs using Adobe products. But I trailed off...<br />
What I actually wanted to do in my project was to convert malformed Romanian characters to their proper counterparts when fetching and storing a feed entry. But what's the use if the dominant operating system and browser out there favor the malformed version? The conclusion is that I'll do it like this anyway because this is a hobby level project and I'll eventually make some conversions again when extracting the data... At least my database will contain proper Unicode and I'll have my peace of mind.</p>
