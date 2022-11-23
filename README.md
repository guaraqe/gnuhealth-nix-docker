# GNUHealth deployment using Nix and Docker

This repository defines a Docker image for GNUHealth, packaged with Nix for
ease of customization and reproducible deployment.

Docker images produced here should be easy to deploy to cloud services. The
code here uses Fly.io, but it should be simple to adapt to other platforms.

# Configuring modules

Modules can be defined in the `release.nix` file. The appropriate versions of
modules can be found [here](https://downloads.tryton.org/6.4/).

# Setting up Fly.io

Make sure to create an account with access to the free tier.

The following commands should be executed inside the Nix shell, by running
`nix-shell` before starting.

First, to login, run:

```shell
$ flyctl auth login
```

Then, the Postgres database must be created:

```shell
$ flyctl postgres create
```

This command will show the credentials, which should be saved in a `secrets.json` file as:

```json
{
  "pgstring": "postgresql://user:password@host:port"
}
```

Finally, create your app:

```shell
$ flyctl launch
```

In this step you will choose the app name, which will determine its URL. This name should be used for the `tag-and-push-image`

In the following, the app name will be called `$APP_NAME`.

Make dure the image is in the `fly.toml` configuration file:

```toml
[build]
  image = "registry.fly.io/$APP_NAME:latest"
```

# Building and deploying

Once more, all commands should be run inside the Nix shell, by running
`nix-shell` before starting.

First, build the docker image and load it:

```shell
$ just build-and-load-image
```

Tag the image conveniently, and push it:

```shell
$ just tag-and-push-image $APP_NAME
```

And finally, deploy:

```shell
$ just deploy $APP_NAME
```

# About the implementation

GNUHealth is implemented as a series of modules for Tryton. Therefore, the work
here consisted on making these modules available in a place where Tryton can
find them. The same Python executable will be used to run Tryton as well as its
modules, so all dependencies must be available to it.

[tryton-modules]: https://docs.tryton.org/projects/server/en/latest/topics/modules/index.html
[gnuhealth-install]: https://en.wikibooks.org/wiki/GNU_Health/Installation
[gnuhealth-modules]: https://en.wikibooks.org/wiki/GNU_Health/Modules
