---
layout: post
title: "Would You Like a Library with That (API)?"
categories: blog
excerpt: "SDKs work until they don't"
tags: [api]
author: hlgr360
share: true
---

Over the last couple of months I have had the great opportunity to road test my findings on SDKs vs APIs with a wide variety of audiences at our API Summits in New York and London, on-tour with the Nordic API team in Stockholm and Copenhagen as well as my most recent API Workshop in Istanbul. Given the apparent relevance of the topic and lively discussions, I would like to summarize some of the insights and recommendation here as well.

If you have been following our blog you will remember that I started this topic with the observation that using APIs increasingly seem to imply using SDKs rather than the API itself [link here]. I followed up with a blog talking about my decidedly mixed experiences of trying to use SDKs [link here]. My own experiences inspired the tagline of this blog trying to bring it all together: **SDKs work until they don't**.

So lets get right to it - what are the main motivators from an API provider perspective to invest into a SDK:

* Time to first use
* Best client for your API
* Simplified API design
* Strongly typed presentation

SDKs can help API Developers to quickly get a working example of the API. The SDK might also present an optimized client from a target platform perspective (i.e. for mobile connectivity or constrained hardware). It might allow you to simplify your API design by extracting business logic into the client and/or provide better scalability by exploiting client-side processing. Last but not least there might be an expectation or preference by your intended target developer community to have a strongly typed presentation of the API in their programming language of choice.

Let's contrast that with the main drawbacks of SDK's:

* Picking platform, language and framework winners
* 3rd Party framework dependencies
* SDK carry-on weight
* Long-term support costs

Developing an SDK means to make a choice among platforms, languages and frameworks. Picking those "winners" is bound to disappoint at least some of your target API developers. Further more - since most SDKs will rely on some common 3rd party frameworks - an API developer having to integrate with two or more API's leveraging the same common framework but at different version levels is bound to experience quite some headache. Even if it is not initially the case different release cycles of those APIs might introduce diverging yet incompatible versions of the same framework down the road. Some of the SDK's add quite some carry-on weight of unused functionality to the application. And once a SDK is released there are long-term support costs.

But to me the biggest risk of a SDK First approach lies in **making API design an afterthought**. We have come to this point in the API evolution because Pragmatic REST introduces **just enough** constrains to force us to think about how we can abstract the underlying business asset into a resource-based model restricted to CRUD-style interactions. A SDK First approach might tempt us to go back to a RPC-style API design mirrowing the backend implementation resulting in all the inherent integration complexities like we have had with Web Services.

So if and when you decide  on a SDK, keep the above in mind. You might still come to the conclusion that you need a SDK yo quickly on-board developers or provide the best client for your API, but at least you can conciously weight the benefits against the drawbacks.

If you want to dig more deeply into the subject I can highly recommend the following podcasts and blogs which helped me greatly to inform my opinon:

* [Traffic and Weathers Podcast Episode 18](http://trafficandweather.io/posts/2013/10/20/episode-18-this-will-be-way-easier)
* [Traffic and Weathers Podcast Episode 20](http://trafficandweather.io/posts/2013/12/27/episode-20-im-going-to-punch-a-wall)
* [Why I Don't Want Your SDK in Production](http://brandur.org/sdk)
* [Why No One Wants To Use Your API](http://apiux.com/2013/10/18/why-no-one-wants-to-use-your-api/)
* [Why SDKs Are Better Than APIs](http://blog.programmableweb.com/2013/10/04/when-sdks-are-better-than-apis/)
* [Panel Urges API Providers To Prioritize Their Developer Experiences](http://blog.programmableweb.com/2014/03/05/panel-urges-api-providers-to-prioritize-their-developer-experiences/)
* [Will Internet of Things And The SDK Push Out REST?](http://apievangelist.com/2014/01/07/will-internet-of-things-and-the-sdk-push-out-rest/)
