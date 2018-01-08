---
layout: post
title: SQL Dump File Splitter
date: 2007-01-24 14:02:39 +0100
categories:
- Technical
---
Scenario: You are a conscious user and you back up your site's database every once in a while. And you sit smiling and content knowing that your precious data is safe. Just to discover after disaster strikes that you can't restore the contents of the SQL dump file because of upload size limitations or because <a href="http://www.phpmyadmin.net/">phpMyAdmin</a> would run out of memory while decompressing the gzip / zip file.

In these cases there are two solutions at hand: if you have console access you can login and import the plain SQL file (which you previously uploaded via FTP) by typing a command like "mysql -uusername -ppassword &lt; dumpfile.sql" or if you only have access to phpMyAdmin you can open up a text editor and split the SQL file into smaller parts that can be uploaded sequentially. The problem si that if you have a larger dump file this can be a reeeaaaly time consuming job.

Today I encountered a problem like this. And since I had no console access and I was in no mood to lose a few precious hours splitting up a 40 meg file by hand I googled for "sql splitter" and I found a program called SQLDumpSplitter 2. Unfortunately the author's site was not working (and since I don't know any German I couldn't really figure out why) but I found an <a href="http://ep2.nl/topic/2138/">alternative download</a> on <a href="http://ep2.nl/">a dutch web developer forum</a>. And since that forum required to be a member to be able to download I thought I should offer yet another alternative download location without all those registration related mini headaches. Here on this site...

<a href="http://www.rusiczki.net/blog/blogstuff/SQLDumpSplitter.rar"><img alt="SQLDumpSplitter 2" src="http://www.rusiczki.net/blog/blogpics/sqldumpsplitter2.png" width="352" height="403" border="0" class="image"/></a>

So here it is ladies and gentlemen: <a href="http://www.rusiczki.net/blog/blogstuff/SQLDumpSplitter.rar">download SQLDumpSplitter 2</a> (or <a href="http://www.rusiczki.net/blog/blogstuff/SQLDumpSplitter.zip">zip compressed</a>). All credits for writing this program go to Philip Lehmann-B&ouml;hm (<a href="http://www.philiplb.de">http://www.philiplb.de</a>).

**Update (almost 8 years later on November 7, 2014)**: Since this is by far the most popular post on this blog, I believe it deserves an update.

If you're having problems with SQLDumpSplitter 2 please have a look at the following resources (picked from your super helpful comments):

* [BigDump: Staggered MySQL Dump Importer](http://www.ozerov.de/bigdump/) - Imports large and very large MySQL dumps (like phpMyAdmin dumps) even through web servers with hard runtime limits and those in safe mode. The script imports only a small part of the huge dump and restarts itself. The next session starts where the last one left off.
* [SQL splitter](http://codesnap.blogspot.com/2011/07/sql-splitter.html) - A PHP script to split your SQL file into an array. Note that you'll probably need PHP installed locally and configured pretty loosely (with high memory limit) to be able to process large SQL dumps with this script.</li></ul>

If you found this post useful be sure to check out the books below:

<iframe src="http://rcm-uk.amazon.co.uk/e/cm?t=kits-21&o=2&p=8&l=as1&asins=0596101716&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=FF0000&bc1=FFFFFF&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe> <iframe src="http://rcm-uk.amazon.co.uk/e/cm?t=kits-21&o=2&p=8&l=as1&asins=0672329387&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=FF0000&bc1=FFFFFF&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe> <iframe src="http://rcm-uk.amazon.co.uk/e/cm?t=kits-21&o=2&p=8&l=as1&asins=059652708X&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=FF0000&bc1=FFFFFF&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe> <iframe src="http://rcm-uk.amazon.co.uk/e/cm?t=kits-21&o=2&p=8&l=as1&asins=0596006306&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=FF0000&bc1=FFFFFF&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>
