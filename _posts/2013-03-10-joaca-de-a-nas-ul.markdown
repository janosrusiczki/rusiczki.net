---
layout: post
status: publish
published: true
title: Joaca de-a NAS-ul
author: János
wordpress_id: 4372
wordpress_url: http://www.rusiczki.net/?p=4372
date: !binary |-
  MjAxMy0wMy0xMCAxNDoyNjo1MiArMDEwMA==
date_gmt: !binary |-
  MjAxMy0wMy0xMCAxMToyNjo1MiArMDEwMA==
categories:
- Technical
- Română
tags: []
comments:
- id: 28818
  author: lucian
  author_email: 
  author_url: ''
  date: !binary |-
    MjAxMy0wMy0xMiAwMDo0NzowMCArMDEwMA==
  date_gmt: !binary |-
    MjAxMy0wMy0xMSAyMTo0NzowMCArMDEwMA==
  content: bun, şi acu zi-ne şi cu norii (amazon, crashplan, etc). mulţumim :)
- id: 28819
  author: János
  author_email: 
  author_url: http://www.rusiczki.net/
  date: !binary |-
    MjAxMy0wMy0xMiAxMDoxOTowMCArMDEwMA==
  date_gmt: !binary |-
    MjAxMy0wMy0xMiAwNzoxOTowMCArMDEwMA==
  content: Le zic si despre alea curand. Se pare ca am multe chestii de recuperat
    dupa ditai hiatusul... :-) Mersi de idee.
---
<p><a href="http://www.rusiczki.net/wp-content/uploads/2013/10/20130310_113727.jpg"><img class="alignnone size-medium wp-image-4566" alt="Midnight Commander" src="http://www.rusiczki.net/wp-content/uploads/2013/10/20130310_113727-693x519.jpg" width="693" height="519" /></a></p>
<p>Nu, nu mă scobesc în nas și nici nu e mergem de nași ci a venit timpul să-mi refac / reconfigurez NAS-ul, adică Network Attached Storage-ul. Dar să începem cu puțină istorie...</p>
<p>În toamna anului 2011, după ce am decis că e timpul să-i fac un refresh PC-ului meu de care nu m-am mai atins de la <a href="http://www.flickr.com/photos/janos/377549946/">sfârșitul lui 2006 / începutul lui 2007</a> am rămas cu o serie de componente din care aproape că puteam să construiesc un nou calculator. Ceea ce m-am hotărât să și fac. Mă gândeam de câțiva ani să fac un server de fișiere și să-l plasez într-un loc în care să poată funcționa 24/7 fără ca zgomotul să deranjeze pe cineva. În cazul meu: cămara. Existența unui server în casă a fost relativ bine justificată având în vedere că în majoritatea timpului există 4 calculatoare care merg concomitent plus un media player și alte device-uri prin care consumăm aproximativ acelaș conținut (seriale și filme). Astfel "centralizarea" acestor fișiere a fost un "must". În plus acest server se putea ocupa de download-uri și seeding-ul aferent așa că nu mai era necesar ca PC-ul din camera unde dormim să funcționeze constant. Un alt avantaj era că printr-un simplu port forwarding și pornirea unui serviciu de FTP fișierele stocate puteau fi făcute disponibile de oriunde exista acces la Internet. Aveam un fix, și anume să folosesc <a href="http://www.freenas.org/">FreeNAS</a> ca sistem de operare, lucru care pe termen lung s-a dovedit a fi o alegere neinspirată.</p>
<p>Dar să revenim la toamna lui 2011. După achiziționarea a 2 hard disk-uri de 2 TB (pe vremea când HDD-urile aveau încă prețuri normale) și a unei surse mari, puternice și foarte zgomotoase am asamblat calculatorul care a funcționat bine mersi un an jumate în cămara, servind familia cu bunătăți alese în materie de fișiere. Asta din punct de vedere hardware, căci la software situația a stat altfel. În timp ce FreeNAS permite într-adevăr configurarea facilă a unui server de fișiere, la capitolul extensibilitate e mai complicat. Mult mai complicat decât aș fi vrut să fie. FreeNAS este bazat pe o configurație FreeBSD minimalistă, un sistem de operare cu care eu am zero experiență astfel încât dacă vroiam să adaug orice fel de software sau serviciu era nevoie de pregătire serioasă și dedicarea unei după mese care știam că va fi plină de frustrări.</p>
<p>Astfel de o vreme încoace a început să-mi surâdă idea schimbării sistemului de operare în ceva mai prietenos, și asta la capitolul servere pentru mine se concretizează prin <a href="http://www.ubuntu.com/">Ubuntu</a>. Apoi am dat de <a href="http://www.parmeter.net/ben/2012/02/20/switching-from-freenas-to-ubuntu-server/">acest articol</a> și m-am hotărât. Una din avantajele lui FreeNAS era că putea să ruleze de pe un stick USB fără riscul de a-l "arde", ceea ce nu se poate spune despre Ubuntu, cel puțin nu fără multe setări. Dar cum primisem un HDD de 500 GB de Crăciun (mersi soacra!) și această problemă era teoretic rezolvată. Așa că ieri am dat un shutdown hotărât, am adus serverul sus și l-am pus pe masa de operații. Primul șoc a fost aspectul fizic din interior. Praf nu era așa de mult pe cât m-am așteptat, asta și deoarece am izolat bine majoritatea orificiilor de aerisire, însă unde era, era cam solidificat - plasarea atât de aproape de bucătărie n-a fost o idee tocmai genială... După circa 30 minute de curățat care a inclus o intervenție cu compresorul, praful era o amintire și m-am putut apuca de instalat noul disc și noul sistem de operare.</p>
<p>Totul a decurs relativ ușor și cu puțin ajutor de la guru <a href="https://www.facebook.com/emilburzo">Emil</a> sistemul a fost gata de acțiune în circa o oră. Problema a fost că cele două discuri de stocare au fost formatate și partiționate de către FreeNAS în UFS (Unix File System) și sub Linux am reușit să le montez doar în mod read-only. Aparent montarea normală (read &amp; write) era posibilă doar după recompilarea kernel-ului și chiar și așa era experimentală. Nu aveam knowhow-ul necesar pentru recompilare și nici nu vroiam să-mi las fișierele în grija unui feature experiemental. Noroc că am găsit un HDD extern pe USB cu destul loc liber încăt să evacuez pe el conținutul HDD-ului mai puțin ocupat și în felul acesta a fost posibilă o rocadă de genul:</p>
<ol>
<li>mutat conținut disc 2 pe disc USB;</li>
<li>formatat disc 2 cu un sistem de fișiere Linux (ext4);</li>
<li>mutat conținut disc 1 pe disc 2;</li>
<li>formatat disc 1 în ext4;</li>
<li>mutat conținut "evacuat" de pe pe HDD-ul extern pe disc 1.</li>
</ol>
<p>Ieri majoritatea după mesei a fost consumată de pasul 1 iar acum rulează, și după cum se observă în poză, va mai rula o vreme, pasul 3.</p>
<p>Dar rezultatul acestor două zile de downtime va fi un sistem mult mai ușor de extins din punct de vedere al software-ului pe care abia aștept să instalez bunătățile din articolul care l-am menționat mai sus.</p>
