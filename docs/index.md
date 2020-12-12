---
layout: doc
title: ola
uffa: 1
---
the global indexa
{{ page.dir }} 
{{ page }}




{% assign url_parts = page.url | split: '/' %}
{% assign url_parts_size = url_parts | size %}
{% assign rm = url_parts | last %}
{% assign base_url = page.url  %}
{% assign sorted_pages = site.pages | sort:"url" %}
{{base_url}}
<ul>
    {% for node in sorted_pages   %}
    {% if node.url contains base_url %}

    <li><a href="{{node.url}}">{{node.url}}</a>  </li>

    {% assign node_url_parts = node.url | split: '/' %}
    {% assign node_url_parts_size = node_url_parts | size %}
    {% assign filename = node_url_parts | last %}
    {% if url_parts_size == node_url_parts_size and filename != 'index.html' %}
    <!--<li><a href='{{node.url}}'>{{node.title}}</a></li>-->
    {% endif %}
    {% endif %}
    {% endfor %}
</ul>


<hr />



<hr>

{% for item in site.pages %}

ITEM:
{{ item.title }}  
{{ item.path }}  
{{ item.dir }}  
{{ item.uffa }}  
 

{% endfor %}
