---
layout: page
title: Archives
---

<h2>Date based archives</h2>
{% year_utilities years_with_month_links %}

<h2>Category based archives</h2>
{% capture category_names %}{% for category in site.categories %}|{{ category | first }}{% endfor %}{% endcapture %}
{% assign sorted_category_names = category_names | split: '|' | sort %}
{% for category_name in sorted_category_names %}{% assign stripped_category_name = category_name | strip %}{% if stripped_category_name != "" %}<a href="/category/{{category_name | slugify}}">{{category_name}}</a>{% unless forloop.last %}, {% endunless %}{% endif %}{% endfor %}
