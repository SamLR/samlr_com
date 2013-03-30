--- BEGIN YAML HEADER ---
layout: post
summary: What I learnt about Bash's 'Here-Documents'.
---- END YAML HEADER ----
{% block post_body %}

So, as a practicing physics research what do you think I do? 

The answer: mostly programming. In fact about 90% of my time is spent programming (the remaining 10% is spent underground in a nuclear test facilities[[1](#footnote1)<a id="Jumpback1"></a>]).

As part of my on going fight to produce enough work to have something to write a thesis about I recently had to renew my acquaintance with my group's batch farm. This is a lovely set of computers that will take a script (correctly submitted to the queue), run it, and then after some amount of time spit out your results. In theory. There are two down sides to this theory: first you have to have a script to submit in the first place, second you have to make sure it'll run.

Now, I'm fortunate in that most of the programming I do is towards the simulation of particles within our experiment and, as such, is lovingly described as an 'embarrassingly' parallelisable process. Basically as each initial particle has nothing to do with any subsequent particle you can run each simulation at the same time. Embarrassingly easy this may be but it still means I need to create a run script for each batch of simulations to be run, so enter: *here-documents*. 


##### Here Documents #####
Here-documents are a way of getting BASH to spit out large blocks of text without having to wrap everything in "s or any other such contortions, the basic premise is that you designate a sequence (e.g. `EOM`) to mark the end of the document and then everything prior to that is treated as text being passed to whatever, for example:

    cat << EOM  # Pass everything from here on to cat
    This 
    should
    be printed 
    as is
    EOM         # Delimit the end of the doc


Simple, eh? You can of course use standard [IO redirection](http://www.tldp.org/LDP/abs/html/io-redirection.html "IO here IO there!") to pass this output to something more useful than stdout, for example: a file.

    cat > save_me.txt << MONKEY # Why stick with 'EOM'?
    This should work just the same           
    even if it is more symian
    in nature
    MONKEY                      # end it all
    
Now here we're saving to `save_me.txt` which is much more useful. This is the essence of using here-documents: you can produce much more useful documents that you normally could. In theory.

Like most things in bash there are some gotchas to be aware of, and further clever things you can do with the syntax, here's more of what I found:

##### Tab skipping #####
Apparently by using `<<-` instead of `<<` you can tab-suppress your output. Make sure you *actually have a text editor that uses tabs (not spaces)*. This bug I didn't actually spot until it was too late. Needless to say, not impressed (and very annoyed).

This means that rather than mess up your nice indented function you can create something like this:

    function dolittle
    {
        wall <<- /car_salesman
        Yes! You too can avoid ugly tabs
        in your output and poorly indented
        code! 
        Use wonder arrow and never worry 
        about anything ever again!*
        *may not be true
        /car_salesman
    }
    
Rather than having to hard align to the right in order to avoid tabs in the output beyond OCD this is useful if you're creating that's whitespace sensitive like a python script.

##### Final delimiter #####
Your final delimiter must be exactly as typed, on its own line and excluding space. For example in the following only the *final* EOM will actually end the message. Oh and the comments: they're included.

    cat << EOM     # EOM again because it's short
    this EOM won't
    nor this
        EOM
    this
    EOM neither
    EOM           # the comments do nothing! 
                  # they're included too
    EOM


##### Variables #####
Handily you can have bash expand variables inside your here document to essentially auto complete them for you. This is lovely. If, for what ever reason you don't want this you can disable it by intuitively placing your delimiter in comments.

Contrast the following two snippets, one tells you where you are:

    cat << EOM
    you are currently in $PWD
    (and have massively over engineering this)
    EOM

whilst the other is a fairly pointless variable reminder

    cat << 'EOM'                 # (or "EOM", if you like)
    $PWD holds where you are
    EOM

Note that we can use either single ' or double " quotes for our delimiter.


##### Children everywhere! #####
Placing your entire here-document in `()` will run it in its own child processes, you can also put redirects after the here-document but only if it's run as a child (to dodge the afore-mentioned final delimiter problem) e.g.:

    (
        cat <<- goodbye_cruel_world
        hello world
        goodbye_cruel_world 
    ) > bye.txt


----

[1]<a id="footnote1"></a> Not as cool as it sounds, trust me. [[back](#Jumpback1)]
{% endblock post_body %}

{% block post_right %}
{# RCNP picture #}
{% endblock post_right %}
