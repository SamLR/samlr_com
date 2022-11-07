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

in *theory* this now all runs in docker:
```bash
$ docker build -t samlr .
$ docker run --rm -v $PWD:/app -p 8000:8000 samlr
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


