# GNUHealth deployment using Nix and Docker

This repository defines a Docker image for GNUHealth, packaged with Nix for
ease of customization and reproducible deployment.

Docker images produced here should be easy to deploy to services such as
Heroku, AWS or Fly.io.

# Building the Docker image

Just do...

# About the implementation

GNUHealth is implemented as a series of modules for Tryton. Therefore, the work
here consists on making these modules available in a place where Tryton can
find them. The same Python executable will be used to run Tryton as well as its
modules, so all dependencies must be available to it.

[tryton-modules]: https://docs.tryton.org/projects/server/en/latest/topics/modules/index.html
[gnuhealth-install]: https://en.wikibooks.org/wiki/GNU_Health/Installation
[gnuhealth-modules]: https://en.wikibooks.org/wiki/GNU_Health/Modules
