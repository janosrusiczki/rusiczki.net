---
layout: post
status: publish
published: true
title: Upgrading PHP on a Cobalt RaQ 550
author: János
wordpress_id: 228
wordpress_url: http://www.rusiczki.net/wp/?p=228
date: !binary |-
  MjAwNC0wMS0xNiAxNDoyMDoxNSArMDEwMA==
date_gmt: !binary |-
  MjAwNC0wMS0xNiAxMToyMDoxNSArMDEwMA==
categories:
- Technical
tags: []
comments:
- id: 41
  author: steve wright
  author_email: 
  author_url: http://www.youthspace.net
  date: !binary |-
    MjAwNC0wMi0yNCAwMDo1Mjo1MSArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0wMi0yMyAyMTo1Mjo1MSArMDEwMA==
  content: ! 'the link to the upgrading php in a raq550 is gone.  Any chance you saved
    it somewhere?

'
- id: 42
  author: J
  author_email: 
  author_url: http://www.rusiczki.net
  date: !binary |-
    MjAwNC0wMi0yNCAxMTozNDoxMyArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0wMi0yNCAwODozNDoxMyArMDEwMA==
  content: ! 'No I haven''t saved it. But check the main page of that site. It says:
    "I have switched away from PhpWiki to UseMod Wiki. It''s much simpler - a single
    .pl script runs the whole thing! I am starting to migrate the content across from
    the old wiki. Please forgive any broken links; I will try to repair them as soon
    as possible." So I think the link will be up again soon.

'
---
<p>So, after the success of <a href="http://www.rusiczki.net/blog/archives/2004/01/16/starting_mysql_at_boot_time_on_a_cobalt_raq_550" title="Starting MySQL at boot time on a Cobalt RaQ 550">getting MySQL to work properly</a> on the server I installed <a href="http://www.phpmyadmin.net" title="THE PHP based MySQL admin tool of choice">phpMyAdmin</a>. It didn't work at first but I changed something in php.ini (described later) and then it did but it was complaining and suggesting a PHP upgrade. So I checked the version and my jaw nearly dropped when I saw the spanking new RaQ 550 was running stone age old PHP 4.0.6. Argh. It was time to search for a guide on upgrading PHP on RaQ 550. <a href="http://www.cobaltfaqs.com/wiki/index.php/Upgrade%20PHP%20on%20RaQ%20550" title="PhpWiki - Upgrade PHP on RaQ 550">I found it quick.</a><br />
That guide is very well written and so it's easy to follow but I had to do a few things differently on my client's appliance. First of all as 4.3.4 is the latest stable version of PHP at the time of writing this I obviously used this version and not 4.3.3 as stated in the guide. It looked like I didn't have IMAP and libmcrypt installed and I didn't bother to install them (maybe I'll need them in the future, and I'll have to install them and recompile PHP, grrr!) so I dropped the following three lines from my ./configure command:<br />
<code>--with-imap \<br />
--with-imap-ssl \<br />
--with-mcrypt=shared \</code><br />
This way the ./configure command went through without any problems. Then down at the 'Modify user-space web server to use new PHP library' section the following lines:<br />
<code>AddType application/x-httpd-php4 .php3<br />
AddType application/x-httpd-php4 .php4<br />
AddType application/x-httpd-php4 .php</code><br />
were not located in the httpd.conf file on my appliance but in srm.conf which is in the same directory. Obviously, I modified that file.<br />
What this guide omits to say (because it isn't really it's scope) but I found in <a href="http://sunsolve.sun.com/pub-cgi/retrieve.pl?doc=finfodoc%2F8412&zone_32=raq%20550%20mysql" title=" Enabling support for MySQL in PHP on RaQ 550">another document</a> is that if you want to make PHP work with MySQL you have to add the following line to your <b>/etc/httpd/php.ini</b> file:<br />
<code>extension=mysql.so</code><br />
After saving the .ini file do not forget to restart httpd by typing the <b>/etc/init.d/httpd restart</b> command.<br />
So! After configuring, making, modifying and restarting everything as described in the guide with the few minor changes as mentioned earlier it worked! Well, I was really pleased with myself and after installing <a href="http://mojo.skazat.com/" title="Dada Mail">a newsletter utility</a> I went to bed knowing I just played with a 2500 euros-per-year thingie and didn't brake anything. Phew!</p>
