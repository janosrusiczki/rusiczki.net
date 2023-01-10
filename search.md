---
layout: page
title: Search
---
<div id="search-searchbar"></div>

<div id="search-hits">No results yet, type something above...</div>

<!-- Including InstantSearch.js library and styling -->
<script src="https://cdn.jsdelivr.net/npm/instantsearch.js@2.3.3/dist/instantsearch.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/instantsearch.js@2.3.3/dist/instantsearch.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/instantsearch.js@2.3.3/dist/instantsearch-theme-algolia.min.css">

<script>
// Instanciating InstantSearch.js with Algolia credentials
const search = instantsearch({
  appId: '{{ site.algolia.application_id }}',
  indexName: '{{ site.algolia.index_name }}',
  apiKey: '{{ site.algolia.search_only_api_key }}',
  urlSync: true,
  searchFunction: function(helper) {
    if(helper.state.query != '') {
      helper.search();
    }
  }
});

const hitTemplate = function(hit) {
  let date = '';
  if (hit.date) {
    date = moment.unix(hit.date).format('MMM D, YYYY');
  }
  const url = hit.url;
  const title = hit._highlightResult.title.value;
  const content = hit._highlightResult.html.value;
  return `
    <div class="post">
      <h1 class="post-title">
        <a href="${url}">
          ${title}
        </a>
      </h1>
      <span class="post-date">${date}</span>
      ${content}
    </div>
  `;
}
// Adding searchbar and results widgets
search.addWidget(
  instantsearch.widgets.searchBox({
    container: '#search-searchbar',
    placeholder: 'Search this site...',
    poweredBy: true,
    autofocus: true,
  })
);
search.addWidget(
  instantsearch.widgets.hits({
    container: '#search-hits',
    templates: {
      item: hitTemplate
    }
  })
);
// Starting the search
search.start();
</script>
<style>
  #search-searchbar {
    margin-bottom: 1rem;
  }
  .ais-search-box {
    max-width: 100%;
  }
</style>
