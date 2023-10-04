---
layout: page
title: Archives
---

<h2>Date based archives</h2>
{% year_utilities years_with_month_links %}

<h2>Category based archives</h2>
<div id="archives">
{% for category in site.categories %}
  <a href="/category/{{category|slugify}}">{{category}}</a>
{% endfor %}
</div>
