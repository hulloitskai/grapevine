# grapevine
*A set of personal services that power `stevenxie.me`.*

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg)](https://github.com/prettier/prettier) [![ct: v0.7.0](https://img.shields.io/badge/ct-v0.7.0-green.svg)](https://github.com/coreos/container-linux-config-transpiler/releases/tag/v0.7.0) [![ignition: v2.1.0](https://img.shields.io/badge/ignition-v2.1.0-blue.svg)](https://coreos.com/ignition/docs/latest/configuration-v2_1.html)

### Usage
The `terraform/` directory contains [Terraform](https://www.terraform.io) configuration files relating to the managed infrastructure that Grapevine runs on, like [DigitalOcean](https://www.digitalocean.com) droplets and [Cloudflare](https://www.cloudflare.com) DNS records. The `terraform/ignition/` directory contains the [Ignition](https://coreos.com/ignition/) configuration for Grapevine's [CoreOS](https://coreos.com/os/docs/latest/) servers.

The `services/` directory contains [Docker](https://www.docker.com)-based services that can be `cd`'d into and launched on a Grapevine server.

> Grapevine servers also configured to run `yarn start` at the `services/` level upon startup. It is advised that any 'default' programs that are always running should be associated with `yarn start` in `services/package.json`.
