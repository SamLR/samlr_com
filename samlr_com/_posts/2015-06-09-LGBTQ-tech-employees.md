--- BEGIN YAML HEADER ---
layout: post
summary: Quick write up of my attempts to determine the number of LGBTQ people working in technology.
---- END YAML HEADER ----
{% block post_body %}
A friend of mine asked this morning if anyone had any numbers for people who identify as LGBTQ and work in technology. Taking this as a challenge I spent the next two hours trying to find out. This is a write up of what I found but the short version: we don't know. There is some data but it's far too sparse to be useful. The rest of this post will be vague ramblings about what I did find out. If you'd like to follow along at home (or argue with me) I've written up a [sister post](2015-06-09-Using-GSS.html) to this one discussing using GSS as it's not the most intuitive interface.

----

As with any good bit of research the first port of call is to spam google with every variant of the request you can find, obviously this yields lots of results. There's a fair bit of information on diversity in general (Techrepublic collate 10 companies' diversity reports [here](http://www.techrepublic.com/article/diversity-stats-10-tech-companies-that-have-come-clean/ "all the reports!")) and whilst most of the give information of the racial mix of their staff none of them give information on their sexuality.

There are, obviously, a fair number of estimates of how much of the populace identifies as LGBTQ but there doesn't seem to be any that correlate this with their workplace.

Anyway I eventually ended up finding the [GSS](https://gssdataexplorer.norc.org), a survey conducted by NORC [[1](#footnote1)<a id="jumpback1"></a>], every other year *since 1972* which is pretty cool. It seems to be pretty extensive (nearly 900 'variables' [[2](#footnote2)<a id="jumpback2"></a>] for 2014 and 59,000 surveys over 42 years). It's also (despite the shopping cart) apparently free.

Out of these variables I found two that address our question:

* [**Indus10:**](https://gssdataexplorer.norc.org/variables/17/vshow/) "Respondent's occupation, prestige and industry"
* [**Sexornt**](https://gssdataexplorer.norc.org/variables/5081/vshow/) "Which of the following best describes you?"

The former isn't really a question but it allows us to filter out people working in 'tech' from the 2,538 respondents for 2014. The answers that I decided seemed 'techy' were:

* 6490 "Software publishers"
* 6672 "Internet publishing and broadcasting and web search portals"
* 6680 "Wired telecommunications carriers"
* 6690 "Other telecommunications services"
* 6695 "Data processing, hosting, and related services"
* 6780 "Other information services"
* 7380 "Computer systems design and related services"
* 7390 "Management, scientific, and technical consulting services"
* 7490 "Other professional, scientific, and technical services"

It's not an excellent selection and I may have missed some or included others I shouldn't but never mind, hopefully they balance out.

This reduced the respondents to just 77, about 3%, which seems in-line with the number of tech employees in the [OES](http://www.bls.gov/oes/current/oes_nat.htm)[[3](#footnote3)<a id="jumpback3"></a>]. For these remaining 77 each had given one of 6 possible answers to the question of their sexuality:

* "Gay, lesbian or homosexual"
* "Bisexual"
* "Heterosexual or straight"
* "Don't know"
* "No answer"
* "Not applicable"

Firstly there's the obvious lack of any explicit "queer" option. Secondly for 3 out of the 6 answers we just don't know how the respondent identifies. If we hunt for the "T" we can go look at the [gender](https://gssdataexplorer.norc.org/variables/5333/vshow/) variable but it's even worse here: the only options are "male", "female" or another 3 variants of "N/A". This will become a running theme: most surveys seem to only manage the first 3 letters of LGBTQ.

So we have 77 possible LG or B techies. Here's the break-down of their responses (I've also included the total responses for 2014):

<table>
<tr><th>Response</th><th>Tech 2014</th><th>Total 2014</th></tr>
<tr><td>Gay, lesbian or homosexual</td><td>2</td><td>45</td></tr>
<tr><td>Bisexual</td><td>1</td><td>65</td></tr>
<tr><td>Heterosexual or straight</td><td>67</td><td>2,195</td></tr>
<tr><td>Don't know</td><td>0</td><td>6</td></tr>
<tr><td>No answer</td><td>3</td><td>39</td></tr>
<tr><td>Not applicable</td><td>4</td><td>188</td></tr>
<tr class="total"><td>Total</td><td>77</td><td>2,538</td></tr>
</table>

If we ignore the "Don't know", "No answer" and "Not applicable" results we end up with 3 LGB respondents and 67 heterosexuals. This gives us 4.2% of tech workers being LGB (as to Q or T, who knows? Not the GSS). Lets talk about that number, firstly:

**Any percentage calculated from a sample of fewer than 100 is almost certainly horribly inaccurate**

that's why this number is down buried here rather than sitting in the lede. It's also likely why there aren't any reports or articles on this. It's a pretty useless result. 

Adding a single LGB person (i.e. 4 out of 71) changes the percentage to 5.6%. If we assume (and, as I said, we shouldn't) that all the NA responses are LGBTQ people we get 13.0%.

As I said at the start: How many LGBTQ people are there in tech? We don't know. We need a lot more data. Especially if we want to ask useful questions like "does tech have a higher or lower percentage of LGBTQ people than the norm?", "Which roles do LGBTQ people in tech generally occupy?" or "Which industries have a higher percentage of LGBTQ people and what can we learn from them?".

With this data I can't really say much. A lot of people I spoke to about this result thought the estimate was low but I think there's a strong sampling bias there. This 4% value is, at least, in-line with the [GSS' total value](https://gssdataexplorer.norc.org/projects/687/variables/5081/vshow) (this also raises to about 13% if you include all NA's but that's not a good idea).

In fact, probably the only really interesting result from this is that the number of people who will self identity as LGBTQ in surveys is much lower than the commonly held value of 10%. In the UK the [IHS](http://www.ons.gov.uk/ons/dcp171778_280451.pdf) gives a figure of 1.5% for people who identify as LGB (no T or Q again...). This rises to only 2.7% in under 25's. In the US the [NHIS](http://www.cdc.gov/nchs/data/series/sr_02/sr02_169.pdf) found LGB (still no T or Q) respondents to be 2.3% of the populace (with an additional 1.1% answering variants on "N/A"). Anonymous or un-official surveys seem to get higher percentages, [one from the Guardian](http://www.theguardian.com/lifeandstyle/2014/sep/28/british-sex-survey-2014-nation-lost-sexual-swagger) found ~8% identifying as either homosexual or bisexual [[4](#footnote4)<a id="jumpback4"></a>]&nbsp;(again this rises, apparently to 21% in under 25's). Similarly in the US the [Williams Institute](http://williamsinstitute.law.ucla.edu/wp-content/uploads/Gates-How-Many-People-LGBT-Apr-2011.pdf) found 3.5% of people were LGB with 0.3% as T (finally!) but 11% had experience same-sex attraction.
{% endblock post_body %}

{% block footnote %}
[1]<a id="footnote1"></a> "The Independent research organization NORC at the University of Chicago", apparently the NORC bit stands for "National Opinion Research Centre" which all feels a bit redundant. Also: NORC! [*[back](#jumpback1)*]

[2]<a id="footnote2"></a> Questions basically; in fact they are questions. Not sure why they need to use 'variables' for this... [*[back](#jumpback2)*]

[3]<a id="footnote3"></a> Category 00 (all occupations) has 135m people of these 3.8m are in category 15 (computer and mathematical occupations) [*[back](#jumpback3)*]

[4]<a id="footnote4"></a> For some reason there's an infographic on that page with heterosexual as 44%. I'm assuming it's a typo but you can dream... [*[back](#jumpback4)*]

{% endblock footnote %}
{% block post_right %}

### Resources ###


* [Google sheet data I used](https://docs.google.com/spreadsheets/d/1MQNmdr-L-VNDtb34oSEMsZWgX81y90MgGHb4zvVKApE/edit?usp=sharing) - from The independent research organization NORC at the University of Chicago.
* [GSS](https://gssdataexplorer.norc.org) - General Social Survey data explorer
* [GSS landing page](http://www3.norc.org/Gss+website/) - more general information
* [OES](http://www.bls.gov/oes/current/oes_nat.htm) - May 2014 National Occupational Employment and Wage Estimates United States
* [Integrated Household Survey](http://www.ons.gov.uk/ons/dcp171778_280451.pdf) - from the ONS
* [NHIS](http://www.cdc.gov/nchs/data/series/sr_02/sr02_169.pdf) - CDC's National Health Interview Survey
* [Williams Institute](http://williamsinstitute.law.ucla.edu/wp-content/uploads/Gates-How-Many-People-LGBT-Apr-2011.pdf)
* [My post on using GSS](2015-06-09-Using-GSS.html)

**NB**: several of the links on this post go to the GSS variables page. For some reason these will show an error the first time you go to them. When you see this error select the URL and hit enter again and it should load correctly. This doesn't seem to work with refresh but URL + enter does. I assume this is something to do with the GSS single page app. Sorry.


{% endblock post_right %}