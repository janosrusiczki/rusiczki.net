---
layout: post
title: Unicode annoyances
date: 2004-12-17 18:59:54 +0100
categories:
- Technical
---
I'm trying to hack together a small and simple search engine for the (not so) few Romanian RSS and Atom feeds that exist today. But the special characters are killing me slowly and painfully.

For starters <a href="http://bucovina.chem.tue.nl/page_8.htm">here's a well documented page with the Romanian alphabet using the correct Unicode characters</a>. Looks nice on Firefox but when you load it Microsoft's one and only browser some of the special characters get replaced with nice empty boxes. In times like this I wish I could scream like that guy from Two Stupid Dogs: "Now, ain't that cute? BUT IT'S WRONG!"

To make it simple: <strong>Q:</strong> What do you get when you mix together a powerful Redmond based company and the Romanian alphabet? <strong>A:</strong> An incorrect Romanian alphabet. I wish to remind everyone that we're not Turkish, our "sh" sound is written using a "<a href="http://www.eki.ee/letter/chardata.cgi?ucode=0219">letter s with  comma below</a>" not a "<a href="http://www.eki.ee/letter/chardata.cgi?ucode=015F">letter s with cedilla</a>" even if we see this error in almost every document we read on- or offline. I'm referring here to offline documents produced by the almighty MS Word which everybody in Romania uses, because at least the publications (or most of them) use the right version of the letter and I guess this is because they're edited on Macs using Adobe products. But I trailed off...

What I actually wanted to do in my project was to convert malformed Romanian characters to their proper counterparts when fetching and storing a feed entry. But what's the use if the dominant operating system and browser out there favor the malformed version? The conclusion is that I'll do it like this anyway because this is a hobby level project and I'll eventually make some conversions again when extracting the data... At least my database will contain proper Unicode and I'll have my peace of mind.
