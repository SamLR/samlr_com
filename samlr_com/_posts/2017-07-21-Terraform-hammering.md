--- BEGIN YAML HEADER ---
layout: post
summary: When, and when not, to use Terraform 
---- END YAML HEADER ----
{% block post_body %}

At work I've been using a lot of [Terraform](https://www.terraform.io/)[[1](#footnote1)<a id="jumpback1"></a>] recently which is pretty nice. It's incredibly powerful and whilst it's not perfect[[2](#footnote2)<a id="jumpback2"></a>] it is definitely filling a need.

Which might be a bit of a problem. Not so much for the tool itself but for how people use it.

I've recently been involved in a few conversations about using Terraform to manage [Github](https://github.com). For a long time I couldn't figure out why this felt so wrong to me but after the most [recent](https://twitter.com/alexstapleton/status/888419076036587521) I think I've spotted what it is. 

Github is just one of the [67 providers](https://www.terraform.io/docs/providers/index.html)[[3](#footnote3)<a id="jumpback3"></a>] that Terraform offers. This range is excellent, both for Terraform its users.

The downside is that I think it's a bit of a hammer. That's not to say it's bad or blunt just in the sense of "if all you have is a hammer, everything looks like a nail" and as its fairly alone in its niche Terraform is what people reach for.

In the case (specifically) of Github I don't believe Terraform is a good fit. Terraform manages infrastructure state. The two main use cases seem to be user management and management of repo-settings.

In the case of 


{% endblock post_body %}

{% block footnote %}
[1<a id="footnote1"></a>]: Terraform, is a [Hashicorp](https://www.hashicorp.com/) domain specific language intended to allow you to write code and have that converted into infrastructure, e.g. AWS instances or Google Kubernetes Clusters. [[*back*](#jumpback1)]

[2<a id="footnote2"></a>]: lack of proper iterators & the lack of interpolation are major annoyances. [[*back*](#jumpback2)]

[3<a id="footnote3"></a>]: at time of writing. [[*back*](#jumpback3)]
{% endblock footnote %}

{% block post_right %}{% endblock post_right %}