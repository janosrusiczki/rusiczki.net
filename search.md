---
layout: page
title: Search
---
<div id="search-searchbar"></div>

<div id="search-hits">No results yet, type something above...</div>

<!-- Including InstantSearch.js library and styling -->
<script src="https://cdn.jsdelivr.net/npm/algoliasearch@4.14.2/dist/algoliasearch-lite.umd.js" integrity="sha256-dImjLPUsG/6p3+i7gVKBiDM8EemJAhQ0VvkRK2pVsQY=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/instantsearch.js@4.49.1/dist/instantsearch.production.min.js" integrity="sha256-3s8yn/IU/hV+UjoqczP+9xDS1VXIpMf3QYRUi9XoG0Y=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/instantsearch.css@7.4.5/themes/reset-min.css" integrity="sha256-QlHlZdbSVxaYkUHxhMFhAj/L3pJiW1LuomSCONXBWms=" crossorigin="anonymous">

<script>
  const searchClient = algoliasearch(
    '{{ site.algolia.application_id }}',
    '{{ site.algolia.search_only_api_key }}'
  );
  
  const search = instantsearch({
    indexName: '{{ site.algolia.index_name }}',
    searchClient,
  });
  
  search.addWidgets([
    instantsearch.widgets.searchBox({
      container: '#search-searchbar',
    }),
    instantsearch.widgets.hits({
      container: '#search-hits',
    })
  ]);
  
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
