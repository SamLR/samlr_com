--- BEGIN YAML HEADER ---
layout: post
summary: What do we mean when we say "design to maintain"?
---- END YAML HEADER ----
{% block post_body %}
A recent thought I've had, which I've not seen discussed elsewhere (feel free
to link me my wrongness), is that we may not always be clear about what we
mean when we claim maintainability is a design goal. A lot of what I'm going
to cover here is generally discussed but I think not quiet in as an explicit
manner as I've been thinking about it.

As I see it there are three types of maintenance:

<dl>
<dt>Repair</dt>
<dd>This is probably the most obvious type of maintenance, something has gone
    wrong. Fix it. Most of the design around this is to do with making sure
    there is reasonable test coverage, that there is sensible logging and
    that when something goes wrong you can sort it out quickly.
</dd>
<dt>Short-term extension</dt>
<dd>I think this is what people think about when they design for maintenance:
    creating clean interfaces and making it easy to implement the features.
</dd>
<dt>Long-term extension</dt>
<dd>This is, I think, the maintenance that's least talked about. This is the
    source of horror: legacy code. This is the maintenance that involves
    spending 6 hours flicking between 6 different files just to find where
    that call is actually being made and cursing whoever it was that designed
    this Byzantine mess.</dd>
</dl>

Firstly, I'm not going to talk much about designing for ease of repair as, I
think, it's mostly a just case of following best practice and choosing sensible
names for things[[1](#footnote1)<a id="jumpback1"></a>].

Discussion of the other two types are, I think, what's interesting and
important. Firstly it's important to note the conditions under which I came up
with this: working in a small team (four people) on a fairly 3 reasonably sized
web-apps (basically two business analysis tools that operate on different scopes
then a suite of CRUD tools to interact with the data).

On the one hand this sort of set up means that the 3 apps were easy to work on
as they had good separation of concerns. On the other hand this means that there
are whole sections of the code base that still need maintaining which haven't
been actively developed on in years.

This split, I think, highlights the tension between the two types of extension.
As a team we try to write as good code as we can but we tend to work towards an
architecture which supports the features we know we want to implement. The
downside of this approach is when, inevitably, the project owner decides there
should be a new feature if we've not planned for it we have to fight our
architecture, tests or systems.

There's not much to say beyond that. I don't know if there is a real distinction
nor if there's anything to do in order to relax the tension (other than follow
best practice, especially documenting more high level architecture) but it's
something I'll be thinking about and may even revisit.

{% endblock post_body %}

{% block footnote %}
[1<a id="footnote1"></a>]: AKA a [hard problem](http://martinfowler.com/bliki/TwoHardThings.html). Also remember: "just" is a euphemism for "4x more work
than you expect". [[*back*](#jumpback1)]
{% endblock footnote %}
