---
layout: doc
---

<h2>Index</h2>

{% assign base_url = page.url  %}
{% assign sorted_pages = site.pages | sort:"url" %}
<ul>
    {% for node in sorted_pages   %}
    {% if node.url contains base_url %}
    <li><a href="{{node.url}}">{{node.url}}</a></li>
    {% endif %}
    {% endfor %}
</ul>

