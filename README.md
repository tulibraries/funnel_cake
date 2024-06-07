Funnel Cake
---------
[Funnel Cake](https://funnelcake.padigital.org/) is an internal site to search and view PA Digital aggregated metadata for quality assessment. It is built with [Blacklight](https://projectblacklight.org/). Funnel Cake also serves as the development and production endpoint for PA Digital's OAI-PMH feed.

For more information, see [About the PA Digital Aggregator](https://padigital.org/about-aggregator/).

## System requirements

- Ruby 3.3.0

Getting set up for local development
---------

TODO

### Setting up Postgres on your local machine

You'll need a running Postgres >= 9.5 on your local dev machine.

#### Installing on OSX

Install with homebrew

```bash
brew install postgres
```

Next, set up postgres to run as a service

```bash
brew services start postgres
```

#### Installing on Ubuntu

Install with postgres and development library via apt
```bash
sudo apt-get install postgresql-server libpq-dev
```

`apt-get` should set up postgres as a service.



#### Create a postgres user
Finally, we need to create a postgres role with enough privileges to create and destroy databases. We'll use the built in `createuser` command with the `-d` flag that allows the user to create and destroy databases, and the `-W` flag that will cause the command to prompt your for a password, which is just `password`.

##### OSX

```bash
$ createuser -dW funnelcake
Password: #now enter your password
```

##### Ubuntu
On ubunutu, we need to run commands as the postgres users
```bash
$ sudo su -c "createuser -dW funnelcake" postgres
Password: #now enter your password
```

### Set up development environment

#### Point the envirnoment to the desired Solr server

```
$ export SOLR_IP="<USERNAME>:<PASSWORD>@<SOLR_CLOUD_URL>
$ cp .env-dev .env
```

#### Install gem dependencies

```
$ bundle install
```

#### Migrate databases

```
$ rails db:migrate
```

#### Start the Funnelcake Application Server

```
$ bundle exec rails server
```

#### To start up a local instance of solr cloud


```
$ cd ..
$ git clone https://github.com/tulibraries/ansible-playbook-solrcloud.git
$ cd ansible-playbook-solrcloud
$ make up-lite
```

Set the SOLR_IP address before starting the Funnelcake server

```
export SOLR_IP="127.0.0.1:8090"
```

NOTE: The Funnelcake Solr repository should be seeded for the application to function properly
