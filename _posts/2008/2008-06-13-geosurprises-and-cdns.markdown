---
layout: post
title: Geosurprises and CDNs
date: 2008-06-13 08:37:33 +0200
categories:
- Web
- Technical
---
<img src="https://content.rusiczki.net/blogpics/firefox-status-bar.png" width="500" height="53" border="0" alt="Firefox Status Bar with Flagfox" class="image"/>

A few days ago, out of sheer geek / webmaster / wannabe server administrator curiosity I installed the <a href="https://addons.mozilla.org/en-US/firefox/addon/5791">Flagfox add-on</a> for Firefox which shows the flag of the country where the server that's hosting the displayed site is located.

There weren't many surprises as the flag is mostly stuck on the <a href="http://images.google.com/images?q=star+spangled+banner">Star Spangled Banner</a> but this morning I've noticed something strange. When the browser opened <a href="http://www.netvibes.com">Netvibes</a>, which has been my homepage for more than a year now, I've glanced at the flag and I saw Romania. What? Tracing the IP lead to the following host: a1110.b.akamai.net. Ahaaa! <a href="http://www.akamai.com/">Akamai</a>! So that's why Netvibes loads as if it was hosted on my LAN. Funnily enough the Romanian IP is traced over more hops (18) than the French one (13).

Another "surprise" was en.wikipedia.org resolving to an IP in the Netherlands.

Talking about CDNs (Content Delivery Networks) I remembered about an interesting article I read a few days ago: <a href="http://www.digitalistic.com/2008/06/09/10-easy-steps-to-use-google-app-engine-as-your-own-cdn/">10 Easy Steps to use Google App Engine as your own CDN</a>. And another one I found recently: <a href="http://code.google.com/apis/ajaxlibs/">AJAX Libraries API</a>. Google, the poor man's CDN.
