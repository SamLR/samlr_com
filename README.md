# My website

Because otherwise I forget how this all works...

## Basic Post template

```
--- BEGIN YAML HEADER ---
layout: post
summary: 
---- END YAML HEADER ----
{% block post_body %}
{% endblock post_body %}

{% block footnote %}
{% endblock footnote %}

{% block post_right %}
{% endblock post_right %}
```

## Running

Running the server
```bash
$ pipenv run server
```

Building the CSS
```bash
$ gulp styles       # one time
$ gulp              # By default will watch the sass
```

Static build
```bash
$ guld build  # Makes everything
```

## Publishing

```bash
$ ./publish.sh
```

## Installing

Currently using `pipenv` and `npm`

```bash
$ pipenv install
$ npm install -D
```
