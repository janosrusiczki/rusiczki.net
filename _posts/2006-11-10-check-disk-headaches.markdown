---
layout: post
status: publish
published: true
title: Check disk headaches
author: János
wordpress_id: 427
wordpress_url: http://www.rusiczki.net/wp/?p=427
date: !binary |-
  MjAwNi0xMS0xMCAwMDowMzoxNCArMDEwMA==
date_gmt: !binary |-
  MjAwNi0xMS0wOSAyMTowMzoxNCArMDEwMA==
categories:
- Technical
- Windows
tags: []
---
"Inserting an index entry into index $0 of file 25" - the message I feared for a week...

I don't know what happened but my storage drive (a 400 Gig Western Digital formatted as NTFS) attached via USB came up one day last week as "Local Disk" instead of "Titan" as I so aptly labeled it. Capacity and free space became 0 and it was dragging down my computer's overall speed big time. Somehow, with lots of patience I managed to schedule a Check Disk operation at startup and after a reboot and some preliminary stages the message I mentioned earlier appeared. And it appeared. And appeared. At least a few hundred times. And I could hear the drive crunching away happily. After a while I got bored and reset the computer. And when it booted I skipped the check. The good news was that I could see and read the contents of the drive from Windows but the bad news was I couldn't write or delete anything to or from it. The OS was complaining about permission issues.

Yesterday night I was really chilled so I thought hey, let's give it another shot. Searching the Microsoft support web site was about as helpful as a pat on the back but fortunately I found <a href="http://www.techspot.com/vb/all/windows/t-49454-Chkdsk-problems-after-Windows-reinstall--Deleting-Orphan-Files.html">a forum topic</a> started by a guy that seemed to have approximately the same problem as I did. At least the error message was the same. So I read through his experience and fortunately he posted a message after he managed to fix the issue (something many of us forget to do) and so I decided to reboot and let chkdsk complete. Better yet, I rebooted in safe mode, opened a command prompt window and run "chkdsk /f L:". I minimized the window because XP's screen refresh in safe mode is about as fast as on a 286. And there I was after a few minutes with my drive fully fixed.

So, what did we learn today kids? Let Check Disk do it's job, even if it seems to take forever and even if it looks like it entered an endless loop. Except when it completely brakes your drive...
