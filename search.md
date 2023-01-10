---
layout: page
title: Search
---
<div id="search-searchbar"></div>

<div id="search-hits"></div>

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
    searchFunction: function(helper) {
      if(helper.state.query != '') {
        helper.search();
      }
    },
    routing: true
  });
  
  search.addWidgets([
    instantsearch.widgets.searchBox({
      container: '#search-searchbar',
      showSubmit: false,
    }),
    instantsearch.widgets.hits({
      container: '#search-hits',
      templates: {
        item(hit, { html, components }) {
          if(hit.date != undefined) {
            const date = new Date(hit.date * 1000)
            const localeStringOptions = {
              weekday: 'long',
              year: 'numeric',
              month: 'long',
              day: 'numeric'
             }
            const formattedDate = date.toLocaleString('en-US', localeStringOptions)
          } else {
            const formattedDate = 'No Date'
          }
          return html`
            <div class="post">
              <h1 class="post-title">
                <a href="${hit.url}">
                  ${components.Highlight({ hit, attribute: 'title' })}
                </a>
              </h1>
              <span class="post-date">${formattedDate}</span>
              ${components.Snippet({ hit, attribute: 'content' })}
            </div>
          `;
        },
      },
    })
  ]);
  
  search.start();
</script>
<style>
  #search-searchbar {
    margin-bottom: 2em;
  }
  .ais-SearchBox-input {
    width: 100%;
    font-size: 20px;
    padding: 10px;
    border-radius: 7px;
    border: 1px solid #aaa;
    appearance: none;
  }
  
  .ais-SearchBox-input:focus {
    outline: 0;
  }
  
  .ais-SearchBox-reset {
    margin-left: -27px;
  }
  
  .ais-SearchBox-reset svg {
    display: block;
    fill: #aaa;
    width: 15px;
    height: 15px;
  }
</style>
