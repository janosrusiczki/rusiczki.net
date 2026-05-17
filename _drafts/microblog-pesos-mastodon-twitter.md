---
layout: post
title: "Microblog la mine acasă: PESOS, Mastodon și o ultimă petrecere cu arhiva de Twitter"
categories:
  - blog history
  - technical
  - română
description: Am adăugat o secțiune de microblog pe rusiczki.net, alimentată automat de pe Mastodon (PESOS) și sămânțată cu o importare unică a vechii mele arhive de Twitter.
---
Continuăm seria de [curățenii prin curtea blogului](https://www.rusiczki.net/2026/04/09/alte-mici-modificari-adio-disqus/) cu ceva ce tot amânam: un loc pentru notițele scurte. Genul de chestie pe care până nu demult o postam pe Twitter și care n-a avut niciodată ce căuta în structura clasică a blogului ("articol cu titlu, paragrafe, poze, descriere SEO, blah blah"). De acum am [/microblog/](https://www.rusiczki.net/microblog/), cu propriul lui [feed RSS](https://www.rusiczki.net/microblog/feed.xml).

## De ce acum, și de ce așa

Twitter (sau X, sau cum se mai numește) a încetat să fie o destinație pentru ceea ce scriu de ceva vreme. Mastodon, în schimb, merge destul de bine pentru genul ăsta de notițe. Dar nu vreau ca Mastodon să fie singurul loc unde trăiesc. Instanțele dispar, conturile se închid, serverele se mută — și odată cu ele, mesajele tale. Vechea zicală "your data is your data only when it lives on a domain you own" rămâne la fel de adevărată.

Soluția se cheamă în jargonul indie web **PESOS**: *Publish Elsewhere, Syndicate to Own Site*. Publici unde îți e comod (Mastodon), iar copia ajunge automat pe site-ul tău. Opusul, **POSSE** (*Publish on Own Site, Syndicate Elsewhere*), ar fi mai pur conceptual, dar în practică ar fi însemnat să deschid laptop-ul și să fac un commit pentru fiecare gând de două propoziții. Mastodon-ul îl am în buzunar; blogul, nu.

## Cum funcționează

L-am rugat din nou pe [Claude](https://claude.ai/) (de data asta în varianta lui [Claude Code pe web](https://www.anthropic.com/news/claude-code-on-the-web), pe care o găsesc nespus de comodă) să mă ajute cu arhitectura, și după câteva iterații — și câteva schimbări de direcție din partea mea — am ajuns la ceva simplu.

Un **GitHub Action rulează zilnic** la 03:17 UTC și interoghează API-ul Mastodon. Ia tot ce e nou de la ultima sincronizare, filtrează (rămân originalele, firele de discuție cu mine însumi și boost-urile; dispar răspunsurile la alții), descarcă media, scrie câte un fișier Markdown și face commit și push. Boost-urile sunt marcate vizibil cu link către autorul original. Dacă nu e nimic nou, nu se întâmplă nimic — niciun commit, niciun build.

Imaginile sunt redimensionate la 1000px lățime dacă depășesc asta. Varianta mică se afișează inline, originalul se deschide la click. Media e rehostată pe [content.rusiczki.net](https://content.rusiczki.net) — dacă instanța mea Mastodon dispare mâine, fotografiile rămân. Upload-ul e cu rsync, niciodată cu `--delete`, că sunt paranoic.

Arhiva e navigabilă pe luni la adrese de genul [/microblog/2009/04/](https://www.rusiczki.net/microblog/2009/04/).

## Adio, vechi cont de Twitter, dar bună ziua, arhivă!

Contul meu de Twitter e încă acolo (nu l-am șters, doar nu mai postez). Twitter mai oferă încă posibilitatea de a-ți cere arhiva completă — un zip cu toate tweet-urile, atașamentele, DM-urile și altele. Am cerut-o și am primit un link câteva ore mai târziu.

Am scris un script Ruby (`_support/scripts/import_twitter.rb`) care citește `tweets.js` din arhivă, păstrează doar originalele (fără retweet-uri, fără răspunsuri la alții), extinde URL-urile scurtate de t.co, transformă mențiunile `@utilizator` și hashtag-urile `#subiect` în link-uri reale, copiază media în staging și scrie câte un Markdown per tweet. Un rsync, un commit, gata.

Rezultatul: **3.374 de tweet-uri** din 2008 până în 2025. Nu vor mai dispărea când Twitter decide că nu mai există sau că eu nu mai merit să fiu acolo.

Două note tehnice care merită consemnate.

Prima: când am adăugat cele 3.374 de intrări Twitter, build-ul a sărit la ~13 minute. Asta ne-a pus pe gânduri. De când am migrat blogul pe Jekyll, [build-ul dura cam un minut](https://www.rusiczki.net/2018/01/08/a-new-blogging-engine/) și mereu am presupus că ăsta e prețul Jekyll-ului. Nu era Jekyll. Era sidebar-ul meu — un loop care, pentru fiecare pagină generată, itera prin toate paginile site-ului ca să construiască navigarea. Cu 182 de pagini de arhivă lunară nou create, ajunsese clasic O(N²). Sidebar-ul are acum navigare hardcodată, și efectul s-a văzut peste tot: build-ul blogului pe CI a scăzut de la ~52-60 de secunde la ~31 de secunde, iar build-ul complet al microblogului (3.374 tweet-uri + Mastodon + deploy) durează 63 de secunde în total.

A doua: procesul a scos la iveală că [jekyll_asset_pipeline](https://www.rusiczki.net/2017/12/27/my-adventures-in-social-coding/) — gemul pe care îl co-întrețin și pe care îl folosesc pe blogul ăsta — nu genera fișiere cu hash-uri stabile: pentru același CSS/JS, fiecare build producea un fișier cu alt nume, ceea ce ar fi spart referințele din paginile arhivate ale Twitter-ului. Repo-ul original era configurat pentru Travis CI, care a dispărut de mult, și contul lui Matt nu era setat pentru GitHub Actions. Așa că am [preluat repo-ul](https://github.com/janosrusiczki/jekyll-asset-pipeline), am adăugat hash-uri derivate din conținut și am lansat versiunea 0.7.0. Abia după aia am putut continua.

## Și iată-l live

[/microblog/](https://www.rusiczki.net/microblog/) e live, cu tweet-uri din 2008 încoace și toot-uri Mastodon care vor continua să apară zilnic. Există arhivă lunară, există RSS, există lightbox. Ce nu există: comentarii, like-uri, algoritmul de recomandare.

Exact ce mi-am dorit.
