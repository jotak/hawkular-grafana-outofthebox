# Hawkular and Grafana Out of the Box

This projects contains some docker-compose yaml, grafana dashboards and a bootstrap script
that provides an almost immediate setup of Hawkular+Grafana combo.

## Usage

All you need is docker on your machine and one of the docker-compose.yml files provided in this repo. Edit the docker-compose _bootstrap_ section, by setting the tenant you want to use and the dashboard templates you want to setup in Grafana.

Dashboard templates are located in the `dashboards/` directory, but you don't need to download them (they're included in the docker image).

You can use several of them (just write down the file name without extension), separated by space.

Example:

```yaml
# ...
  bootstrap:
    image: "jotak/hawkular-grafana-bootstrap:latest"
    environment:
      - TENANT=falco
      - DASHBOARDS=vertx-hwk falco
```

Then, just docker-compose it up.

```bash
docker-compose up
```

Then it's up to you to send whatever you want to hawkular (http://localhost:8080/hawkular/metrics), manually or through within an application.

Open Grafana on http://localhost:3000 with credentials _admin_/_admin_. The dashboards mentioned in compose file are already there.

Examples provided here:

- `cpudemo/docker-compose.yml`: contains a demo application that regularly pushes CPU usage to Hawkular.
- `hawkular/docker-compose.yml`: contains a Hawkular self-monitoring dashboard. The same dashboard could actually be used with other WildFly applications that use the Hawkular WildFly agent.
- `falco/docker-compose.yml`: setup a configuration to display _Falco the Hawk_ metrics (game metrics + Vert.X metrics). To try it, you must also get the vert.x app here https://github.com/jotak/falco-demo and run the game once docker-compose is up.

## Creating dashboard templates

1. Build/edit dashboard manually as desired in Grafana
2. Get from API (not import/export), example:
    `curl -u admin:admin http://localhost:3000/api/dashboards/db/VertX`
3. Update the json output to set dashboard id to null (that is the first "id" you should see in json)
4. Replace datasource references to "hawkular-$TENANT"
5. Save in `bootstrap/dashboards/` directory
6. `cd bootstrap`
7. Rebuild docker image `docker build -t jotak/hawkular-grafana-bootstrap .`
8. Eventually submit a pull request if you want to share