# ranna Infrastructure

This repository holds all kind of config files, DNS registries and documentation about how the `ranna.zekro.de` instance is set up.

## Service Routing

Below, you find a simplified scheme how requests are routed through the ranna "network".

![](https://i.imgur.com/8fpW8Du.png)

- `public.ranna.zekro.de` is a publicly available endpoint to one ranna instance. `POST` requests to the `/exec` endpoint are rate limited to reduce load and prevent abuse.

- `private.ranna.zekro.de` is an endpoint to another ranna instance with other parameters and no limit restrictions but protected by an IP whitelist middleware and ForwardAuth middleware using gatekeeper to validate authorization headers. This will be used as endpoint for shinpuru code ececution in the future.

- `snippet.ranna.zekro.de` is the endpoint to the snippet api to store and load code snippets from a database. Creating snippets is rate limited to reduce load and prevent abuse.

- `app.ranna.zekro.de` is the web app to access `public.ranna.zekro.de` and `snippets.ranna.zekro.de` via a simple UI. These static files are served by GitHub Pages.

The actual deployment infrastructure is actually a bit more sophisticated, as you can see below.

![](https://i.imgur.com/SZq7PJ1.png)

The two ranna instances are deployed on a seperate, isolated server. If an attacker achives container breakout from a ranna worker, there would be the risk of data leakage. To prevent this, the snippet API and database is deployed to a seperate server. The static files of the web app are served by GitHub Pages.

[Here](https://github.com/ranna-go/infrastructure/blob/master/desec-rrsets.json) you can find a filtered export of the RRSets of the domain registration for ranna.