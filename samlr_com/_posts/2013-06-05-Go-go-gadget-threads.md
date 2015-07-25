--- BEGIN YAML HEADER ---
layout: post
summary: My initial thoughts on Google's "Go"
---- END YAML HEADER ----
{% block post_body %}
<div class="breakout-block">
**Health Warning**

1. I'm not a ninja/guru/neckbeard so it's very likely that what ever I say here is wrong
2. My main points of comparison are C++ and Python (because that's what I use).
3. By definition, these are first impressions (mainly of Go's language features, not syntax[[1](#footnote1)<a id="jumpback1"></a>]) and as such subject to change (like everything else I write).
4. Go is designed to be highly concurrent, this is not an area of programming I have lots of experience with so my ability to comment on what is arguable Go's most important feature is slightly limited.
5. I'm discussing the language itself, not implementation speeds or anything like that

That said; on with the post...
</div>
I'm soon to be starting a new job, as part of this I'll be using Google's "[Go](http://golang.org/ "Go, go gadget links!")" programming language[[2](#footnote2)<a id="jumpback2"></a>] for some of the systems work, obviously, rather than work on my PhD, which is less fun and what I should be doing, I decided to start looking at Go.

According to the font of all knowledge ([Wikipedia](http://en.wikipedia.org/wiki/Go_(programming_language) "It's OK to reference it in a blog!")) Go is an:
<blockquote>
  Open source, compiled, garbage-collected, concurrent systems programming language
  <p class="text-right">
    <small>...says, some guy on <cite title="Wikipedia">[Wikipedia](http://en.wikipedia.org/wiki/Go_(programming_language) "So many 'Gos'....")</cite></small>
  </p>
</blockquote>
it uses C-style syntax with a smattering of new features. The focus of this post is going to be purely my first impressions having worked through the [go-tour](http://tour.golang.org "See the sites!") and the language [spec](http://golang.org/ref/spec "Specification. Hopefully not too speculative").

Probably the first thing that sticks out in Go (beyond the *mostly* C-like syntax[[1](#footnote1)<a id="jumpback1"></a>]) is the inclusion of `strings` and `maps` as in-built types. Having spent a most of the last few years using C++ and Python it's lovely to have one of my favourite features (maps) built into a compiled language.

Strings and maps seem to be exactly what you'd expect: a string of characters and a hash table of key-value pairs. One interesting thing to me is that Go explicitly uses UTF-8 (rather than ASCII) although it does mean that instead of the single type `chars` you now have both `runes` and `bytes`. Bytes being explicitly 8bit, UTF-8, characters whilst runes are their chunkier 32b cousins (representing Unicode code-points).

Whilst we're on (very) basic types: floats must be specified with a number of bits accuracy (e.g. `float32` or `float64`)[[3](#footnote3)<a id="jumpback3"></a>] secondly `complex` is an inbuilt type. Whilst a nice inclusion are there really that many people who use complex numbers? I'd have thought a type `ValueWithError` would be more useful, especially if it dealt with error propagation properly...

Next up are slices (and their parents: arrays), these took me a little longer to grok. Part of my confusion was because slices look (almost) identical to arrays :`[]int` vs `[3]int` to declare a slice of ints and an array of ints respectively (you can also create a slice directly from an array using `x = y[:])`. Coming from Python I'm used to thinking of slices a function of lists and tuples rather than as an independent type. Ultimately, in Go, arrays are essentially unchanged from C: fixed length sets of elements indexed via an integer. Slices on the other hand are more dynamic: representing a subsection of an array their elements may or may not be allocated and a slice object doesn't have a fixed size (although the underlying array will). One slightly confusing thing about slices is that they have a capacity *and* a length. The capacity is the total size of the underlying array whilst the length is the number of initialised elements. Somewhat strangely the only way to write to un-initialised elements (i.e. those that are within capacity but not yet used) is via the `append` or `copy` methods, and given append automatically expands a slice if its capacity is exceeded and copy is, well a copy, this makes the whole 'capacity' concept feel a little superfluous[[4](#footnote4)<a id="jumpback4"></a>].

As you'd expect from a modern language Go has several inbuilt functions for getting information about objects: `len` which returns the number of elements in what ever you call it on. As well as `len` slices also have a `cap` function that returns the capacity of the slice. There's also a version of `new`, which returns initialised memory for what ever type you want. `make` which creates maps, arrays and slices to order and `delete` which removes elements from a map.

Finally there's range, which is a gripe of mine, it's not technically a function and can only be used in `for` loops but I'll keep it here anyway, oh BTW these are only `for` loops in Go, no more `while` or `do`. Anyway, `range`, as you'd expect, iterates over what ever you pass it; the catch is it will return different things depending on what you call it on: the index and the element (arrays and slices) *or* the key and the element (maps) *or* just the the next value (channels). In addition to that for slices, arrays and maps if you don't have a variable to receive the second item you only get the index (or key) but remember channels only get elements. This is one of the few bits of Go I'm really not happy about, whilst the compiler should make sure this always works the developer is going to have to stop every time they encounter a `for range` loop to figure out what's being iterated over and what's actually being assigned. I can see the type checking required to cope with passing either a channel or another array-like object to a function that intends to iterate over that object getting annoying.

Next on the "oh, that's interesting" list are classes, or rather the lack there of. Go is very much closer to C than anything else I've used, it has structs and that's about it. Methods (i.e. functions called with a specific type) exist but are essentially no different from functions. Talking of functions Go makes passing around functions a lot easier than I've found to be the case in C[[5](#footnote5)<a id="jumpback5"></a>]. As you'd expect in a language that with treats functions as first class objects they can be returned as closures but Go doesn't allow nesting (something I'm sure I'll miss from Python if only for the combination of readability and scope control).

An interesting feature I've yet to play about with too much is Go's `defer` statements. Whilst executing a function may defer other calls, these are evaluated at the point of deferral but only executed immediately prior to the calling function's return (in a [LIFO](http://en.wikipedia.org/wiki/LIFO_(computing) "Not to be confused with li-lo") order). The obvious use case for this is making sure that you relinquish resources and because defered calls should always execute (even if the function returns because of a panic) they seem like a nice way of cleaning up after yourself. The downside is again loss of instant readability as statements that will execute right at the end of the function may be littered throughout its body.

Before leaving functions alone I'll touch on Go's `interface` type. This (unsurprisingly) allows you declare a set of function signatures that a type must implement in order to be considered to have that interface, obviously this gives you control as to what goes into your functions. Combined with type aware switch statements this seems to give some powerful branching functionality based on what you pass in, unfortunately the syntax for this feels fairly inelegant:
  
    func a(b interfaceImplementer) {
      var x interface{}
      switch x = b; x.(type){
        case implementationA:
          fmt.Println("you used method A!")
        case implementationB:
          fmt.Println("you used method B!")
      }
    }
    
as the declaration of x can't be rolled into the switch [[6](#footnote6)<a id="jumpback6"></a>] statement. Go only allows [SimpleStmts](http://golang.org/ref/spec#SimpleStmt "Simple? You lie...") prior to the test expression, you can do the assignment but not the declaration. Interfaces strike me as a feature that's required to unlock a lot of the dynamic power of Go but I've yet to have it reasonably explained and not seen many clear code examples, hopefully the [Effective go](http://golang.org/doc/effective_go.html "How to leave, well") tutorial will help.

Talking of powerful I guess it's time to address what many would consider Go's key assets: "goroutines" and "channels". Initiated with a simple `go` and `chan <type>` respectively these two features allow you to easily spawn threads and then pass information between them in fairly intuitive way. 

As I said at the top, despite working with VHDL concurrency is something that I'm only just starting to learn so I'm not sure how well I can comment on this (arguably vital) aspect of Go ... but I'll stick my neck out anyway: I'm impressed. From messing about with a couple of simple systems it's obvious that concurrency gives *huge* scope for simple, clean implementations (although again at the cost of "look once" readability). Go's implementation seems simple: pretty much any expression[[7](#footnote7)<a id="jumpback7"></a>] can be assigned to a thread and channels act either as simple variables or buffers in order to pass things between them. The `select` statement[[8](#footnote8)<a id="jumpback8"></a>] looks and acts like a `switch` but selects the next non blocking channel from its list or, if there are multiple non-blocking channels: a random one.

The majority of problems I've encountered so far with goroutines and channels are likely due to my lack of knowledge. Specifically they're mainly to do with figuring out how/when to close a channel[[9](#footnote9)<a id="jumpback9"></a>] as well as that little problem actually thinking concurrently. In writing this I was going to glorify a concurrent implementation of a [prime sieve](http://golang.org/ref/spec#An_example_package "Better than a colander") but I'm not actually sure this is a good use of concurrency, I also realised that it's ultimately a procedural implementation with obfuscation.

On the topic of obfuscation: multiple return values, Go allows them, much like Python if you `return a, b` then you get `a` and `b` back. Simple. Unless you're an inbuilt function like `range` where you can return either the index or the index *and* the element, luckily this ambiguity is limited but doesn't do much to help readability. The second problem with multiple returns is the use of named variables: in a declaration like:

    func f() (a, b int)

Go implicitly initialises `a` and `b` then, when `return` is encountered those values are automatically returned whether or not they're actually part of the return statement and with whatever values they happen to have at the time. In some ways this is nice, especially if a or b happens to be an error value then you can add arbitrary return statements and the error value will be returned without you having to remember to add it. That being said it doesn't make quickly reading code easy if you have to check back to the function declaration to be sure of which values you are actually returning and where they were last assigned to (and with what).

So, those are my (many) first impressions of Go. Over all it doesn't feel objectively[[10](#footnote10)<a id="jumpback10"></a>] much better or worse than other languages. There are a couple of features that I feel could be very easily abused and I think some of them could make code tricky to read but these are mainly stylistic chooses so should be avoidable. Currently I only have one major gripe which is the `range` function, I think 7 return types with 1 which breaks the paradigm used by the other 6 is just bad[[11](#footnote11)<a id="jumpback11"></a>]. I'm still feeling my way with a lot of the language so there are still lots of 'keep trying until it works' type solutions being produced but it seems powerful and I think the concurrent aspects will be very interesting. Overall (and unlike Python or C++) Go feels very, *very*, focused: it's written with a few specific use-cases in mind and if your project falls within one of those: excellent, if not: probably best to use something else. 

Feel free to [email](mailto:sam@samlr.com "mail me!") me any questions, comments, corrections or criticisms and I'll try to respond.

**PS** I'll try to either keep this updated or keep any further posts on learning Go linked together, I don't yet have tags or similar implemented on the blog but I have a few ideas!


{% endblock post_body %}
{% block footnote %}
[1]<a id="footnote1"></a> Go's syntax is basically C like, heavily enforced and, in a couple of cases ['backwards'](http://golang.org/doc/articles/gos_declaration_syntax.html "They're sort of right"), other than that I'm not too bothered... With the exception of named [return values](http://golang.org/ref/spec#Return_statements "type 3...") which I think has potential to be confusing and will discuss later. [*[back](#jumpback1)*]

[2]<a id="footnote2"></a> "Go", not to be confused with the *other* programming language "[Go!](http://en.wikipedia.org/wiki/Go!_(programming_language) "The '!' makes all the difference")" which predates Google's offering by 6 years and is very different. [*[back](#jumpback2)*]

[3]<a id="footnote4"></a> The same can be done for integers but the generic `int` is also valid, this is not true for floats. [*[back](#jumpback4)*]

[4]<a id="footnote3"></a> As far as I can see the main use is if you want to override the default behaviour of append which is to double the length of the underlying array, I guess this is useful but it seems like a strangely specific use-case. [*[back](#jumpback3)*]

[5]<a id="footnote5"></a> In fact one of the core principals of Go seems to be have the eradication of parentheses, possibly spurred by the number required for passing function pointers anywhere, they seem to have been pretty successful. [*[back](#jumpback5)*]

[6]<a id="footnote6"></a> Technically this is a special type of switch statement know as a [Type Switches](http://golang.org/ref/spec#TypeSwitchStmt "Scroll up a bit for the start of that section..."). [*[back](#jumpback6)*]

[7]<a id="footnote7"></a> Modulo some in-built functions and Go's `init` functions, full details are (obviously) in the [spec](http://golang.org/ref/spec#Go_statements "The no-gos"). [*[back](#jumpback7)*]

[8]<a id="footnote"></a> A glorified `switch` statement for channels. [*[back](#jumpback)*]

[9]<a id="footnote9"></a> From what I can see the basic way is to create a function that calls the function you want to thread, have that work recursively then have the controlling function close the channel. [*[back](#jumpback9)*]

[10]<a id="footnote10"></a> Yes, I can have objective feelings, so sue me. [*[back](#jumpback10)*] 

[11]<a id="footnote11"></a> Especially as the [receive operator](http://golang.org/ref/spec#Receive_operator "recv, ok?") for channels can return two values (the value and an 'ok'), why not make range give you that, or a count of things received and the value or nil and then the value or... [*[back](#jumpback11)*]
{% endblock footnote %}

{% block post_right %}
###Further, better reading###
* [The Go tour](http://tour.golang.org "A really good scratch pad")
* [The Go specification](http://golang.org/ref/spec "All the fun of Extended Backus-Naur Form").
* [Effective go](http://golang.org/doc/effective_go.html "How to leave, well") I've not finished reading this yet but it does clear up many of the issues in the main part of the post.

{% endblock post_right %}
