---
published: false
---
I've finally built a photo gallery for myself! But first, a bit of history...

I was always passionate about photography and one of the most important moments of my life was [getting my first digital camera](https://www.rusiczki.net/2012/05/17/aventuri-in-fotografia-digitala/), so almost immediately after I started this blog I wanted my own photo gallery. And checking The Internet Archive reminded me that I actually had a gallery section here on the site and I also have [a 20+ year old post about customizing Gallery](https://www.rusiczki.net/2003/02/19/gallery/). I vaguely remember trying out that web app to upload some of my photos but I also remember it left a lot to be desired, back then I wanted things to integrate with the layout of the blog as tightly as possible and Gallery was not suitable for that.

Then I discovered [Flickr](https://www.flickr.com/) which was among the first Web 2.0 sites I started using. It was my first social network where I met and interacted with people I didn't know from before, who were also passionate about their photos and / or photography in general. [I uploaded my first photo at the begining of 2005](https://photos.rusiczki.net/photos/4555559) and used the site very moderately at first as there was a 200 photos limit on the free accounts and the Pro option was unobtainable because PayPal wasn't available in Romania at that time. Then I convinced my French client for whom I was working back then to get me a Pro account, and the real fun started.

Those were some glory years and although I was still active here on the blog, I was running sort of a photo blog over there. The nice thing about Flickr was the userbase who would find your photos and interact with you and viceversa, you would find their photos and interact with them. There are [tons of mentions of the site around here](https://www.rusiczki.net/search/?janosrusiczki%5Bquery%5D=flickr) and I had a sidebar with my latest photos integrated in both [the first version of the blog](https://content.rusiczki.net/2023/05/weblog-screenshot-2009-01-24.png){:.glightbox} as well as [the one running on Wordpress](https://content.rusiczki.net/2022/12/weblog-screenshot-2009-04-10.png){:.glightbox}.

They were acquired by Yahoo! quite early on and it was all fine in the beginning (I didn't mind switching to a Yahoo! based login - I was using Yahoo! Messenger and Yahoo! Mail anyway) but then they started lagging behind the new platforms which were popping up once smartphones became ubiquitous. At first Facebook wasn't much of a competition when it came to photo sharing, but once Google Plus challenged them with superior photo quality they quickly caught up. Then obviously part of Flickr's userbase fled the site, some leaving for Facebook, some for Google Plus, some for Instagram... Starting at one point the site entered a stale phase turning into a real ghost town and finally, many years later, [it was acquired by SmugMug](https://techcrunch.com/2018/04/20/smugmug-acquires-flickr/) who made it clear from the beginning that they were profit oriented and will not keep the free and unlimited offering around. As I had a pretty consistent library of photos uploaded I was sure that I wouldn't be meeting anything near a free tier limit, if that would be available at all. This was the point when I used their exporter tool and got myself an archive with all of my photos and the rest of the metadata (photo information, tags, comments, etc).

This archive sat around for a while until the autumn of 2020 when I started working on some importer scripts and a general database structure to accomodate the data.

This was the start of Photonia.

Once I was done with that, I concentrated my efforts to develop a web application that would display the imported photos and once I had that done, I thought I'd put it out there. This was the most barebones site of my life which went into production because once I have decided on the URL structure I just wanted search engines to start indexing. I'm not sure when was the exact date when I went online with the site, the Internet Archive's first snapshot is from November 29, 2020.

Challenges:

- I have decided early on that I will store the photos on S3
- Then I got the idea that maybe I should upload all my archive and I wanted it to be tagged automatically. I first wanted to use clarifai for computer vision but then Emil asked me that since I have my photo files stored on S3 why am I not using Amazon Rekognition?
- Searching (Fulltext search in PostgreSQL)
- The transition to VueJS
- Logging in through GraphQL

What's next:

- It's still not an MVP, there are many things missing, even essential ones such as managing tags and albums
- Allow signing up and commenting via email or your favorite social network
- Try to integrate ActivityPub
