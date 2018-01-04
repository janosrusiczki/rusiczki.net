---
layout: post
title: Banning the Turkish spammers from your Aardvark Topsites
date: 2006-10-24 21:19:50 +0200
categories:
- Technical
---
<p>I knew something weird was going on when my client's dedicated server slowed down considerably and a rather large forum he was hosting on it started throwing MySQL errors that were landing frequently in my Yahoo! inbox. So I headed out and did some sniffing around and finally by using the elimination technique (not too smart nor professional, I know) I concluded that the resource hog was his top site (that was based on <a href="http://www.aardvarktopsitesphp.com/">Aardvark Topsites</a>). I asked him about it and he said that he banned quite a few sites about a week ago from the top site administration area but further investigation revealed that the buttons / banners were still being loaded and each hit on a button resulted in quite a few SQL queries. And these guys were loading those buttons like crazy, probably in some automated way, to get their stats up.<br />
So, the solution seemed quite straightforward. The hits that contain certain domains in their referrers should be prevented to even access the .php script that runs the SQL queries (button.php). And that ladies and gentlemen is done by using the magic of .htaccess.<br />
So after some googling I discovered that I just need to add an .htaccess file to the root of the top site. It contains the following:</p>
<blockquote><pre>RewriteEngine On
RewriteCond %{HTTP_REFERER} soyle [NC,OR]
RewriteCond %{HTTP_REFERER} sohbet [NC,OR]
RewriteCond %{HTTP_REFERER} kelebek [NC,OR]
RewriteCond %{HTTP_REFERER} linkzinciri [NC,OR]
RewriteCond %{HTTP_REFERER} mirc [NC,OR]
RewriteCond %{HTTP_REFERER} komixs [NC,OR]
RewriteCond %{HTTP_REFERER} asksokagi [NC,OR]
RewriteCond %{HTTP_REFERER} pornocular [NC,OR]
RewriteCond %{HTTP_REFERER} chatmatik [NC,OR]
RewriteCond %{HTTP_REFERER} bizimmekan [NC]
RewriteRule .* - [F,L]</pre>
</blockquote>
<p>Of course you can add as many banned keywords as you wish by simply copy - pasting a RewriteCond line. The [NC,OR] at the end of almost each line means that the condition is case insensitive (NC) and that the following condition should be considered as an alternative (OR) - so the web server interprets it something like "if soyle or sohbet or kelebek or ... is found in the referrer do what RewriteRule instructs you to do". Note that the last condition doesn't have the 'or' part.<br />
I hope this will help some people out there having the same problems we had with those scum bags stealing their valuable server resources. And don't forget to leave a comment.<br />
<b>Update:</b> After posting this entry I did some more googling and found that others had the exact same problem. You might want to check <a href="http://www.jimwestergren.com/stop-the-topsites-spam/">Jim's solution</a> too, it's only slightly different than mine. There's also yet another <a href="http://www.jimwestergren.com/stop-the-topsites-spam/#comment-23193">alternate solution</a> in the comment's of that entry. It sure looks like those spammers caused many webmasters real problems.</p>
