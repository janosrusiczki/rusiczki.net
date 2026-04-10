---
layout: post
title: Retragerea popupurilor vechi
date: 2026-04-10 00:58:58 +03:00
categories:
  - blog history
  - technical
description: Am descoperit (și curățat) 28 de articole vechi care încă mai aveau popupuri JavaScript rămase din era Movable Type.
---
Continuând șirul de [curățenii prin curtea blogului](https://www.rusiczki.net/2026/04/09/alte-mici-modificari-adio-disqus/) pornit ieri cu despărțirea de Disqus, m-am uitat azi la o chestie care mă sâcâia de demult: popupurile vechi. În epoca în care blogul rula pe [Movable Type](https://www.rusiczki.net/2009/04/02/keeping-up-with-the-times/), pozele mai mari le afișam într-o ferestruică pop-up care sărea pe ecran la click. Elegant pentru 2002, jalnic pentru 2026: nu mai funcționează pe telefoane, iar pe desktop se deschid ca un simplu tab. De altfel, popup-urile au căzut din grație destul de repede — prin 2004, chiar și Internet Explorer 6 SP2 își primea popup blocker-ul nativ (Firefox îl avea de doi ani, Opera de patru), iar utilizatorii învățau să le blocheze din reflex. Eu continuam totuși, inocent, să le folosesc pentru pozele mele.

L-am rugat pe [Claude](https://claude.ai/) să-mi facă un inventar și a scos la iveală 28 de articole cu astfel de popupuri — împreună cu 50 de pagini de ambalaj și 32 de thumbnail-uri care acum nu mai au niciun rost. Le-am curățat pe toate: thumbnail-urile au fost înlocuite cu pozele mari afișate direct în articol, iar linkurile text deschid pozele într-un lightbox modern.

Ce mi se pare amuzant e că popup-urile au supraviețuit atât migrării de la Movable Type la Wordpress în 2009, cât și [celei de la Wordpress la Jekyll în 2018](https://www.rusiczki.net/2018/01/08/a-new-blogging-engine/) — deși cu ocazia asta am rulat niște scripturi de curățat care reparau link-uri moarte, formatarea stricată și mutau asset-urile pe noul CDN. Popup-urile au trecut neobservate încă 8 ani, inclusiv de mine.

Pe parcursul curățeniei m-am reîntâlnit cu câteva articole care mi-au stors câteva suspinuri nostalgice.

În [T Six Ten](https://www.rusiczki.net/2004/05/05/t-six-ten/) povestesc trecerea la Sony Ericsson T610 — pentru cine nu-l mai ține minte, un baton cu ecran color de 65.000 de culori, cameră, Bluetooth, infraroșu și fabuloșii 2 MB de memorie pentru poze, teme și jocuri. Mă citesc acum și mă amuz cum mă lăudam că pot trimite email-uri prin GPRS la doar 2 cenți bucata, mult mai ieftin decât un SMS — un adevărat early adopter.

[Need for Speed: Underground](https://www.rusiczki.net/2003/12/06/need-for-speed-underground/) și [You know you've been...](https://www.rusiczki.net/2004/08/26/you-know-youve-been/) sunt două ode la zilele în care pierderea de timp în fața calculatorului era o artă. În primul mă plâng că m-a durut degetul mijlociu de la butonul de accelerație, iar în al doilea confirm că pe Transport Tycoon l-am pornit la ora 2 după masă ca "să văd ceva" și la 8 seara mă uitam la desktop întrebându-mă unde dispăruse ziua.

[Palit Daytona Geforce 4 Ti 4200 (2002–2004)](https://www.rusiczki.net/2004/08/27/palit-daytona-geforce-4-ti-4200-2002-2004/) e un mic obituar pentru placa video care și-a dat duhul în vara lui 2004 încercând să ruleze Doom 3. Update-ul din final ("de fapt, uitasem să conectez ventilatorul") încoronează toată drama. Acum două decenii toți aveam o relația asta intimă cu hardware-ul.

În [It's beginning to look good!](https://www.rusiczki.net/2003/01/06/its-beginning-to-look-good/) (ianuarie 2003) și [I wanted it? Here it is!](https://www.rusiczki.net/2004/01/20/i-wanted-it-here-it-is/) (ianuarie 2004), publicate la aproape un an distanță, mă regăsesc implorând cerul să ningă ca să pot scoate snowboard-ul. *"Please please please. If only a week of boarding. I'll be there. Day by day. 6 hours. As much as I can. Just a little snow. Pleeease!"* Tânărul care imploră pentru iarnă e același om care se bucură și azi când vede primii fulgi.

La [Cavnic](https://www.rusiczki.net/2004/02/21/snowboarding-trip/) descriu prima mea zi serioasă de snowboard — inclusiv cățăratul pe jos după ce am căzut de pe ski-liftul care *"was designed for them not boarders"*. [Trei ani mai târziu](https://www.rusiczki.net/2007/02/08/snowboard-report-for-the-first-weekend-of-february-2007/) revin pe aceleași pârtii, de data asta pe Roata, cu un ton ceva mai așezat și mai puține căzături spectaculoase. Aceeași bucurie, mai mult kilometraj în picioare.

Cronica TM04Base, festivalul de muzică electronică de la Timișoara, s-a întins de fapt pe trei articole — [partea 1](https://www.rusiczki.net/2004/10/19/another-edition-is-over-part-1/), [partea 2](https://www.rusiczki.net/2004/10/28/another-edition-is-over-the-late-part-2/) și [partea 3](https://www.rusiczki.net/2004/11/01/another-edition-is-over-the-not-so-late-part-3/) — și îmi amintesc încă efortul considerabil de a descrie minut cu minut seturile lui Deekline, The Ragga Twins, Jay Cunning, D-Bridge și trupei Suie Paparude. Scena de drum'n'bass și breakbeat din România de acum 20 de ani, surprinsă în timp real de un Rusiczki de 25 de ani.

Lupta cu spam-ul e un fir roșu prin toată arhiva aceea. În [Less spam. A better life.](https://www.rusiczki.net/2003/03/22/less-spam-a-better-life/) descopăr SpamAssassin prin SAProxy pentru Windows și sunt amuzat că softul notează fiecare email cu un "punctaj de spam". Doi ani mai târziu, în [Google ads and even more spam](https://www.rusiczki.net/2005/02/12/google-ads-and-even-more-spam/), mă bucur că plug-in-ul MT-Blacklist blocase deja peste 1000 de comentarii spam — dar mă plâng că spammerii migraseră între timp la referer log spam, tot cu poker, viagra, cialis și cazinouri. Aceleași bătălii ale webmaster-ului, mereu.

Și o capsulă de timp din martie 2003: [Saddam and Bush IRC-ing](https://www.rusiczki.net/2003/03/23/saddam-and-bush-irc-ing/), trei rânduri publicate exact când începea Războiul din Golf II. În loc de comentarii politice, linkam un *screenshot* amuzant cu Bush și Saddam conversând pe IRC. În 2003 Internet-ul încă avea timp să facă mișto de războaie în cheie ASCII.

Iată lista completă:

**2002**

- [3... 2... 1...](https://www.rusiczki.net/2002/12/23/3-2-1/)
- [Yuppeee! It's Christmas!](https://www.rusiczki.net/2002/12/24/yuppeee-its-christmas/)

**2003**

- [It's beginning to look good!](https://www.rusiczki.net/2003/01/06/its-beginning-to-look-good/)
- [Huh!?](https://www.rusiczki.net/2003/01/07/huh/)
- [Good cats](https://www.rusiczki.net/2003/01/09/good-cats/)
- [Fun!](https://www.rusiczki.net/2003/02/07/fun-2/)
- [Less spam. A better life.](https://www.rusiczki.net/2003/03/22/less-spam-a-better-life/)
- [Saddam and Bush IRC-ing](https://www.rusiczki.net/2003/03/23/saddam-and-bush-irc-ing/)
- [My next gadget](https://www.rusiczki.net/2003/04/23/my-next-gadget/)
- [Advance deal](https://www.rusiczki.net/2003/10/08/advance-deal/)
- [Need for Speed: Underground](https://www.rusiczki.net/2003/12/06/need-for-speed-underground/)

**2004**

- [I wanted it? Here it is!](https://www.rusiczki.net/2004/01/20/i-wanted-it-here-it-is/)
- [More advantages of the PlayStation 2](https://www.rusiczki.net/2004/02/09/more-advantages-of-the-playstation-2/)
- [Snowboarding trip](https://www.rusiczki.net/2004/02/21/snowboarding-trip/)
- [Brief](https://www.rusiczki.net/2004/04/01/brief/)
- [T Six Ten](https://www.rusiczki.net/2004/05/05/t-six-ten/)
- [You know you've been...](https://www.rusiczki.net/2004/08/26/you-know-youve-been/)
- [Palit Daytona Geforce 4 Ti 4200 (2002 - 2004)](https://www.rusiczki.net/2004/08/27/palit-daytona-geforce-4-ti-4200-2002-2004/)
- [Another edition is over - The late part 2](https://www.rusiczki.net/2004/10/28/another-edition-is-over-the-late-part-2/)
- [Another edition is over - The not so late part 3](https://www.rusiczki.net/2004/11/01/another-edition-is-over-the-not-so-late-part-3/)

**2005**

- [Froogle sells my stuff without my consent](https://www.rusiczki.net/2005/02/03/froogle-sells-my-stuff-without-my-consent/)
- [Google ads and even more spam](https://www.rusiczki.net/2005/02/12/google-ads-and-even-more-spam/)

**2006**

- [Nokia 6070 - USB infrared dongle - Now best buddies](https://www.rusiczki.net/2006/09/27/nokia-6070-usb-infrared-dongle-now-best-buddies/)

**2007**

- [Ego search this!](https://www.rusiczki.net/2007/01/16/ego-search-this/)
- [Snow(board) report for the first weekend of February 2007](https://www.rusiczki.net/2007/02/08/snowboard-report-for-the-first-weekend-of-february-2007/)
- [Act fast!](https://www.rusiczki.net/2007/06/16/act-fast/)
- [Yahoo! Mail booboo](https://www.rusiczki.net/2007/11/06/yahoo-mail-booboo/)

**2008**

- [29](https://www.rusiczki.net/2008/04/17/29/)

Dacă vă distrează, puteți să vă plimbați prin arhivă și să apăsați pe poze — acuma se deschid decent, fără să mai sară vreo ferestruică de pe vremea Windows XP. Iar dacă se întâmplă să găsiți vreun popup rămas pe undeva pe care l-am omis, lăsați un comentariu mai jos, că doar tocmai pentru asta am [scăpat de Disqus ieri](https://www.rusiczki.net/2026/04/09/alte-mici-modificari-adio-disqus/). 🙂
