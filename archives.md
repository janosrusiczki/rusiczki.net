---
layout: page
title: Archives
---

<h2>Date based archives</h2>
{% year_utilities years_with_month_links %}

<h2>Category based archives</h2>
{% for category in site.categories %}
  {% capture category_name %}{{ category | first }}{% endcapture %}
  <a href="/category/{{category_name}}">{{category_name}}</a>
{% endfor %}
