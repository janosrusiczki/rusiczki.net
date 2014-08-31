---
layout: post
status: publish
published: true
title: PHP protected file downloads for your site's members
author: János
wordpress_id: 353
wordpress_url: http://www.rusiczki.net/wp/?p=353
date: !binary |-
  MjAwNS0wMi0xNCAxMzo1NzozNSArMDEwMA==
date_gmt: !binary |-
  MjAwNS0wMi0xNCAxMDo1NzozNSArMDEwMA==
categories:
- PHP
tags: []
comments:
- id: 204
  author: Adi
  author_email: 
  author_url: http://www.tase.ro
  date: !binary |-
    MjAwNS0wMi0xNCAxODoyMjo0MSArMDEwMA==
  date_gmt: !binary |-
    MjAwNS0wMi0xNCAxNToyMjo0MSArMDEwMA==
  content: ! 'You could also use cookies or server side tracking of IP''s to make
    sure nobody downloads more than X files at once. Some kind of semaphore with X
    slots.

'
- id: 205
  author: Gabriel Radic
  author_email: 
  author_url: http://www.timbru.com/
  date: !binary |-
    MjAwNS0wMi0xNSAxNjowMzoyNiArMDEwMA==
  date_gmt: !binary |-
    MjAwNS0wMi0xNSAxMzowMzoyNiArMDEwMA==
  content: ! 'What''s wrong with http authentication?

    <a href="http://httpd.apache.org/docs/howto/auth.html#basic" rel="nofollow">http://httpd.apache.org/docs/howto/auth.html#basic</a>

'
- id: 206
  author: Gabriel Mihalache
  author_email: 
  author_url: http://gabriel.mihalache.name/
  date: !binary |-
    MjAwNS0wMy0yMCAxMzoxNjozOCArMDEwMA==
  date_gmt: !binary |-
    MjAwNS0wMy0yMCAxMDoxNjozOCArMDEwMA==
  content: ! 'How does the entire file ends up in memory?

    I did, about 4 years ago, a PHP script that would check credentials and then read
    from the file and write to the user, copy&amp;paste via a small buffer. Why load
    the entire file in memory?

    Use readfile ( <a href="http://ro.php.net/manual/en/function.readfile.php" rel="nofollow">http://ro.php.net/manual/en/function.readfile.php</a>
    )... or any of the other alternatives listed on that page.

'
- id: 207
  author: Gabriel Mihalache
  author_email: 
  author_url: http://gabriel.mihalache.name/
  date: !binary |-
    MjAwNS0wMy0yMCAxMzoxODowMyArMDEwMA==
  date_gmt: !binary |-
    MjAwNS0wMy0yMCAxMDoxODowMyArMDEwMA==
  content: ! 'P.S. You need to set the buffer/chuck size or just rought it out with
    fopen and friends.

'
---
<p>Hey, look! I just made a Google friendly entry title... And I did it because I want people to learn from the mistakes I made.</p>
<p>Suppose you have a website and you want to have some downloads available only to the members. Maybe you'll manually approve each member to protect your bandwidth and so on... What do you do? You'll most likely set up a members system in PHP (or integrate your downloads page with your exisiting members system) and then you'll write a script to check if the user is authenticated and / or has download rights and if yes pass him the file via the script. You do this "via the script" passing instead of a header redirect to the real location of the file because advanced users could note the real location of the file thus circumventing the protection.</p>
<p>If you have big files to protect (relative to your server's memory) don't make the same mistake I did. Do not use any PHP function that loads the file into the memory and than passes it on to the user. You'll expose the server your pages are hosted on to unwanted DoS (Denial of Service) risks. My client had some nice guy coming through an open proxy from Cambodia who hammered the server with 5 to 10 requests per second for software-download.php?id=435. What happened was that PHP tried to load 10 * 85 megs per second and I'll let you do the math and figure out how much it took it to run out of memory... I caught the bastard by activating Apache's <a href="http://httpd.apache.org/docs/mod/mod_status.html" title="Apache module mod_status">mod_status</a> module and watched what was happening in real time.</p>
<p>I'm still thinking about an easy solution for this problem, except splitting up the huge files with <a href="http://www.rarlab.com/" title="WinRAR archiver, a powerful tool to process RAR and ZIP files">RAR</a> or banning more than 1 connection from one user in an X minute interval which creates some database overhead.</p>
