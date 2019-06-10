Janos Rusiczki
==============
[![Build Status](https://img.shields.io/travis/janosrusiczki/janosrusiczki/master.svg?style=for-the-badge)](https://travis-ci.org/janosrusiczki/janosrusiczki)

This is my blog converted from Wordpress to Jekyll.

* It went live on January 8, 2018;
* It is built and deployed automatically by Travis whenever this repository's master branch changes (since January 15, 2018).

## Cheat codes

Nope, IDDQD will not work, try:

* MP4 Video:

  `<video controls><source src="https://content.rusiczki.net/2018/09/crosul-lacului-albastru.mp4" type="video/mp4">Dacă aici nu vedeți un video vizitați-mi blogul. :-)</video>`
* YouTube Video:
  
  `<div class="video-wrapper"><iframe width="560" height="315" src="https://www.youtube.com/embed/DELZ1EbqZfw?rel=0&amp;showinfo=0" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe></div>`
* Update Algolia Index:

  `ALGOLIA_API_KEY='SECRET' jekyll algolia --verbose`
