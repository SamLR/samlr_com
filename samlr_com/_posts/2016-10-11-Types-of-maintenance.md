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
<dd>This is, I suspect, the type of maintenance that is most often *designed* 
    for. It involves making sure that your interfaces are clean. That your 
    extension points are accessible. Ultimately, that you can implement the 
    features you want with a minimum of fuss.
</dd>
<dt>Long-term extension</dt>
<dd>This is, I think, the maintenance that's least talked about. This is the 
    source of horror: legacy code. This is the maintenance that involves 
    spending 6 hours flicking between 6 different files just to find where 
    that call is actually being made and cursing whoever it was that designed
    this Byzantine mess.</dd>
</dl>

Firstly, I'm not going to talk much about designing for ease of repair as, I 
think, it's mostly a case of following best practice and choosing sensible 
names for things[[1](#footnote1)<a id="jumpback1"></a>].

The reason I split extension into short and long term is that I think these 
are often in opposition. In the short term you'll have a fairly clear idea of 
the changes you'll need to make and how to make them. You'll design systems 
that facilitate this with clever[[2](#footnote2)<a id="jumpback2"></a>] wrappers and complex structures. These are often  

{% endblock post_body %}

{% block footnote %}
[1<a id="footnote1"></a>]: I realise this is a 
[hard problem](http://martinfowler.com/bliki/TwoHardThings.html). [[*back*](#jumpback1)]
[2<a id="footnote2"></a>]: As in actually clever rather than just needlessly 
complex, if it's the later you already have problems. [[*back*](#jumpback2)]
{% endblock footnote %}
