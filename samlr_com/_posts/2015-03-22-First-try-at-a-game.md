--- BEGIN YAML HEADER ---
layout: post
summary: I tried to make a game
---- END YAML HEADER ----
{% block post_body %}
This was a project I started a while ago (according to the git log the first commit was June 2014). I decided I wanted to try making a simple game that only had one input. I was inspired by Daniel Linssen's [ffffff](http://managore.itch.io/ffffff "all the Fs"). Unfortunately the game I've ended up with isn't really what I wanted to make but equally it taught me a lot.

With hindsight I could have probably got further making the game I wanted using a framework or similar (and I may well come back to this). I did manage to get a good distance in terms of playing around with vanilla javascript.

Anyway I made a simple platformer with a few levels. As ever the code's on [Github](https://github.com/SamLR/1D_em_up "1D").

PS. Press space to start.

------

<canvas id="game-block"></canvas>
<script src="../docs/1d-em-up/collection-utils.js"></script>
<script src="../docs/1d-em-up/graphics-utils.js"></script>
<script src="../docs/1d-em-up/platforms.js"></script>
<script src="../docs/1d-em-up/screens.js"></script>
<script src="../docs/1d-em-up/main-game.js"></script>


{% endblock post_body %}
{% block post_right %}
{% endblock post_right %}