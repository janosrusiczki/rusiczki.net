---
layout: post
title: Cum scriu pe blog în 2026
date: 2026-04-13 15:30:00 +03:00
categories:
  - blog history
  - technical
description: De la Movable Type și poze descărcate de pe card, prin Wordpress, la Jekyll, Joplin și un coleg de redacție artificial.
---
Am tot amânat momentul ăsta. În [ianuarie 2018](https://www.rusiczki.net/2018/01/13/imagini-aeriene-de-final-de-an/), cu ocazia unor poze cu drona, am inserat un paragraf despre cum s-a complicat procesul publicării unei poze față de zilele de odinioară. Apoi, în [octombrie 2025](https://www.rusiczki.net/2025/10/13/rip-typepad/), la finalul unui articol despre Typepad, am pus o poză cu mine redactând pe iPad și am descris în câteva rânduri cum arăta workflow-ul de la acea vreme. Iar [mai devreme azi](https://www.rusiczki.net/2026/04/13/janos-the-prompt-engineer/) am promis explicit că voi scrie un articol separat despre cum s-a schimbat procesul meu de scriere pe blog. Ei bine, iată-l.

### Movable Type (2002–2009)

La începuturile blogului, pe vremea Movable Type, workflow-ul era de o simplitate dezarmantă: deschideam panoul de administrare în browser, scriam textul, eventual atașam o poză mică (eram pe dial-up, fiecare kilobyte conta), apăsam Publish și gata. Pozele veneau de pe un card de memorie, le descărcam pe calculator, eventual le micșoram puțin ca să nu sufle conexiunea, și le încărcam manual prin interfață. Nu aveam nevoie de niciun alt instrument, totul se întâmpla în browser. [Șase ani](https://www.rusiczki.net/2009/04/02/keeping-up-with-the-times/) am funcționat așa.

### WordPress (2009–2018)

Când [am migrat pe WordPress](https://www.rusiczki.net/2009/04/02/keeping-up-with-the-times/) în 2009, am câștigat un editor vizual decent, un media manager pe care aveam să-l regret amarnic mai târziu, și un ecosistem de plugin-uri. Workflow-ul devenise și mai simplu într-un fel: scriam, făceam drag and drop cu pozele în fereastra de upload, WordPress le redimensiona automat, apăsam Publish. Totul sub un singur acoperiș. Probabil a fost vârful comodității, deși nu-mi dădeam seama pe atunci.

### Jekyll (2018–prezent)

[Trecerea la Jekyll](https://www.rusiczki.net/2018/01/08/a-new-blogging-engine/) în 2018 a venit cu avantaje clare: securitate (niciun PHP, nicio bază de date de spart), totul în git, articolele scrise în Markdown. Dar și cu compromisuri. Am pierdut media manager-ul (pe care [chiar am scris](https://www.rusiczki.net/2018/01/08/a-new-blogging-engine/) că mi-l doream înapoi), am pierdut comentariile native (Disqus a fost plasturul cu care [am tot mers](https://www.rusiczki.net/2026/04/09/alte-mici-modificari-adio-disqus/) până de curând), și am pierdut editorul integrat.

Procesul publicării a devenit și mai nerdy. Trebuia să scriu textul într-un editor de text, să creez versiunile redimensionate ale pozelor manual, să le încarc pe server separat, și apoi să dau commit și push. [Articolul din 2018 cu drona](https://www.rusiczki.net/2018/01/13/imagini-aeriene-de-final-de-an/) surprinde bine frustrarea de atunci: *"le-am descărcat din dronă pe mobil prin WiFi, le-am editat în Lightroom-ul de pe Android, mi le-am trimis pe mail, creat versiunile redimensionate în Gimp pe Linux și le-am încărcat manual."* Cam mulți pași pentru două poze.

Pe de altă parte, faptul că totul stă în git a deschis o altă ușă: am [automatizat build-ul și deploy-ul prin Travis CI](https://www.rusiczki.net/2018/01/25/use-travis-to-build-and-deploy-your-jekyll-site-through-ssh/) (între timp migrat la GitHub Actions), ceea ce înseamnă că nu mai trebuie să construiesc site-ul local. Pot chiar să editez articole direct din interfața web a GitHub-ului, dau commit, și site-ul se republică automat. Ironic, într-un fel m-am întors la o formă de a scrie în browser, doar că browser-ul deschide acum un editor de cod, nu un panou de administrare.

### Joplin și scrierea între dispozitive (2025–prezent)

Pe parcursul anilor am tot încercat diferite editoare de text, dar de ceva vreme m-am stabilit la [Joplin](https://joplinapp.org/). Așa cum arătam [în articolul despre Typepad](https://www.rusiczki.net/2025/10/13/rip-typepad/), anul trecut am redactat ciorna acelui articol pe iPad Air-ul M2 de 13" cu o tastatură Logitech MX Keys, printre căluții de jucărie ai Annei. Joplin se sincronizează între dispozitive, astfel că pot începe pe iPad și continua pe laptop în [Typora](https://typora.io/). Ambele aplicații lucrează nativ cu Markdown, ceea ce se potrivește perfect cu Jekyll. E un workflow cu mai mulți pași decât editorul din browser al Movable Type, dar e și infinit mai flexibil.

### Colegul de redacție artificial (2026)

Și ajungem la chestia care a motivat de fapt acest articol. De când am un abonament [Claude](https://claude.ai/), lucrul pe blog s-a schimbat destul de mult. Am povestit deja [cum a ajuns Claude](https://www.rusiczki.net/2026/04/13/janos-the-prompt-engineer/) parte din viața mea de programator, dar pe latura de blog lucrurile s-au întâmplat mai de la sine.

A început cu mentenanța: Claude mi-a recomandat [statisticile](https://www.rusiczki.net/2026/04/09/alte-mici-modificari-adio-disqus/) de pe pagina de About, m-a ajutat să găsesc și să migrez la Remark42 pentru comentarii, și recent a scos la iveală [28 de articole vechi cu popup-uri](https://www.rusiczki.net/2026/04/11/pensionarea-mult-prea-intarziata-a-popup-urilor/) pe care le-am curățat împreună. De acolo până la "ajută-mă și cu textul ăsta" n-a fost decât un pas.

Procesul actual arată cam așa: scriu ciorna în Joplin, o transfer în git, și acolo intervine Claude. Îl rog să structureze articolul când am scris un text lung și dezorganizat, să verifice date și fapte, să pună evenimentele în ordine cronologică, să corecteze gramatica și să lege totul mai bine. Cam ce face un editor uman, doar că editorul meu e un model de limbaj.

Dar eu încă editez masiv. Uneori rescriu complet secțiuni întregi. Articolele mele sunt în mare parte povestiri personale, amintiri din 2002, gadget-uri pe care le-am avut, pârtii pe care am căzut, detalii pe care doar eu le știu. Niciun LLM nu poate inventa amintirea cum m-am dat cu snowboard-ul pe Icoana la Cavnic sau cum am pierdut domeniul resurseweb.net. Claude ia ce am mâzgălit eu și face textul lizibil. Vocea e a mea. Virgulele... de cele mai multe ori sunt ale lui.

### Ce s-a schimbat și ce nu

În aproape 24 de ani de blog am schimbat trei motoare (Movable Type, WordPress, Jekyll) și nu știu câte unelte de scris. Complexitatea procesului a oscilat: simplă, apoi și mai simplă, apoi complicată, apoi altfel complicată. Dar esența e aceeași: un tip stă undeva, fie la un birou din Baia Sprie, fie printre căluți de jucărie, scrie despre ce-l preocupă, și apasă Publish.

Și dacă tot "sufăr" de ADD, trebuie să recunosc un lucru: jucăriile noi aduc motivație nouă. Claude a fost jucăria care m-a pus din nou pe scris. Am publicat mai multe articole într-o săptămână decât în câțiva ani la un loc. Cât va dura valul, nu știu. Dar cât durează, mă bucur de el.
