# ranna Infrastructure

This repository holds all kind of config files, DNS registries and documentation about how the `ranna.dev` instance is set up.

## Service Routing

Below, you find a simplified scheme how requests are routed through the ranna "network".

![](https://i.imgur.com/KVfIhwb.png)

- `public.ranna.dev` is a publicly available endpoint to one ranna instance. `POST` requests to the `/exec` endpoint are rate limited to reduce load and prevent abuse. Also, in front of ranna, there is kyassu, which acts as response cache for re-occuring requests to reduce load when embedding snippets, for example.

- `private.ranna.dev` is an endpoint to another ranna instance with other parameters and no limit restrictions but protected by an IP whitelist middleware and ForwardAuth middleware using gatekeeper to validate authorization headers. This will be used as endpoint for shinpuru code ececution in the future.

- `snippet.ranna.dev` is the endpoint to the snippet api to store and load code snippets from a database. Creating snippets is rate limited to reduce load and prevent abuse.

- `app.ranna.dev` is the web app to access `public.ranna.dev` and `snippets.ranna.dev` via a simple UI. These static files are served by GitHub Pages.

- `app.snippets.ranna.dev` is the web app to access `snippets.ranna.dev` via a simple UI to get API tokens, list and manage linked snippets. These static files are served by GitHub Pages.

The actual deployment infrastructure is actually a bit more sophisticated, as you can see below.

![](https://i.imgur.com/EUowWmz.png)

The two ranna instances are deployed on a seperate, isolated server. If an attacker achives container breakout from a ranna worker, there would be the risk of data leakage. To prevent this, the snippet API and database is deployed to a seperate server. The static files of the web app are served by GitHub Pages.

[Here](https://github.com/ranna-go/infrastructure/blob/master/desec-rrsets.json) you can find a filtered export of the RRSets of the domain registration for ranna.
