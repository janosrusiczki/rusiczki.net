---
layout: post
title: Nokia 6070 - USB infrared dongle - Now best buddies
date: 2006-09-27 23:08:19 +0200
categories:
- Technical
---
<img src="https://content.rusiczki.net/blogpics/usb-infrared-dongle.jpg" width="510" height="99" alt="My infrared dongle" class="image" />

I surprised Ioana today with a shiny new <a href="http://www.nokia.com/phones/6070">Nokia 6070</a>. Yep, I'm a nice guy... :-)

Obviously one of the first things I tried after putting my paws on the phone (hehe - there was a new gadget in the house after all!) was to upload some short MP3 clips to test out it's MP3 ringtone capability. But to my disappointment my USB IrDA dongle was behaving miserably making the tests rather frustrating. It was whether complaining about range problems although the dongle was less than 1 centimeter from the phone's port whether the transfer was locking up in a purely random way. It was clear that something wasn't right just by looking at the dongle's activity LED which was blinking rather seldomly as opposed to the way it used to when it was transferring photos or ringtones to or from my good old <a href="http://www.sonyericsson.com/T610/">Sony-Ericsson T610</a>. I did succeed in transferring a 100 kilobyte file once but the cost was a few minutes (3 or 4) of wait. So I started digging in the dongle's config and after a few minutes of messing around I found the (rather easy) solution.

Here's what to do if you get miserable transfer speeds between your handheld device and your computer's (USB) infrared port.

1. After a connection is estabilished between the device and your computer right click on the icon in your tray and select "Properties" (<a href="https://content.rusiczki.net/blogpics/irda-config-step-1.php" onclick="window.open('https://content.rusiczki.net/blogpics/irda-config-step-1.php','popup','width=193,height=120,scrollbars=no,resizable=no,toolbar=no,directories=no,location=no,menubar=no,status=no,left=0,top=0'); return false">Screenshot</a>).

2. In the window that appears click the "Hardware" tab and then click on the "Properties" button (<a href="https://content.rusiczki.net/blogpics/irda-config-step-2.php" onclick="window.open('https://content.rusiczki.net/blogpics/irda-config-step-2.php','popup','width=367,height=450,scrollbars=no,resizable=no,toolbar=no,directories=no,location=no,menubar=no,status=no,left=0,top=0'); return false">Another screenshot</a>).

3. Another window will pop up. Click the "Advanced" tab and for the "Infrared Transceiver Type" property set the value from the default "SigmaTel 4012" to "SigmaTel 4000" (<a href="https://content.rusiczki.net/blogpics/irda-config-step-3.php" onclick="window.open('https://content.rusiczki.net/blogpics/irda-config-step-3.php','popup','width=404,height=455,scrollbars=no,resizable=no,toolbar=no,directories=no,location=no,menubar=no,status=no,left=0,top=0'); return false">The last screenshot</a>).

4. Close the windows by clicking their OK buttons and that's about it. Now your phone will speedily talk with your computer via the magic of infrared and you will transfer files like crazy... Or at least as fast as the infrared port permits.

I hope this entry will help somebody out there.
