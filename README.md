# Nuzzelish

![](./preview.png)

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  * Start IEX with the app contents ready with `iex -S mix phx.server`
  * Set env vars for `TW_ACCOUNT` and `TW_LIST`, as well as Twitter app creds:
    - `TW_CONSUMER_KEY`
    - `TW_CONSUMER_SECRET`
    - `TW_ACCESS_TOKEN`
    - `TW_ACCESS_TOKEN_SECRET`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Developing

- Get the Postgres database going: `$ mix ecto.create && mix ecto.migrate`
- Connect to the dev Postgres instance with `\connect nuzzelish_dev` after
  running `$ psql -U postgres`

## Deploying

### Build Locally

Just to confirm things look good

- `$ mix phx.digest`
- `$ export SECRET_KEY_BASE="$(mix phx.gen.secret)"`
- `$ export DATABASE_URL="user:pass//postgres:@localhost:5432/nuzzelish_dev"`
- `$ MIX_ENV=prod mix release`
- `$ MIX_ENV=prod APP_NAME=nuzzelish PORT=4000 _build/prod/rel/nuzzelish/bin/nuzzelish start`
- `$ curl localhost:4000`

### Send to Gigalixir

TBD

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
