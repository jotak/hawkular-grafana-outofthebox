# Hawkular and Grafana Out of the Box

This projects contains some docker-compose yaml, grafana dashboards and a bootstrap script
that provides an almost immediate setup of Hawkular+Grafana combo.

## Usage

Edit the docker-compose file 'bootstrap' section, by setting the tenant you want to use and the dashboard templates you want to setup in Grafana.
Dashboard templates are located in the `dashboards` directory. You can put several of them, separated by space.

Example:

```yaml
# ...
  bootstrap:
    image: "jotak/hawkular-grafana-bootstrap:latest"
    environment:
      - TENANT=falco
      - DASHBOARDS=vertx-hwk.json falco.json
```

Then, just docker-compose it up.

```bash
docker-compose up
```

Then it's up to you to send whatever you want to hawkular (http://localhost:8080/hawkular/metrics), manually or through within an application.
The "falco" example that you can find here (check `falco/docker-compose.yml`), for instance, can be used with this demo application: https://github.com/jotak/falco-demo

## Creating dashboard templates

1. Build/edit dashboard manually as desired in Grafana
2. Get from API (not import/export), example:
    `curl -u admin:admin http://localhost:3000/api/dashboards/db/VertX`
3. Update the json output to set dashboard id to null (that is the first "id" you should see in json)
4. Replace datasource references to "hawkular-$TENANT"
5. Save in `bootstrap/dashboards/` directory
6. `cd bootstrap`
7. Rebuild docker image `docker build -t jotak/hawkular-grafana-outofthebox .`
