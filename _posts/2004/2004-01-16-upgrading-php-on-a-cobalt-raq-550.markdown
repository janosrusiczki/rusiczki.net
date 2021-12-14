---
layout: post
title: Upgrading PHP on a Cobalt RaQ 550
date: 2004-01-16 14:20:15 +0100
categories:
- Technical
---
So, after the success of <a href="http://www.rusiczki.net/2004/01/16/starting-mysql-at-boot-time-on-a-cobalt-raq-550/" title="Starting MySQL at boot time on a Cobalt RaQ 550">getting MySQL to work properly</a> on the server I installed <a href="http://www.phpmyadmin.net" title="THE PHP based MySQL admin tool of choice">phpMyAdmin</a>. It didn't work at first but I changed something in php.ini (described later) and then it did but it was complaining and suggesting a PHP upgrade. So I checked the version and my jaw nearly dropped when I saw the spanking new RaQ 550 was running stone age old PHP 4.0.6. Argh. It was time to search for a guide on upgrading PHP on RaQ 550. <a href="http://www.cobaltfaqs.com/wiki/index.php/Upgrade%20PHP%20on%20RaQ%20550" title="PhpWiki - Upgrade PHP on RaQ 550">I found it quick.</a>

That guide is very well written and so it's easy to follow but I had to do a few things differently on my client's appliance. First of all as 4.3.4 is the latest stable version of PHP at the time of writing this I obviously used this version and not 4.3.3 as stated in the guide. It looked like I didn't have IMAP and libmcrypt installed and I didn't bother to install them (maybe I'll need them in the future, and I'll have to install them and recompile PHP, grrr!) so I dropped the following three lines from my ./configure command:

    --with-imap \
    --with-imap-ssl \
    --with-mcrypt=shared \

This way the ./configure command went through without any problems. Then down at the 'Modify user-space web server to use new PHP library' section the following lines:

    AddType application/x-httpd-php4 .php3
    AddType application/x-httpd-php4 .php4
    AddType application/x-httpd-php4 .php

were not located in the httpd.conf file on my appliance but in srm.conf which is in the same directory. Obviously, I modified that file.

What this guide omits to say (because it isn't really it's scope) but I found in <a href="http://sunsolve.sun.com/pub-cgi/retrieve.pl?doc=finfodoc%2F8412&zone_32=raq%20550%20mysql" title=" Enabling support for MySQL in PHP on RaQ 550">another document</a> is that if you want to make PHP work with MySQL you have to add the following line to your <b>/etc/httpd/php.ini</b> file:

    extension=mysql.so

After saving the .ini file do not forget to restart httpd by typing the <b>/etc/init.d/httpd restart</b> command.

So! After configuring, making, modifying and restarting everything as described in the guide with the few minor changes as mentioned earlier it worked! Well, I was really pleased with myself and after installing <a href="http://mojo.skazat.com/" title="Dada Mail">a newsletter utility</a> I went to bed knowing I just played with a 2500 euros-per-year thingie and didn't brake anything. Phew!
