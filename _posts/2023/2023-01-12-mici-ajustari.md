---
layout: post
title: Mici ajustări
date: 2023-01-12 20:03:00.000000000 +02:00
categories:
  - blog history
  - technical
description: Un rezumat al recentelor modificări tehnice și de aspect ale blogului.
image: https://content.rusiczki.net/2023/01/rusiczki-net-2023-01-12-pagina-principala.png
---
Pe la început de decembrie a început să nu-mi mai convină cum pagina principală îmi afișează articolele în întregimea lor. Știam de foarte multă vreme că nu face bine nici pentru SEO pentru că motoarele de căutare preferă să nu ai conținut duplicat, așa că am început să experimentez să reduc lista la titlu, dată, poză reprezentativă și un mic sumar. Încă nu sunt pe deplin mulțumit  de cum arată, mai ales acel link de *Read* dar până-mi mai vin niște idei geniale "merge și așa".

![Pagina principală a rusiczki.net pe 12 ianuarie 2023](https://content.rusiczki.net/2023/01/rusiczki-net-2023-01-12-pagina-principala.png)

Descrierea următoarei serii de modificări trebuie să o încep cu o mărturisire: [articolul](https://www.rusiczki.net/2022/12/20/20-in-20/) despre cum blogul a împlinit 20 de ani în data de 20 decembrie 2022 l-am publicat de fapt în primele ore ale noului an, dar am făcut în așa fel încât să *pară* publicat pe data aniversară.

După ce l-am publicat, au urmat obișnuitele recitiri și mici modificări, mai ales seara, și cum tot schimbam fereastra devenea deranjant saltul între editorul de text cu fundal negru și blogul meu cu fundal aproape alb așa că am decis că ar fi cazul să trec la un fundal mai închis la culoare și aici pe site. Ceea ce am și făcut, dar a trebuit evident inversată și culoarea textului, după care mi-am dat seama că albul pe gri închis e prea contrastant și obositor pentru ochii mei bătrâni așa că l-am tras ușor spre un gri deschis. Am mai modificat puțin și culoarea linkurilor și alte câteva mici chestii pe parcurs ce descopeream că nu se potrivesc. Disqus a fost foarte ușor de adaptat, am intrat în partea de administrare de pe site-ul lor și am schimbat că vreau să-mi afișeze formularul și comentariile pe dark mode. Gata.

![Un articol de pe rusiczki.net pe 12 ianuarie 2023](https://content.rusiczki.net/2023/01/rusiczki-net-2023-01-12-articol.png)

Și dacă tot m-am apucat de modificări, mă deranja de ceva vreme că linkul Photos din meniu (era să zic *din stânga*, dar stânga e de fapt sus când te uiți la blog de pe mobil, ce ți-e și cu layout-urile astea responsive dom'le) nu ducea direct la [subdomeniul cu fotografii](https://photos.rusiczki.net/) ci pe o pagină aici pe blog, unde trebuia dat click pe link... Amatoricesc, ce mai. Am reparat, acum printr-un click pe linkul din meniu se ajunge direct la zeamă.

Ultima chestie reparată a fost [pagina de căutare](https://www.rusiczki.net/search/). Am verificat ce e pe acolo și am găsit o versiune antică a librăriei [Algolia](https://www.algolia.com/), de pe vremea când [am trecut pe Jekyll](https://www.rusiczki.net/2018/01/08/a-new-blogging-engine/). Am făcut upgrade la librărie să fiu la curent cu vremurile și binențeles că imediat s-au dus pe apa sâmbetei o parte din funcționalitate și cam tot stilul. A durat ceva până le-am readus la viață, mai ales că nu sunt un maestru emerit la capitolul CSS modern, dar am reușit până la urmă.

![Pagina de căutare de pe rusiczki.net pe 12 ianuarie 2023](https://content.rusiczki.net/2023/01/rusiczki-net-2023-01-12-cautare.png)

Vreau să profit de ocazie să vă spun că Algolia este unul dintre serviciile de care sunt super mulțumit și nu doar fiindcă oferă o variantă gratuită destul de generoasă ca și limite ci și pentru că e foarte rapidă căutarea efectivă și au o documentație vastă și bine pusă la punct.

Un alt serviciu de care sunt super mulțumit este GitHub, oferit de... Microsoft. Dacă-mi spunea cineva acum 10 ani (sau Doamne ferește 20!) că voi folosi aproape în exclusivitate un [editor de cod de la Microsoft](https://code.visualstudio.com/), codul mi-l voi ține [pe un serviciu Microsoft](https://github.com/) și mai ales că proiectele personale mi le voi dezvolta în [Linux rulând sub Windows](https://learn.microsoft.com/en-us/windows/wsl/about), probabil aveam tendința de a plezni respectiva persoană. Dar iată că aceasta este realitatea de ceva vreme. Apreciez GitHub nu doar pentru că-mi țin tot codul la ei pe gratis, ci și pentru că oferă GitHub Actions, un serviciu de build spre care am migrat după ce la [Travis](https://www.rusiczki.net/2018/01/25/use-travis-to-build-and-deploy-your-jekyll-site-through-ssh/) mi s-au terminat creditele și nu mai făcea build-uri cu blogul meu - ceea ce înseamnă că nu-l mai puteam publica. Travis a fost o experiență aiurea, până la un punct fiind foarte prietenoși cu comunitatea open source, apoi după ce au fost cumpărați și au dat afară o mare parte din personal au impus tot felul de restricții încercând din răsputeri să ne facă să migrăm spre varianta plătită. Nu mersi. Nu că nu doresc să plătesc pentru un serviciu pe care l-am folosit mult timp gratuit, dar să nu mă constrângă la modul urât să fac asta.

De fapt migrarea spre GitHub Actions a fost ceea ce mi-a "reanimat" activitatea pe aici pe la sfârșit de octombrie. De atunci le-am consumat ceva minute tot publicând site-ul după fiecare modificare. Iată că dacă în 2002 eram îngrijorat de minutele cât stăteam pe dial-up-ul de la Romtelecom în timpul zilei, în 2022 mă ingrijorez în legătură cu minutele pe care le consum pe mașinile virtuale ale Microsoft publicându-mi blogul. E un progres.

**PS** După ce am publicat acest articol am remarcat că pagina principală conține un mic Inception, sau cum spunem noi programatorii, _este recursivă_: blogul arată un screenshot cu blogul care arată un screenshot cu blogul cum arăta mai de mult. Am făcut [un screenshot](https://content.rusiczki.net/2023/01/rusiczki-net-2023-01-12-inception.png){:.glightbox} să imortalizez momentul... Ăăă, așadar am făcut un screenshot cu blogul aratând un screenshot cu blogul arătând un screenshot cu blogul cum arată mai de mult. OK, am terminat.

**PS 2** Mi-am dat seama ce mai lipseau: categoriile! Cu toate că în spatele cortinelor existau printre informațiile care acompaniază articolele (mai pe românește: în metadata), nu mai erau afișate de la ultima schimbare de motor de blog. Dar acum apar din nou la capătul fiecărui articol. Yey!

**Update în 23 ianuarie 2023:** Aproape din greșeală am observat că în 8 ianuarie 2023 versiunea pe Jekyll [a împlinit](https://www.rusiczki.net/2018/01/08/a-new-blogging-engine/) 5 anișori.
