---
layout: post
title: SQL Dump File Splitter
date: 2007-01-24 14:02:39 +0100
categories:
- Technical
---
**IMPORTANT** [SQLDumpSplitter has been updated to version 3](https://philiplb.de/sqldumpsplitter3/) which is multiplatform (Windows / Mac / Linux). [See my second update below.](#second-update-december-28-2018)

---

Scenario: You are a conscious user and you back up your site's database every once in a while. And you sit smiling and content knowing that your precious data is safe. Just to discover after disaster strikes that you can't restore the contents of the SQL dump file because of upload size limitations or because [phpMyAdmin](http://www.phpmyadmin.net/) would run out of memory while decompressing the gzip / zip file.

In these cases there are two solutions at hand: if you have console access you can login and import the plain SQL file (which you previously uploaded via FTP) by typing a command like "mysql -uusername -ppassword < dumpfile.sql" or if you only have access to phpMyAdmin you can open up a text editor and split the SQL file into smaller parts that can be uploaded sequentially. The problem si that if you have a larger dump file this can be a reeeaaaly time consuming job.

Today I encountered a problem like this. And since I had no console access and I was in no mood to lose a few precious hours splitting up a 40 meg file by hand I googled for "sql splitter" and I found a program called SQLDumpSplitter 2\. Unfortunately the author's site was not working (and since I don't know any German I couldn't really figure out why) but I found an [alternative download](http://ep2.nl/topic/2138/) on [a dutch web developer forum](http://ep2.nl/). And since that forum required to be a member to be able to download I thought I should offer yet another alternative download location without all those registration related mini headaches. Here on this site...

[![SQLDumpSplitter 2](https://content.rusiczki.net/blogpics/sqldumpsplitter2.png)](https://content.rusiczki.net/blogstuff/SQLDumpSplitter.rar)

So here it is ladies and gentlemen: [download SQLDumpSplitter 2](https://content.rusiczki.net/blogstuff/SQLDumpSplitter.rar) (or [zip compressed](https://content.rusiczki.net/blogstuff/SQLDumpSplitter.zip)). All credits for writing this program go to Philip Lehmann-Böhm ([http://www.philiplb.de](http://www.philiplb.de)).

## Update (almost 8 years later on November 7, 2014)

Since this is by far the most popular post on this blog, I believe it deserves an update.

If you're having problems with SQLDumpSplitter 2 please have a look at the following resources (picked from your super helpful comments):

* [BigDump: Staggered MySQL Dump Importer](http://www.ozerov.de/bigdump/) - Imports large and very large MySQL dumps (like phpMyAdmin dumps) even through web servers with hard runtime limits and those in safe mode. The script imports only a small part of the huge dump and restarts itself. The next session starts where the last one left off.
* [SQL splitter](http://codesnap.blogspot.com/2011/07/sql-splitter.html) - A PHP script to split your SQL file into an array. Note that you'll probably need PHP installed locally and configured pretty loosely (with high memory limit) to be able to process large SQL dumps with this script.

## Second Update (December 28, 2018)

So I've been hosting this file for almost 12 years now and this morning I received a comment:

![Philip's Comment](https://content.rusiczki.net/2018/12/philips-comment.png)

[**There's an update for SQLDumpSplitter!**](https://philiplb.de/sqldumpsplitter3/) Which is now multiplatform!

Also while checking [Philip's site](https://www.philiplb.de) I noticed that he [mentions](https://www.philiplb.de/sqldumpsplitter2/2016/01/25/a-glimpse-from-the-past-the-sql-dump-splitter/) that I'm still hosting the program which he wrote in 2002(!). I consider this a nice nod as this blog of mine might not be the most active for some years now but it sure is persistent. :-)
