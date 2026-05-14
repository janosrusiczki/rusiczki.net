---
layout: post
title: "Microblog la mine acasă: PESOS, Mastodon și o ultimă petrecere cu arhiva de Twitter"
categories:
  - blog history
  - technical
  - română
description: Am adăugat o secțiune de microblog pe rusiczki.net, alimentată automat de pe Mastodon (PESOS) și sămânțată cu o importare unică a vechii mele arhive de Twitter.
---
Continuăm seria de [curățenii prin curtea blogului](https://www.rusiczki.net/2026/04/09/alte-mici-modificari-adio-disqus/) cu încă o piesă pe care o tot amânam de ceva vreme: un loc pentru notițele scurte. Adică genul de chestie pe care până nu demult o postam pe Twitter și care, în mod evident, nu și-a găsit niciodată locul în structura clasică a blogului ("articol cu titlu, paragrafe, poze, descriere SEO, blah blah"). De acum am [/microblog/](https://www.rusiczki.net/microblog/), cu propriul lui [feed RSS](https://www.rusiczki.net/microblog/feed.xml).

## De ce acum, și de ce așa

Twitter (sau X, sau cum se mai numește) a încetat să fie o destinație pentru ceea ce scriu de ceva vreme. Mastodon, în schimb, a devenit destul de plăcut pentru genul ăsta de notițe scurte. Dar nu vreau să fie singurul loc unde trăiesc. Instanțele Mastodon dispar, conturile sunt închise, serverele se mută, totul se întâmplă — și odată cu ele se duc în neant și mesajele tale. Vechea zicală "your data is your data only when it lives on a domain you own" e mai actuală ca niciodată.

Soluția se cheamă în jargonul indie web **PESOS**: *Publish Elsewhere, Syndicate to Own Site*. Adică: publici unde îți este comod (Mastodon, în cazul de față), iar copia oficială ajunge pe site-ul tău, automat. Opusul, **POSSE** (*Publish on Own Site, Syndicate Elsewhere*), ar fi însemnat să scriu notițele aici și să le împing apoi pe Mastodon — mai pur, dar incomod: aș fi fost obligat să-mi deschid laptop-ul și să fac un commit pentru fiecare gând de două propoziții, ceea ce ar fi însemnat că nu aș scrie nimic. Mastodon-ul îl am în buzunar; blogul, nu.

## Cum funcționează

L-am rugat din nou pe [Claude](https://claude.ai/) (de data asta în varianta lui [Claude Code pe web](https://www.anthropic.com/news/claude-code-on-the-web), care e atât de comodă!) să mă ajute să gândesc arhitectura, și după niște iterații (și niște schimbări de direcție din partea mea) am ajuns la următorul aranjament:

- O nouă **colecție Jekyll** numită `microblog`, cu propriul layout, propria pagină de listare la [/microblog/](https://www.rusiczki.net/microblog/) și propriul feed Atom.
- Un **GitHub Action care rulează zilnic** (la 03:17 UTC, off-peak ca să nu se bată cu altcineva pe runner-uri) și interoghează API-ul Mastodon-ului meu. Ia toate toot-urile noi de la ultima sincronizare, le filtrează (păstrăm originalele și firele de discuție către sine, eliminăm boost-urile și răspunsurile către alții), descarcă atașamentele media, și scrie câte un fișier Markdown pentru fiecare. Apoi face un commit și un push pe `master`. Dacă nu sunt toot-uri noi, nu se întâmplă nimic — niciun commit, niciun build.
- Build-ul existent al site-ului se declanșează firesc la commit-ul de mai sus, exact ca pentru orice articol nou. Costul: maxim un build pe zi, în loc de zero–trei pe zi cum mă temeam inițial.
- Fișierele media (imagini, video, GIF-uri din toot-uri) sunt **rehostate pe** [content.rusiczki.net](https://content.rusiczki.net) sub `/microblog/mastodon/` și `/microblog/twitter/`. Așa, dacă instanța mea Mastodon (sau Twitter, sigur) dispare mâine, fotografiile rămân.
- Upload-ul media se face cu **rsync** (peste SSH/SFTP, exact ca deploy-ul site-ului), niciodată cu `--delete`. Nimic nu poate șterge accidental restul conținutului de pe `content.rusiczki.net` — am verificat de trei ori, am pus și un dry-run obligatoriu pentru pasul manual de import.

## Adio, vechi cont de Twitter, dar bună ziua, arhivă!

Cum vechiul meu cont de Twitter este încă acolo (nu l-am șters, doar nu mai postez), mai am ceva moștenire de salvat. Twitter mai oferă încă (slavă Domnului) posibilitatea de a-ți cere o copie a întregului tău arhivă: un fișier zip cu toate tweet-urile tale, atașamentele, like-urile, DM-urile și încă vreo câteva chestii. L-am cerut și după câteva ore mi-a sosit pe email un link spre un archive.

Pentru a-l importa în secțiunea nouă de microblog am scris un script Ruby (`_support/scripts/import_twitter.rb`) care:
- citește `data/tweets.js` (sau `tweets-part*.js` pentru arhivele mari) din zip,
- păstrează doar tweet-urile *originale* (fără retweet-uri, fără răspunsuri către alți utilizatori; firele de discuție către mine însumi rămân întregi),
- extinde URL-urile scurtate de t.co la formele lor complete,
- copiază atașamentele media într-un director local de staging,
- scrie un fișier Markdown pentru fiecare tweet în `_microblog/twitter/<an>/`.

Apoi un singur `rsync` urcă media pe `content.rusiczki.net/microblog/twitter/`, un singur commit/push și gata, vechile mele tweet-uri devin parte din istoricul blogului meu. Nu vor mai dispărea atunci când conturile sau companiile pe care le-am folosit se vor stinge.

## Mici detalii tehnice care m-au amuzat

- **Twitter HTML-escapează `&`, `<` și `>` în corpul tweet-urilor** chiar și în arhiva exportată. A trebuit să le decodez manual, altfel ar fi apărut peste tot `&amp;` în loc de `&`.
- **Mastodon API-ul folosește `min_id` pentru paginare incrementală**, nu `since_id`. Diferența pare minoră dar e crucială: cu `min_id` ești garantat să nu pierzi toot-uri intermediare dacă ai mai mult de 40 de noi între două sincronizări. Documentația o explică, am ales calea bună din prima. (Bine, eu nu, Claude. Cum spuneam.)
- **GitHub Actions face commit din workflow** doar dacă i s-a dat `permissions: contents: write` și folosește `secrets.GITHUB_TOKEN` la checkout. Mi-a luat două încercări să-mi amintesc combinația.
- **rsync fără `--delete` este aditiv**, niciodată distructiv. Pentru un sysadmin paranoid (cum mă consider, mai ales după unele "experimente" din anii '90 cu rm -rf), e o liniște binevenită.

## Ce urmează

În momentul în care citiți acestea, infrastructura este pusă la punct, dar conținutul tocmai începe să curgă. Mai trebuie să-mi fac efectiv un cont de Mastodon (am amânat luni de zile, e momentul) și să decid pe ce instanță. După aceea, configurez câteva variabile în setările repo-ului de pe GitHub, lansez prima sincronizare manuală, și fluxul ar trebui să-și intre în ritmul lui zilnic. Importul Twitter-ului îl voi face într-un weekend liniștit, când voi avea răbdare să mă uit prin diff și să curăț ce mai trebuie curățat.

Și, da, asta înseamnă că pagina de [/microblog/](https://www.rusiczki.net/microblog/) o să fie goală câteva zile. Dar lume nouă, pagină nouă, răbdare nouă.
