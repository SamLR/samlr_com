--- BEGIN YAML HEADER ---
layout: post
summary: First version of a my current project, a 'tone garden'.
---- END YAML HEADER ----
{% block post_body %}

Apparently I've decided I have free time now (HA!). To this end I've made a (below). I'm calling it a tone garden. Firstly, be warned, it's currently horrible and sounds like crap. Secondly, be warned, I'm pretty flaky at projects so it may never get beyond this.

So what is it? It's a 'tone garden'. Click inside the border to place a box, the x position of the box determines the frequency of the sound, the y position the volume. Click on a box again to remove it.

If I don't fail at finishing things then there are a couple of things I want to do with this:

 * Better sound. Simple sine oscillators are horrible, ideally I want some way of generating pleasant 'natural' noises (think waves etc.) and having that be the x-axis.
 * Better visuals. At all. The current hope would be to write some sort of zen garden generator with the red boxes replaced by rocks. The white background would be replaced by some sort of gravel affect which would then get pleasingly racked into the typical patterns.
 * Maybe other stuff as well as rocks depending on how the natural noises go.

If you're interested the project is on [github](https://github.com/SamLR/tone_garden "hub it!") and the source code is [here](../docs/app.js "sourcey!").

------

<div>
    <!-- Start it muted -->
    <button class="btn btn-default" id="mute" data-muted="true"></button>
    <button class="btn btn-default" id="reset">Reset</button>
</div>
&nbsp;
<canvas id="garden">
    Your browser does not support HTML5's 'canvas' tags.
</canvas>
<script src="../docs/app.js"></script>

{% endblock post_body %}

{% block post_right %}
Resources (AKA stuff I knabbed):

* [Mozilla developer's network](https://developer.mozilla.org/en-US/docs/Web/API/AudioContext "because why wouldn't you use them?")
* [Violet theremin](https://github.com/mdn/violent-theremin/blob/gh-pages/scripts/app.js "more hubs!") ([demo](http://mdn.github.io/violent-theremin/ "pretty!"))
* Lots and lots of [stackoverflow](http://stackoverflow.com/ "can't remember them all")

{% endblock post_right %}