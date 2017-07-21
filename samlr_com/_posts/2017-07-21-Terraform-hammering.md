--- BEGIN YAML HEADER ---
layout: post
summary: Why I don't think you should manage Github from Terraform
---- END YAML HEADER ----
{% block post_body %}

Recently at work some colleagues have been looking at using [Terraform](https://www.terraform.io/)[[1](#footnote1)<a id="jumpback1"></a>] to manage [Github](https://github.com)[[2](#footnote2)<a id="jumpback2"></a>] which felt wrong somehow but I couldn't place why. I think I now have several reasons:

* Terraform manages state, Github has very little state
* You lose a lot of context in Terraform Vs. viewing the page on Github
* Self-serve is a feature
* Automation isn't free

Terraform seems primarily aimed at managing infrastructure state. I.e. taking a known state and changing it into some other state. Github has very little state, via Terraform you can currently manage:

* Repos (branch protection, collaborators and webhooks)
* Organisations (membership, webhooks)
* Teams (membership, repositories)
* Issue labels

I'm going to ignore issue labels which leaves us with organisations and teams (i.e. permissions); and repos.

In managing permissions there are three main transitions: joining, leaving and moving. The most common changes will be to users (joining or leaving the organisation or teams). For joining and moving there's about as much work in using Terraform as manually: you still have to type the username somewhere and be sure it's the right place. Leaving manually is easier as removing a user from an org removes them from any associated teams (in Terraform you'll have to update all those teams as well). This doesn't feel like a major win for Terraform to me (not that it's a particularly time consuming task either way). There is an argument to be made that Terraform will give you better control if you add individuals as collaborators to things but in reality you should be using Teams anyway so I don't find this convincing.

For managing repos I think the case for Terraform is even weaker. Frankly you shouldn't be changing the set-up of your repository that much (if at all). The most likely time will be when Github updates their settings[[3](#footnote3)<a id="jumpback3"></a>]

The most common argument I've heard is that you can use Terraform to specify useful defaults but in this case you're not managing state; you're templating.

This is the crux of the problem for me: Terraform is incredibly powerful but it shouldn't be doing everything. Automation is only worthwhile when the cost of maintaining it is less than the cost of manually doing the task, which in this case feels unlikely[[4](#footnote4)<a id="jumpback4"></a>].

Finally, much as I like Terraform, it still surprises me. It's a description language which means you're telling the computer to figure out how to get from a to b. Most of the time this is fine[[5](#footnote5)<a id="jumpback5"></a>] but it can lead to weird (and terrible) results. Which doesn't feel like a feature I want when it comes to managing my repos.

{% endblock post_body %}

{% block footnote %}
[1<a id="footnote1"></a>]: Terraform, is a [Hashicorp](https://www.hashicorp.com/) domain specific language intended to allow you to write code and have that converted into infrastructure, e.g. AWS instances or Google Kubernetes Clusters. [[*back*](#jumpback1)]

[2<a id="footnote2"></a>]: This is specifically about managing Github. I don't have as much experience with Github Enterprise and Gitlab will have different constraints, although I suspect the comments on repositories will still apply. [[*back*](#jumpback2)]

[3<a id="footnote3"></a>]: in which case you have to hope that:

1. Terraform provides the new feature
2. You can (safely) upgrade to use it
3. You've written your Terraform such that you can enable it with out updating the code for every repo anyway

[[*back*](#jumpback3)]

[4<a id="footnote4"></a>]: It's going to take you 30 minutes to name the repo regardless of whether you're naming it in Terraform or the Github GUI. [[*back*](#jumpback4)]

[5<a id="footnote5"></a>]: Remember, always `terraform plan` first. [[*back*](#jumpback5)]
{% endblock footnote %}

{% block post_right %}{% endblock post_right %}