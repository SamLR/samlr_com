--- BEGIN YAML HEADER ---
layout: post
summary: Why it's painful to work with AWS IAM and how you can learn from my suffering (and their mistakes)
---- END YAML HEADER ----
{% block post_body %}

**Disclaimer:** I'm not an accredited AWS security expert or anything, this is based on spending the last few years wrestling AWS IAM policies into doing what I want. Your mileage may vary and I may be wholly wrong in any or all matters.

**One more disclaimer**: I'm assuming you know the basics of AWS IAM, i.e. I assume you know (at least generally) what `action`, `resource`, `principal` mean and what the difference between a resource policy (e.g. one attached to an S3 Bucket) and an identity policy are (e.g. one attached to a Role).

Anyway, on to it...

---

<a id="intro"></a>
## An Intro ##

AWS' [Identity and Access Management](https://aws.amazon.com/iam/) system is terrifying. Through a collection of 8211 actions[[1](#footnote1)<a id="jumpback1"></a>] you can control any of AWS' 241 services[[2](#footnote2)<a id="jumpback2"></a>]. Some services (like [arsenal](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_applicationdiscoveryarsenal.html)[[3](#footnote3)<a id="jumpback3"></a>]) define a single action whereas [EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) has over 400 with the average service having 34. On top of that each service will have some number resource types and conditions you can check (e.g. is that satellite tagged `"ion-cannon"`[[4](#footnote4)<a id="jumpback4"></a>]). Oh and there are at least 6 different places you can define these policies (here's a [list of them](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session)[[5](#footnote5)<a id="jumpback5"></a>]) then *finally* you can assign, assume and pass permissions between identities.

All of that makes working with IAM pretty overwhelming.

I'm not going to say "but here's one simple trick to make it easy" because there isn't and it wouldn't. Instead I'll start by covering my [general approach](#general-approach) then highlight some of the more [horrible things](#horrible-things) I've dealt with/ranted about

I'm going to focus on [resource policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_resource-based) and [identity policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_id-based) here but the general ideas should be applicable to the more exotic forms too (although if you're using those you probably know a lot more than I do). 

If you do want one tip though: learn to love the excitingly titled ["actions, resources, and condition keys for AWS services"](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_actions-resources-contextkeys.html) pages which list all the services, their actions, conditions and resources (surprise!)

<a id="general-approach"></a>
## General Approach ##

So how do I write a policy? The first step is a set of questions[[6](#footnote6)<a id="jumpback6"></a>] which should help you define the the boundary of [least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege). 

* **Who** do you want to grant permissions to?
    - For a resource policy this is the `principal`
    - For an identity policy this is the identity you attach the policy to (or inline it on)
    - Remember: "who" covers both humans and machines and may be shared depending on whether it's a role, group, user or policy object (although humans and machines probably shouldn't share policies).
* **What** do you want to allow (or `Deny`)?
    - These are AWS' `actions`, you can find every action for every service somewhere in the previously mentioned [actions and etc. etc. pages](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_actions-resources-contextkeys.html).
    - Start with the plain-English form (e.g. "read permissions on kinesis stream Y", "add a route table to a subnet") then see if you can find actions that ONLY do those things (e.g. `kinesis:GetRecord` and `ec2:AssociateRouteTable`[[7](#footnote7)<a id="jumpback7"></a>])
* **Where** are the resource(s) that you're granting permissions to?
    - For a resource policy this is what it's attached to
    - For an identity policy this is the `resource` term
    - It may be a specific resource (version 4 of this IAM role-policy) or a group of them (every EC2 instance in us-east-1)

With an idea of what's wanted now is a good time to look for example policies to crib from. Obviously AWS' docs are the best place to start (normally located by a search along the lines of "AWS [service] example IAM policy" because good luck navigating AWS' docs). I also try searching AWS' managed [policies](https://console.aws.amazon.com/iam/home?#/policies), these are often variations on the examples but not always and they may be exactly what you need. 

Two potential gotcha's with AWS' policies: firstly the managed policies are pretty inconsistently named[[8](#footnote8)<a id="jumpback8"></a>] so try some variations. More importantly, both AWS examples and managed policies, are often very broad (lots of `Resource: "*"`s and `Action: "ec2:*"` etc.) so make sure you know what potential sins those mighty wildcards are hiding.

Another major thing to look for when sketching a policy is whether the service you want needs other services. For example Kinesis often uses DynamoDB to implement read check-pointing while Elastic Beanstalk uses EC2, EC2-Autoscaling, Elastic Load Balancer and others services. Beyond checking the examples and reading the docs figuring out these relations is often a matter of trial and error so I start with the absolute minimum and work from there[[9](#footnote9)<a id="jumpback9"></a>].

Hopefully this should give you a policy you can start testing. In addition to just running whatever program it is I highly recommend playing around with the [AWS Policy Simulator](https://policysim.aws.amazon.com/home/index.jsp?#)[[10](#footnote10)<a id="jumpback10"></a>] I won't go into detail on using it ([docs are here](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_testing-policies.html)) but there are a important gotchas to it I wanted to flag:

* You can only directly test identities (either a specific new or proposed policy or all of the policies attached to a user or role).
* It only tests the exact interaction you ask it to test[[11](#footnote11)<a id="jumpback11"></a>] which gets confusing with services that do work on your behalf as it may not be clear *who* is doing *what*, *where*.
* The policy simulator will only simulate a resource's policy if you have permissions to access that policy AND you target that that specific resource (and even then still doesn't seem to always work for me).
* If you use conditionals these can be set in different places (e.g. global values like whether mfa was used vs resource values such as instance state[[12](#footnote12)<a id="jumpback12"></a>])
* It is only a simulation, any results you get from it should be treated very carefully.

And that's mostly it. One final tip (which doesn't really fit anywhere else) is to get a feel for how actions are named: `[service]:[Verb][Resource]`. As I cover below this allows you to write some pretty powerful policies using wild cards. Just beware: the verbs AWS services use are not consistent (e.g. would you like to `Add`, `Create`, `Change`, `Set` or simply `Tag` your tags on a resource?)

<a id="horrible-things"></a>
## Horrible things ##

To start: not a horrible thing per-say but very much a double edged sword: wildcards. Most people will know that it can be used as a suffix for actions and resources (e.g. `ec2:*` or `"arn:aws:s3:::my_corporate_bucket/*"`) but you can also use it multiple times (e.g. `ec2:*Vpc*`). You can write some very powerful policies like this (especially things like `ec2:Describe*` for a read-only policy) but just remember that the lists of actions only expand so these may end up including things you didn't intend. This is especially true in large services like ec2, talking of which...

EC2. EC2 has (as previously mentioned) over 400 actions. These cover everything from `RunInstances` (unsurprisingly, run some compute[[13](#footnote13)<a id="jumpback13"></a>]) to `StartVpcEndpointService-PrivateDnsVerification` (which, I think, starts the process that'll allow you to use your data-centre's DNS in your AWS VPC). In my opinion, this is too much, but I don't work at AWS so there's not much I can do about it[[14](#footnote14)<a id="jumpback14"></a>]. I can warn you to be very careful. The `ec2:` namespace covers everything from the network up whilst also being the namespace you're most likely to need, even with unrelated things (want your lambda to talk to your private RDS? You'll have to grant `ec2:CreateNetworkInterface` to its [execution role](https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html#vpc-permissions)). There are some tricks to deal with this: for example [tag based access policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) (although see below for some more on this); using conditions will allow you to limit aspects of an action outside of its target resource (e.g. which VPC am instance is deployed to); using wildcards carefully to allow or deny sets of actions on classes of resource (e.g. deny `ec2:*vpc*` to stop anything on VPCs or their associated stuff, like VPC endpoints).

As I said above, tags can help with e.g. the huge array of actions in ec2. Tag (or in AWS parlance "attribute") based access policies are pretty cool (want only 'admins' to edit that instance? Tag it "admin-only"!) AWS have an entire [tutorial dedicated to setting it up](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html)... I wouldn't. It's a useful tool for limited situations but there're some pretty huge caveats:

* Not every service supports it
* You'll need to make sure you have further policies in place so that tags are maintained (although [AWS Organizations' tag policies do this](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_tag-policies.html))
* Many actions can write tags as a side effect (e.g. `ec2:RunInstances`)
* Actions and Conditions for interacting with tags are not consistent between services (would you like to `CreateTags`, `AddTags` or merely `Tag`?)

Quick one now: `Deny`. This prevents the action, regardless of where amongst the policies it's specified. This is what you want: if you've explicitly denied something there's no way out, that's it: it's denied. The downside is in say, a legacy system, if there's one of these somewhere they can really trip you up. The [policy sim](https://policysim.aws.amazon.com/home/index.jsp?#) can help as, instead of the usual `Implicitly denied` it will tell you that it matches a statement, then you just have to find it.

And now the final one: be careful with permissions in the `iam:` namespace. If you've read this far I'm sure this is obvious but pay extra attention to any permissions you grant here, you can easily create a policy that lets someone attach `AdministratorAccess` to themselves, either directly (the action is `AttachUserPolicy`) or, for example by being able to modify an inline policy on a role used as an instance profile.


{% endblock post_body %}

{% block footnote %}

[1<a id="footnote1"></a>]: when I started this post a month ago it was 8055 [[*back*](#jumpback1)]

[2<a id="footnote2"></a>]: the numbers in this post are based on the output of this particular fork of [aws-iam-reference](https://github.com/dryewo/aws-iam-reference/tree/patch-2). The exact figures don't really matter (they go of date pretty much monthly) [[*back*](#jumpback2)]

[3<a id="footnote3"></a>]: no, I don't know what it does. Apparently its full name is "Application Discovery Arsenal" and it's only action is `RegisterOnPremisesAgent` so, who knows? [[*back*](#jumpback3)]

[4<a id="footnote4"></a>]: `groundstation` is a [real service](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awsgroundstation.html), sadly you have to supply your own hardware. [[*back*](#jumpback4)]

[5<a id="footnote5"></a>]: and some terrible attempts at Venn-diagrams [[*back*](#jumpback5)]

[6<a id="footnote6"></a>]: These sort of follow the ["five Ws"](https://en.wikipedia.org/wiki/Five_Ws), although there are only three here. I use the remaining two with colleagues though: "why" should always be asked and I treat "when" as "when can I take these away from you" (never is a reasonable answer but I want to know that). [[*back*](#jumpback6)]

[7<a id="footnote7"></a>]: EC2 has a LOT of bits that should be separate services [[*back*](#jumpback7)]

[8<a id="footnote8"></a>]: particularly in terms of "should this policy start with `AWS`, `Amazon` or just the service name". That being said the fuzzy matcher on the [policy](https://console.aws.amazon.com/iam/home?#/policies) page isn't too bad so just try the service name. [[*back*](#jumpback8)]

[9<a id="footnote9"></a>]: This is a VERY good case for using something like [terraform](https://terraform.io) to automate deployment and make sure all your resources match up and your json is correct. [[*back*](#jumpback9)]

[10<a id="footnote10"></a>]: Sadly you need to sign in to AWS to use this but it doesn't cost anything [[*back*](#jumpback10)]

[11<a id="footnote11"></a>]: This does mean that it has the annoying property that by the time you've figured out what (and how) to ask it your question you probably know the answer. [[*back*](#jumpback11)]

[12<a id="footnote12"></a>]: This gets extra confusing when the condition is actually part of the request. Specifically the conditions `aws:RequestTag/${TagKey}` (e.g. if you want to set a tag on something) Vs `aws:ResourceTag/` (e.g. does this resource have this tag). I think this may apply elsewhere but I'm not sure. [[*back*](#jumpback12)]

[13<a id="footnote13"></a>]: Not to be confused with `StartInstances` [[*back*](#jumpback13)]

[14<a id="footnote14"></a>]: Except complain on the internet [[*back*](#jumpback14)]

{% endblock footnote %}

{% block post_right %}

### Most useful links ###

* [AWS IAM user guide "policies actions resources context keys"](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_actions-resources-contextkeys.html) all the actions, resources and conditions you need
* [AWS Policy Sim](https://policysim.aws.amazon.com/home/index.jsp?#) play around with policies and check they work
* [aws-iam-reference github repo](https://github.com/dryewo/aws-iam-reference/tree/patch-2) generate your own list of all the actions


### Table of contents ###

* [Intro](#intro)
* [General approach](#general-approach)
* [Horrible things](#horrible-things)

{% endblock post_right %}
