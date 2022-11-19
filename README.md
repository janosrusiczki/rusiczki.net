Janos Rusiczki
==============
[![Jekyll Build, Test and Deploy](https://github.com/janosrusiczki/rusiczki.net/actions/workflows/jekyll-build-test-and-deploy.yml/badge.svg)](https://github.com/janosrusiczki/rusiczki.net/actions/workflows/jekyll-build-test-and-deploy.yml)

This is my blog converted from Wordpress to Jekyll.

* It went live on January 8, 2018;
* It was built and deployed automatically by Travis whenever the repository's master branch changed (from January 15, 2018 to October 20, 2022 - according to their logs 348 builds);
* It is now built and deployed automatically by GitHub Actions with the same conditions as above (starting with October 18, 2022).

## Cheat codes

Nope, IDDQD will not work, try:

* To open an image in the lightbox append `{:.glightbox}` to the end of the link:

  `[![Casetă Roxette - Joyride](https://content.rusiczki.net/2019/12/roxette-joyride-1000x667.jpg)](https://content.rusiczki.net/2019/12/roxette-joyride.jpg){:.glightbox}`
  
* Link with title:

  `[Link to something awesome](https://rusiczki.net/ "Only the best site on the Internet")`

* MP4 Video:

  `<video controls><source src="https://content.rusiczki.net/2018/09/crosul-lacului-albastru.mp4" type="video/mp4">Dacă aici nu vedeți un video vizitați-mi blogul. :-)</video>`
* YouTube Video:
  
  `<div class="video-wrapper"><iframe width="560" height="315" src="https://www.youtube.com/embed/DELZ1EbqZfw?rel=0&amp;showinfo=0" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe></div>`
* Update Algolia Index:

  `ALGOLIA_API_KEY='SECRET' bundle exec jekyll algolia --verbose`
