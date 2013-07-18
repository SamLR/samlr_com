--- BEGIN YAML HEADER ---
layout: post
summary: A quick tip on making the most of the command-overlay
---- END YAML HEADER ----
{% block post_body %}

I'm deep in my first week at my new job so this will be a quick post. I've just moved to a new text editor ([Sublime](www.sublimetext.com "It is, you know")) from my long time friend: [Textmate](www.macromates.com "Fairwell, old friend."), I'm not going to review either of them here (as that will be a long post) suffice to say Sublime isn't perfect but does seem to be a bit closer to it than Textmate...

[There](http://iamkeir.com/post/32800623503/sublime-text-2-tips-for-getting-started "Getting started") [are](http://net.tutsplus.com/tutorials/tools-and-tips/sublime-text-2-tips-and-tricks/ "Tips this time") [plenty](http://wbond.net/sublime_packages "all the packages") of blogs about using sublime, so I'm not going to rehash what others have said already. 

The tip its self is pretty simple and consists of two parts. The first part is due to the control sublime gives you over keyboard shortcuts: 

	[
		{ "keys": ["super+shift+n"], "command": "new_window", "args": {} }
	]

Where `keys` indicates which combination to use; it's a list as you can use two part commands, eg `["super+k", "super+b"]` is super+k then super+b (toggles sidebar). The `command` portion specifies which command to use (in this case new window, which doesn't take any arguments). 

The second part is specific to one command: `show_overlay` which displays the control overlay. The overlay comes in two flavours: `goto` and `command` (accessed via `super+p` and `super+shift+p` respectively). The goto overlay allows you to jump around whilst the command overlay allows you to access commands. Which you get is specified in via `args`, args also allows you to specify `text` to start the search with (this is how the `@` search for symbol and `:` go to line are implemented) by allowing you to specify text to begin with you can more rapidly access certain searches eg:


	{ 
		"keys": ["super+shift+g"], "command": "show_overlay", "args": 
		{
			"overlay": "command_palette",
			"text":"git"
		} 
	}


This gives me access to the commands of the Git package by pressing super+shift+g.

***Warning:*** be careful of trailing commas: the config files that sublime uses are JSON and JSON doesn't like trailing commas... (luckily sublime is pretty good at alerting you to these problems).


{% endblock post_body %}

{% block post_right %}
{% endblock post_right %}