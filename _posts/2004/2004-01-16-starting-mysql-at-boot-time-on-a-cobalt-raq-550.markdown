---
layout: post
title: Starting MySQL at boot time on a Cobalt RaQ 550
date: 2004-01-16 13:32:26.000000000 +01:00
categories:
- technical
---
Well, my client started renting a Cobalt RaQ 550 server, and yesterday night he passed me the access coordinates for it. Great! I was eager to see the new toy. This means I wanted to see a console window... But for geeks this is a satisfaction anyway.

The first problem at hand was that by default MySQL was not running. And the first thing we want to do is to transfer all of my client's current sites to this new server and as all the sites are dynamic (as in: based on PHP and MySQL) getting MySQL to run, and more specifically, getting the MySQL server to start automatically at boot time was of primary importance. After scoring the net I found <a href="http://www.brtnet.org/linux/raq2mysql.htm" title="Installing MySQL on Sun Cobalt MIPS-powered servers (RaQ 1 and 2, Qube 2)">this guide</a> but I wasn't really interested in installing or upgrading MySQL, I just needed it to start at boot time. But thankfully the last part of the guide described exactly how to accomplish this.

First, to be able to perform all the administration tasks, I needed to be root:

<code>su - root</code>

Then, let's see where the MySQL server's start script resides on our server:

<code>locate mysql.server</code>

The answer came quick. On my appliance it was hiding in: <b>/usr/share/mysql/mysql.server</b>

OK, time to make it start at boot. The following commands will asure this will happen (please don't forget to replace <b>/usr/share/mysql/mysql.server</b> in the copy statement on the first line below with the path where your <b>mysql.server</b> resides):

<code>cp /usr/share/mysql/mysql.server /etc/rc.d/init.d/mysql

chmod +x /etc/rc.d/init.d/mysql

ln -s /etc/rc.d/init.d/mysql /etc/rc.d/rc3.d/S90mysql</code>

Now, let's test it to see if it works:

<code>/etc/rc.d/rc3.d/S90mysql start

mysqladmin version</code>

It does? Cool! Just a few more things and we're done. Reboot the appliance from the web admin interface and then log in and check if MySQL really started up at boot time by issuing the <b>mysqladmin version</b> command again. If everything is working fine it's time to change the root password for your MySQL installation with (replace <i>new-password</i> in the command below with the new password of your choice):

<code>mysqladmin -u root password new-password</code>

Please, if this miniguide has was helpful to you, leave a comment. If there's an error in it also leave a comment so I can correct it. If you made it work differently please describe how you did it. As I'm an occasional Linux user I can't by far guarantee that my way was the best way to do it.
