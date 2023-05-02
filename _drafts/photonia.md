---
published: false
---
I was always passionate about photography and one of the most important moments of my life was [getting my first digital camera](https://www.rusiczki.net/2012/05/17/aventuri-in-fotografia-digitala/) so almost immediately after I started this blog I wanted my own photo gallery. And checking The Internet Archive I noticed that I actually had a gallery section here on the site and I also have [a 20+ year old post about customizing Gallery](https://www.rusiczki.net/2003/02/19/gallery/). I vaguely remember trying out that web app to upload some of my photos but I also remember it left a lot to be desired, back then I wanted things to integrate with the layout of the blog as tightly as possible and Gallery was not suitable for that.

Then I discovered [Flickr](https://www.flickr.com/) which was perhaps the first Web 2.0 site I started using. And I was actually deeply fascinated by it and I used it heavily in its glory days, pre-Facebook. It was my first social network where I met and interacted with people I didn't know from before, who were also passionate about their photos and / or photography in general. [I uploaded my first photo at the begining of 2005](https://photos.rusiczki.net/photos/4555559) and used the site very moderately at first as there was a 200 photos limit and the Pro option was unobtainable because PayPal wasn't available in Romania at that time. Then I convinced my French client whom I was working with back then to get me a Pro account and the real fun started.

As I said there were some glory years and although I was still active here on the blog, I was running sort of a photo blog over there. As I said, the nice thing was the userbase who would find your photos and interact with you. And viceversa, you would find their photos and interact with them. There are [tons of mentions of Flickr around here](https://www.rusiczki.net/search/?janosrusiczki%5Bquery%5D=flickr), I know I had a sidebar with my latest Flickr photos integrated in both the first version of the blog as well as the one running on Wordpress.

Flickr was acquired by Yahoo! quite early and it was all fine in the beginning but then they started lagging behind the new platforms which were popping up once smartphones became ubiquitous. At first Facebook wasn't much of a competition when it came to photo sharing, but once Google Plus challenged them with superior photo quality they quickly caught up. Then obviously part of Flickr's userbase fled the site, some leaving for Facebook, some for Google Plus, some for Instagram... Starting at one point the site entered a stale phase turning into a real ghost town and finally, years later, [it was acquired by SmugMug](https://techcrunch.com/2018/04/20/smugmug-acquires-flickr/) who made it clear from the beginning that they were profit oriented and will not keep the free and unlimited offering around - and as I had a pretty consistent library of photos uploaded I was sure that I wouldn't be meeting anything near a free tier limit, if that would be available at all. This was the point when I used their exporter tool and got myself the archive of all my photos and the rest of the metadata (photo information, tags, comments, etc).

This archive sat around for a while and then at one point in the autumn of 2020 I started working on some importer scripts and a general database structure to accomodate the data. This was the start of Photonia.

Once I was done with that, I concentrated my efforts to develop a webapp that would display the imported photos and once I had that done, I thought I'd put it out there, give some food for Google to index. I'm not sure when was the exact date when I went online with the site, the Internet Archive's first snapshot is from November 29, 2020.

Challenges:

- Searching
- Logging in through GraphQL

What's next:

- It's still not an MVP, there are many things missing, such as managing tags and albums
- Allow signing up and commenting via email or your favorite social network
- Try to integrate ActivityPub
