--- BEGIN YAML HEADER ---
layout: post
summary: Making a box for Splendor
---- END YAML HEADER ----
{% block post_body %}

I really like the game [Splendor](https://boardgamegeek.com/boardgame/148228/splendor). It's interesting, easy to teach and reasonable quick. The box is also about 3x larger than it needs to be[[1](#footnote1)<a id="jumpback1"></a>]. I've also recently gained access to a laser cutter again so decided to make a better box for it. 

Here are some photos of the process and general notes (click for bigger). I've got a separate [post](2019-02-14-Fusion360-for-laser-cutting.html) covering some of the more technical details

[![First sketches](/images/splendor_box/notebook.jpg "My initial sketches and measurements of the box")](/images/splendor_box/notebook.jpg)

Before you jump into a CAD program sketch out your plans and take all the measurements you can think of: it makes life so much easier.

[![Dominion test box](/images/splendor_box/dominion.jpg "A box I made to hold Dominion cards as a proof of concept")](/images/splendor_box/dominion.jpg)

First results of jumping into a CAD program ([Fusion360](https://www.autodesk.co.uk/products/fusion-360/overview)). I thought I could use Fusion to produce the .dxf files for cutting but wanted a simple test. This was the second "simple" test where I wanted to mess about with parametrisation a bit (the number of columns of cards can actually be specified and the design re-created).

[![Fusion360 design](/images/splendor_box/fusion360.png "Design of the box in Fusion360")](/images/splendor_box/fusion360.png)

Having tested the workflow in fusion360: onto the main event! This took a lot of tweaking and time (which you, luckily, get to skip). The cut files (.dxf) are then exported and arranged ready to be cut.

[![Cutting begins](/images/splendor_box/on_cutter.jpg "The first sheet of parts being cut")](/images/splendor_box/on_cutter.jpg)

This is what the parts look like once the cutting has finished. I ended up needing two sheets of plywood (210x400mm)

[![Dry fitting](/images/splendor_box/dryfit_test_fill.jpg "Dry fitting and testing")](/images/splendor_box/dryfit_test_fill.jpg)

With all the parts cut I could dry fit them and test that everything fitted. The lid's missing here because I was letting it dry having steamed it to apply the bed to the live hinge (I forgot to photograph this...)

[![Finished box](/images/splendor_box/finished_open.jpg "The finished box with all the components stowed away")](/images/splendor_box/finished_open.jpg)

And finally glue up and ready to go.

{% endblock post_body %}

{% block footnote %}
[1<a id="footnote1"></a>]: by my calculation the box I have for Splendor is about 3,402cm^3 for roughly 1,084cm^3 of components. Yes I calculated it. What? [[*back*](#jumpback1)]
{% endblock footnote %}

{% block post_right %}

## Just the pictures! ##

[<img style="width: 77px; height: 57px;" alt="Notebook designs of Splendor" src="/images/splendor_box/notebook.jpg">](/images/splendor_box/notebook.jpg)
[<img style="width: 77px; height: 57px;" alt="Box for Dominion cards" src="/images/splendor_box/dominion.jpg">](/images/splendor_box/dominion.jpg)
[<img style="width: 77px; height: 57px;" alt="Box for Dominion cards with the lid closed" src="/images/splendor_box/dominion_close.jpg">](/images/splendor_box/dominion_close.jpg)
[<img style="width: 77px; height: 57px;" alt="Fusion360 Splendor design" src="/images/splendor_box/fusion360.png">](/images/splendor_box/fusion360.png)
[<img style="width: 77px; height: 57px;" alt="Parts being cut on the laser cutter" src="/images/splendor_box/on_cutter.jpg">](/images/splendor_box/on_cutter.jpg)
[<img style="width: 77px; height: 57px;" alt="Dry fit of the Splendor box" src="/images/splendor_box/dryfit_empty.jpg">](/images/splendor_box/dryfit_empty.jpg)
[<img style="width: 77px; height: 57px;" alt="Testing the components fit the Splendor box" src="/images/splendor_box/dryfit_test_fill.jpg">](/images/splendor_box/dryfit_test_fill.jpg)
[<img style="width: 77px; height: 57px;" alt="Finished Splendor box, closed" src="/images/splendor_box/finished_closed.jpg">](/images/splendor_box/finished_closed.jpg)
[<img style="width: 77px; height: 57px;" alt="Detail of the live hinge on the Splendor box" src="/images/splendor_box/finished_closed_reverse.jpg">](/images/splendor_box/finished_closed_reverse.jpg)
[<img style="width: 77px; height: 57px;" alt="Open Splendor box" src="/images/splendor_box/finished_open.jpg">](/images/splendor_box/finished_open.jpg)

{% endblock post_right %}
