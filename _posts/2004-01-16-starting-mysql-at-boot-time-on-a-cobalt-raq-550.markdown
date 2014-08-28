---
layout: post
status: publish
published: true
title: Starting MySQL at boot time on a Cobalt RaQ 550
author:
  display_name: Janos
  login: janos
  email: 
  url: http://rusiczki.net
author_login: janos
author_email: 
author_url: http://rusiczki.net
wordpress_id: 227
wordpress_url: http://www.rusiczki.net/wp/?p=227
date: !binary |-
  MjAwNC0wMS0xNiAxMzozMjoyNiArMDEwMA==
date_gmt: !binary |-
  MjAwNC0wMS0xNiAxMDozMjoyNiArMDEwMA==
categories:
- Technical
tags: []
comments:
- id: 37
  author: Magued
  author_email: 
  author_url: ''
  date: !binary |-
    MjAwNC0wMi0wNyAxODowNTo0NyArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0wMi0wNyAxNTowNTo0NyArMDEwMA==
  content: ! 'I tried your instructions step by step but when I run mysqladmin version
    it gives me the following message

    [root@LynxServer /]# mysqladmin version

    -bash: mysqladmin: command not found

    [root@LynxServer /]#

'
- id: 38
  author: J
  author_email: 
  author_url: http://www.rusiczki.net/blog/
  date: !binary |-
    MjAwNC0wMi0wOCAwMDowMTozMiArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0wMi0wNyAyMTowMTozMiArMDEwMA==
  content: ! 'Try to:

    locate mysqladmin

    And then run it.

'
- id: 39
  author: Angus
  author_email: 
  author_url: http://www.sparc.co.uk
  date: !binary |-
    MjAwNC0wMi0xNiAyMTowMTozOCArMDEwMA==
  date_gmt: !binary |-
    MjAwNC0wMi0xNiAxODowMTozOCArMDEwMA==
  content: ! 'Thanks - this was EXACTLY what I needed to do  and you have saved me
    hours. Nice one.

    Angus

'
- id: 40
  author: Fabio
  author_email: 
  author_url: ''
  date: !binary |-
    MjAwNi0wNS0wNiAyMzoxOTo1MSArMDIwMA==
  date_gmt: !binary |-
    MjAwNi0wNS0wNiAyMDoxOTo1MSArMDIwMA==
  content: ! 'Great!!! It worked at the first attempt!!!

    Tanks a lot

    Fabio

'
---
<p>Well, my client started renting a Cobalt RaQ 550 server, and yesterday night he passed me the access coordinates for it. Great! I was eager to see the new toy. This means I wanted to see a console window... But for geeks this is a satisfaction anyway.<br />
The first problem at hand was that by default MySQL was not running. And the first thing we want to do is to transfer all of my client's current sites to this new server and as all the sites are dynamic (as in: based on PHP and MySQL) getting MySQL to run, and more specifically, getting the MySQL server to start automatically at boot time was of primary importance. After scoring the net I found <a href="http://www.brtnet.org/linux/raq2mysql.htm" title="Installing MySQL on Sun Cobalt MIPS-powered servers (RaQ 1 and 2, Qube 2)">this guide</a> but I wasn't really interested in installing or upgrading MySQL, I just needed it to start at boot time. But thankfully the last part of the guide described exactly how to accomplish this.<br />
First, to be able to perform all the administration tasks, I needed to be root:<br />
<code>su - root</code><br />
Then, let's see where the MySQL server's start script resides on our server:<br />
<code>locate mysql.server</code><br />
The answer came quick. On my appliance it was hiding in: <b>/usr/share/mysql/mysql.server</b><br />
OK, time to make it start at boot. The following commands will asure this will happen (please don't forget to replace <b>/usr/share/mysql/mysql.server</b> in the copy statement on the first line below with the path where your <b>mysql.server</b> resides):<br />
<code>cp /usr/share/mysql/mysql.server /etc/rc.d/init.d/mysql<br />
chmod +x /etc/rc.d/init.d/mysql<br />
ln -s /etc/rc.d/init.d/mysql /etc/rc.d/rc3.d/S90mysql</code><br />
Now, let's test it to see if it works:<br />
<code>/etc/rc.d/rc3.d/S90mysql start<br />
mysqladmin version</code><br />
It does? Cool! Just a few more things and we're done. Reboot the appliance from the web admin interface and then log in and check if MySQL really started up at boot time by issuing the <b>mysqladmin version</b> command again. If everything is working fine it's time to change the root password for your MySQL installation with (replace <i>new-password</i> in the command below with the new password of your choice):<br />
<code>mysqladmin -u root password new-password</code><br />
Please, if this miniguide has was helpful to you, leave a comment. If there's an error in it also leave a comment so I can correct it. If you made it work differently please describe how you did it. As I'm an occasional Linux user I can't by far guarantee that my way was the best way to do it.</p>
