---
layout: post
title: MacAdSensePlus - An AdSense monitoring widget for your Mac's Dashboard
date: 2007-11-08 13:05:28.000000000 +01:00
categories:
- technical
- mac
---
<img src="https://content.rusiczki.net/blogpics/macadsenseplus-first-version.png" width="191" height="294" alt="MacAdSensePlus screenshot" class="postimage"/>

I just released the second public version of this widget which includes a bug fix related to incorrect reporting for weeks spanning 2 months and a debug mode which is turned on by default... But let's start at the beginning, shall we?

First the description: MacAdSensePlus is a Dashboard widget that conveniently displays your Google AdSense earnings and click count for today, yesterday, the current and last week as well as for the current and the last month.

This is my first effort at writing a Dashboard widget and since I didn't want to start from scratch I set out to modify <a href="http://blog.oswaldism.de/macadsense-simple-adsense-widget-for-mac-os-x">MacAdSense</a> which was already out there, was written in PHP (yey!) but was showing too little info for my tastes. So I sat down on one gloomy weekend after Ioana's grandfather passed away and started tweaking it as needed. As of version 0.2 I still can't consider it fully ready as the it's icon for example still belongs to the original MacAdSense but I'm pushing forward as fast as I can and I'm not a graphic artist either.

The main thing I'm missing now are testers. Testers who can provide me with feedback. And the debug file. So I can see what's wrong and why does it display only zeros for some people. I won't start implementing new features (like the suggested currency conversion) until I'm not convinced that it grabs the basic data for everyone. Here are some stats for now: works for 3 AdSense accounts of which 2 were tested by me. Reportedly doesn't work for 2 but there might be others that downloaded it after my "post about it on every Mac forum" campaign and never bothered reporting back if it works or not. Grrr.

Anyway, <a href="http://www.rusiczki.net/macadsenseplus/releases/MacAdSensePlus.0.2.wdgt.zip">download version 0.2</a> and test it out. Requirements are Mac OS X 10.4 or later and an AdSense account that's making some money. And most importantly, remember kids, if you download it, whether it works or not feedback is <strong>essential</strong>. Use the comments Luke!
