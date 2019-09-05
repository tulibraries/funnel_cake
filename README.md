Funnel Cake
---------
A blacklight application to work with PA Digital aggregated resources.


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
$ createuser -dW manifold
Password: #now enter your password
```

##### Ubuntu
On ubunutu, we need to run commands as the postgres users
```bash
$ sudo su -c "createuser -dW manifold" postgres
Password: #now enter your password
```
