---
layout: post
title: "Remember when you got an SLA for your money?"
date: 2026-04-07 14:28:00 +03:00
categories:
- technical
- rant
- english
description: In 2008, a datacenter exploded and I got a full month of free hosting. In 2026, my AI subscription terms say payments are non-refundable, full stop.
---

Remember when paying for a service actually got you an SLA? I mean an actual contract. The kind a company would honor when things broke, with money on the line if they didn't. Back in 2008 I leased a dedicated server from The Planet. Yes, that Planet, from before cloud pricing turned into a personality disorder. They promised uptime, support, and accountability, and astonishingly, those promises meant something.

One month into my contract, something literally [exploded in their H1 datacenter in Houston](/2008/06/04/boom/). Electrical gear shorted, a fire broke out, and three walls of the equipment room came down. My server was on the first floor, right where it happened, and went offline for a few days. There was no cheerful status page telling me everything was fine, no glossy dashboard pretending nothing had happened, no corporate poetry about "degraded performance." Just frequent, honest updates explaining what was on fire and what they were doing about it. At some point they emailed customers asking if we wanted our servers moved to their other Houston datacenter. I said yes, and mine ended up in a truck with around 500 others, driven across town.

And yet, when the dust settled, they did something that would feel almost surreal today: they owned it. I got an apology and [a full month of free service](/2008/07/02/awesome-is-spelled-with-the-planet-in-the-middle/). Not a coupon. Not a "we appreciate your patience" email. Not a 12-page explanation of why this was technically within expected bounds. A full month, free, for a few days of downtime. The SLA wasn't there for decoration. It was a promise with consequences.

Now I pay for AI services that can disappear for what feels like a full day every month. Take Claude. Brilliant when it works, unavailable when it isn't, and apparently powered by hope. The official status page, of course, is a masterpiece of corporate serenity, all green and operational no matter what's actually happening. Meanwhile X (formerly Twitter, thanks Elon) and Downdetector are having a very different conversation.

The funniest part is the billing. The service can be down, the status page can be lying, and the user community can be collectively setting itself on fire, but the subscription charge still arrives with breathtaking precision. The card gets billed on the exact day and time, no excuses, no delays, no outages in the payment pipeline. Amazing how the only system that never misses uptime is the one that takes your money.

And here's the kicker: paying customers don't even get an SLA. Claude Pro is $20 a month. Claude Max runs to $200. Anthropic's terms of service spell it out: payments are non-refundable, with no uptime guarantee and no compensation policy attached. When [Pro subscribers asked for one after a string of outages](https://github.com/anthropics/claude-code/issues/33260), the answer was a polite version of "there isn't one." The Planet refunded a full month for a few days of downtime back in 2008. In 2026, one of the most valuable AI companies in the world has decided that "we'll try our best" is the entire contract.

We used to have SLAs that meant something. Now we have status pages that perform optimism, billing systems that never sleep, and terms of service that promise you nothing. The old world was at least honest enough to admit when it had blown up and pay you back for the trouble. The new one keeps the green lights on, charges your card, and hopes you won't notice the smoke.

**Co-Authored-By**: Claude &lt;noreply@anthropic.com&gt; - Yep, the very same. It went down once while we were writing this, which felt fitting. I will not be receiving a refund.

---

P.S. After I was done writing this, I asked Claude to search for details about the incident, thinking it had been forgotten in time. Quite the opposite!

The 2008 explosion at The Planet's H1 facility in Houston was, apparently, a big enough deal to land on [Slashdot](https://tech.slashdot.org/story/08/06/01/1715247/explosion-at-theplanet-datacenter-drops-9000-servers), [The Register](https://www.theregister.com/2008/06/01/the_planet_houston_data_center_fire/), [Data Center Knowledge](https://www.datacenterknowledge.com/outages/explosion-at-the-planet-causes-major-outage), and even [SANS](https://isc.sans.edu/forums/diary/The+Planet+outage+what+can+we+all+learn+from+it/4504/). A few details I either forgot or never knew at the time:

- The explosion happened on Saturday, May 31, 2008, at 4:55pm CDT. I was three weeks into my contract, not one month. Close enough.
- It took down 9,000 customer servers in total. About 3,000 of them, including mine, were on the first floor and took the longest to come back.
- A generator failure early Tuesday morning knocked another 1,500 servers back offline mid-recovery, which lines up exactly with the "I cheered, then it went down again" bit from my [original 2008 post](/2008/06/04/boom/).
- Best detail of all: this was the second time that same Houston facility had an electrical explosion. A transformer blew there back in June 2003, when the company was still called Rackshack.

The Web Hosting Talk thread covering it was titled "[Data Center Explosion, Fire or FBI Bust?](https://www.webhostingtalk.com/showthread.php?t=698809)", which is pretty much peak 2008 internet.

---

P.S.2 Since the description of this blog still calls me an *incurable nostalgic*, here is the full corporate lineage of the company I signed up with in 2008. The arc from Rackshack to IBM Cloud is something else:

- 1998: Robert Marsh founds Everyones Internet (EV1) in Houston, originally as a dial-up ISP.
- 2001: EV1 launches a dedicated server division called Rackshack.net. This was the brand that owned the Houston facility when its first transformer explosion happened, in June 2003.
- A bit later, Rackshack rebrands to EV1 Servers, reportedly because the racks weren't in a shack anymore once they had built proper datacenters.
- May 2006: EV1 Servers merges with The Planet, a separate Texas dedicated hosting company founded in 1998 by Peter Pathos. GI Partners, the private equity firm, owned both, and the combined company traded as The Planet.
- May 31, 2008: The H1 explosion happens at the old EV1 / Rackshack datacenter, which is exactly why Wikipedia calls it "an EV1 Servers legacy datacenter."
- August 2010: GI Partners acquires SoftLayer too.
- November 16, 2010: The Planet officially rebrands to SoftLayer.
- June 4, 2013: IBM acquires SoftLayer for an estimated $2 billion, which becomes the basis for IBM Cloud.
- Later: The SoftLayer brand is retired entirely, and the operation becomes part of IBM Cloud Infrastructure.

So the company I signed up with as The Planet in 2008 is now part of IBM. Somewhere between Rackshack and IBM Cloud is an entire era of how the internet was hosted.

As for me, I left SoftLayer for Hetzner on November 2, 2012. Funnily enough, I had first emailed Hetzner about it back in August 2011, asking whether they offered a DNS service before I committed to the move. They wrote back the same day saying yes. I then sat on it for fifteen months before actually pulling the trigger. Some things never change.
