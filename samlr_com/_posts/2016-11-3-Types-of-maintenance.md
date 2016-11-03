--- BEGIN YAML HEADER ---
layout: post
summary: What do we mean when we say "design to maintain"?
---- END YAML HEADER ----
{% block post_body %}
A recent thought I've had, which I've not seen discussed elsewhere (feel free
to [link](/about_me.html) me my wrongness), is that we may not always be clear 
about what we mean when we claim maintainability is a design goal. I'm not sure
I have much to add to the store of tools for actually tackling this but, maybe,
I can add to the store of tools for thinking about it.

As it stands I consider there to be the three types of maintenance:

* Repair
* Short term extension
* Long term extension

Repair is fairly obvious (fix the bugs) and extension is what I think we often
mean when we talk about maintainability: add a button, implement a feature,
change a widget.

I've split extension in two as I would say that we generally have very
different intentions over the short and long term when designing for 
maintainability. In the short term we want to add our planned features,
in the long term we want to refine or completely change them, regardless
the long term changes we want to make are those we haven't planned for.

> Aside: this feels like it mirrors Donald Rumsfeld's famous "known
> knowns" (what we have), "known unknowns" (what we want to add) and "unknown
> unknowns" (the changes we don't anticipate).

I think the core tension between short and long term extension lies in 
fragility. A common trap seems to be the complex solution which makes
it easy to do the tasks you have in front of you and ties you up in endless
knots when you come back to it.

I'm not sure there's an obvious solution to this tension other than to try
and make things as simple as they can be and documented well but this may also
be something I re-visit. I'm going to be moving into my first large team soon
so it will be interesting to how that affects my views on this.

{% endblock post_body %}