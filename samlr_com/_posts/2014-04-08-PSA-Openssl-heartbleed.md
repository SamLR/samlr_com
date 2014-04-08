--- BEGIN YAML HEADER ---
layout: post
summary: Check your SSL!
---- END YAML HEADER ----
{% block post_body %}
So I'm failing pretty heavily at keeping this updated but here's something worth while (that also lets me check I've updated my ssh keys correctly):

**OpenSSL HAS BEEN FOUND TO HAVE FAIRLY MAJOR BUG**

Full details [here](http://heartbleed.com/ 'heartbleed'). Basically you need to update your ssh keys (delete them and create new ones) and upgrade openSSL to 1.0.1g.