
## Deployment

Two deployment methods are supported:
1. If you have a Kubernetes cluster, we recommend using [our Helm Chart](https://github.com/infracost/helm-charts/tree/master/charts/cloud-pricing-api).
2. If you prefer to deploy in a VM, we recommend using [Docker compose](#docker-compose).

The Cloud Pricing API includes an unauthenticated `/health` path that is used by the Helm chart and Docker compose deployments.

The PostgreSQL DB is run on a single container/pod by default, which should be fine if your high-availability requirements allow for a few second downtime on container/pod restarts. No critical data is stored in the DB and the DB can be quickly recreated in the unlikely event of data corruption issues. Managed databases, such as a small AWS RDS or Azure Database for PostgreSQL, can also be used (PostgreSQL version >= 13). Since the pricing data can be quickly populated by running the update job, you can probably start without a backup strategy.

### Helm chart

See [our Helm Chart](https://github.com/infracost/helm-charts/tree/master/charts/cloud-pricing-api) for details.

### Docker compose

1. Use the Infracost CLI to get an API key so your self-hosted Cloud Pricing API can download the latest pricing data from us:
   ```
   infracost auth login
   ```
   The key is saved in `~/.config/infracost/credentials.yml`.

2. Generate a 32 character API token that your Infracost CLI users will use to authenticate when calling your self-hosted Cloud Pricing API. If you ever need to rotate the API key, you can simply update this environment variable and restart the application.
   ```
   export SELF_HOSTED_INFRACOST_API_KEY=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
   echo "SELF_HOSTED_INFRACOST_API_KEY=$SELF_HOSTED_INFRACOST_API_KEY"
   ```

3. Add a `.env` file with the following content:
   ```
   # The Infracost API from Step 2, used to download pricing data from us.
   INFRACOST_API_KEY=<API Key from Step 1>

   # The API key you generated in step 2, used to authenticate Infracost CLI users with your self-hosted Cloud Pricing API.
   SELF_HOSTED_INFRACOST_API_KEY=<API Key from Step 2>
   ```

4. Run `docker-compose run init_job`. This will start a PostgreSQL DB container and an init container that loads the pricing data. The init container will take a few minutes and exit after the Docker compose logs show Completed: loading data into DB.

5. Run `docker-compose up api -d`. This will start the Cloud Pricing API.

6. Prices can be kept up-to-date by running the update job once a week, for example from cron:
   ```
   # Add a weekly cron job to update the pricing data. The cron entry should look something like:
   0 4 * * SUN docker-compose run --rm update_job npm run job:update >> /var/log/cron.log 2>&1
   ```

7. When using the CLI locally, run the following two required commands to point your CLI to your self-hosted Cloud Pricing API:
   ```
   infracost configure set pricing_api_endpoint http://localhost:4000
   infracost configure set api_key $SELF_HOSTED_INFRACOST_API_KEY

   infracost breakdown --path /path/to/code
   ```

8. In CI/CD systems, set the following two required environment variables:
   ```
   export INFRACOST_PRICING_API_ENDPOINT=https://endpoint
   export INFRACOST_API_KEY=$SELF_HOSTED_INFRACOST_API_KEY
   ```

9. The home page for the Cloud Pricing API, http://localhost:4000, shows if prices are up-to-date and some statistics.

![Stats page](https://github.com/infracost/cloud-pricing-api/raw/master/.github/assets/stats_page.png "Stats page")

We recommend you setup a subdomain (and TLS certificate) to expose your self-hosted Cloud Pricing API to your Infracost CLI users.

You can also access the GraphQL Playground at [http://localhost:4000/graphql](http://localhost:4000/graphql) using something like the [modheader](https://bewisse.com/modheader/) browser extension so you can set the custom HTTP header `X-Api-Key` to your `SELF_HOSTED_INFRACOST_API_KEY`.

To upgrade to the latest version, run `docker-compose pull` followed by `docker-compose up`.

The environment variable `DISABLE_TELEMETRY` can be set to `true` to opt-out of telemetry.

### Using a self-signed certificate

See [the Infracost docs](https://www.infracost.io/docs/cloud_pricing_api/self_hosted/#using-a-self-signed-certificate) for how to configure Infracost CLI to work with a self-hosted Cloud Pricing API that uses a self-signed certificate.

## Troubleshooting

Please see [this section](https://www.infracost.io/docs/cloud_pricing_api/self_hosted/#troubleshooting).
