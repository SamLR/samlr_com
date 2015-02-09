--- BEGIN YAML HEADER ---
layout: post
summary: I made a mood-tracking web-app (sorta)
---- END YAML HEADER ----
{% block post_body %}
First post of 2015! and first post in the last... 5 months so I'm doing well (as ever).

Anyway, for once this isn't a post about how I've not posted recently (although it should be) or about what I've been up to generally (although there's a fair bit to put in there as well...) it's not even about something I've only got 50% of the way done (well sorta). No, it's about a thing that is at least at the minimal viable product stage.

Backstory: my partner ([go look at/buy her awesome stuff here](http://entanglement.co.uk/ "shiny!")) wanted a way of tracking her mood & sleep patterns. I foolishly promised to make her a web app to do this with as her Christmas present. I mere 2 months late I've finished. This article won't be an in-depth write up of how I did it, if you're interested in that the stack's in the side-bar and I may write it up later. Instead I'm going to write up a bit about what I learnt doing this, keeping in mind that although I've now been a webdev for over a year(!) I've never actually built a site from scratch before (although I have done all of the bits separately).

So here are some number of things I learnt:

### There's a hell of a lot more boilerplate than I remember ###
There are tools like [yeoman](http://yeoman.io/ "yo!") and [bower](http://bower.io "what does it even do?") that claim to remove some of this but having poked them a bit for this project I realised that I'd have spent as much time removing excess cruft as I would have done writing boilerplate. These strike me as very useful if you're writing a dozen sites a year and you have a very fixed set of things you want each and every time. For me I'm generally toying around with different stuff and I just don't make that many sites...

### Sod bower ###
Talking of bower I tried it a bit at the start of this and I really can't see the advantage of yet another repo manager. We use this a bit at my current work and it causes more problems that it solves the number one of which is a lack of consistent structure to the stuff it installed (being pulled directly from [Github](https://github.com "as if you didn't know the address")). Lack of consistency in structure & naming makes it a pain if you want to just concat all the minified versions of libraries people provide (rather than pointlessly doing it yourself). Rather than use bower I manually downloaded what I wanted and had two library folders: one for un-minified libraries, the other for those that are. This way at build time I can just concat all the *.min versions of the files together and get on with my life.

### Apache2 still confuses the hell out of me ###
Less so that any other time I've had to poke it but good gods was I taking a lot on trust to get the site up. I'm pretty sure I did it right but there seems to be a weird gulf between "here's how you make django run locally as dev" and "here's how you deploy your app in a vaguely production worth way" both in terms of tutorials and support. Unless you're using something like [heroku](https://heroku.com/ "shiny") or [AWS](http://aws.amazon.com/ "also shiny") then there's a lot you need to hack through to figure out how to deploy your stuff. And if you do use something like AWS or Heroku then enjoy moving it... Anyway I think this time I got the apache2 stuff down ok (and really got a chance to kick wsgi for a bit).

### Deploy stuff is annoying ###
I actually finished the site for Christmas day (at least a bare bones local version). I then took some time off from it to enjoy the holidays but since about the 2nd weekend of January most weekends have been fighting to get deploy stuff working. Some of this was the above apache2 wrangling (so much conf) and other fun things (figuring out how to set up subdomains) but a lot was get getting what I needed from my laptop to the server and running with as much consistency and as few commands as possible. In the end I used [Grunt](http://gruntjs.com/ "oink") for building and [Fabric](http://www.fabfile.org/ "smooth") for deploying but it took a while. Annoyingly I still have to run these separately as calling grunt from fabric makes the later choke...

Anyway hopefully I'll have a better write up soon of what I actually did as well as some sort of guest account on the actual app so people can play with it (or I may just host another version on heroku or aws).


{% endblock post_body %}

{% block post_right %}
The Stack:

### Server ###
* [Django](https://www.djangoproject.com/ "Not a film by Tarantino"), the general framework.
* [Rest Framework](www.django-rest-framework.org/ "mmmm REST"), make RESTful APIs more easily in django.
* [Django-model-utils](https://github.com/carljm/django-model-utils "utils"), really helpful gubbins (like setting up models with created/modified fields)

### Client ###
* [Angular](https://angularjs.org "Not so bendy") My favourite JS framework by a mile (probably because it's the one I have the most experience with).
* [UI-router/bootstrap/select](http://angular-ui.github.io "Not sure a router's an UI really...") A better client side router and nice angular versions of basic bootstrap functionality what more do you want? Also select boxes which... are another post.
* [Lodash](http://lodash.com "'_', not '_'") the slightly more versatile sibling of underscore. I'm not certain I used anything in this that's not part of angular but then again not having an '_' about just feels wrong...
* [Moment](http://momentjs.com "Just don't read the source") I'm dealing with (albeit lightly) with datetimes, of course I'm letting someone else parse it.

### Build stuff/tools ###
* [Bootstrap](http://getbootstrap.com "yes, get it!") because I'm lazy.
* [LESS](http://lesscss.org/ "or SASS, your choice") mostly because (AFAIK) SASS doesn't have an in-browser JS compiler, LESS does.
* [Grunt](http://gruntjs.com "oink!") to put together client side stuff & copy the rest
* [Fabric](http://www.fabfile.org/ "smooth") to put stuff on the server and run bits and pieces
* [npm](https://www.npmjs.com/ "nodey") for installing grunt stuff.



{% endblock post_right %}
