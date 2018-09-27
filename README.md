# grapevine

_Automated infrastructure for https://stevenxie.me and associated services._

It is configured using [Terraform](https://www.terraform.io), and uses
[CoreOS](https://coreos.com) as a platform OS. All services running on
`grapevine` are meant to be run through [Docker](https://docker.com), and
deployed remotely using [Docker Machine](https://docs.docker.com/machine/).

## Prerequisites

The local development machine should have the following tools.

- [Docker](https://www.docker.com) and
  [Docker Machine](https://docs.docker.com/machine/install-machine/) (Docker
  Machine comes preinstalled with _Docker for Mac_ and _Docker for Windows_)
- [Terraform](https://www.terraform.io)
- [`git-secret`](http://git-secret.io): a tool for encrypting and decrypting
  secrets in Git.

In order to gain access to the secrets, the project owner must add your public
GPG key to `git-secret`; afterwards, run `git-secret reveal` to place the
secret files in their proper locations. Make sure you also run `make setup` to
configure your Git hooks to automatically check for updated secrets.

## Generating Infrastructure

> **Note**: Make sure that no infrastructure associated with `grapevine` is
> currently active, before generating infrastructure; otherwise, existing
> systems may be overwritten.

Run `make apply` to automatically generate the infrastructure on DigitalOcean
and Cloudflare.

## Deploying Applications

### Connecting with Docker Machine

1. Run `make mch-create` to create a Docker Machine corresponding to
   `grapevine`. You only have to do this step once.
2. Run `. machine.env.sh` to load the environment variables corresponding
   to this Docker Machine into the current shell. _This step has to be run
   every time you want to access the remote Docker daemon._
3. When you are done with deploying to the remote Docker daemon, switch back
   to the local daemon by running `. unmachine.env.sh`.

### Example Deploy

After sourcing the Docker Machine env variables, deploy a container /
composition of containers / stack / swarm the same way you would on a local
machine. For example, try:

```
docker run -d --name hello-world -p 80:8000 crccheck/hello-world
```

And try visiting http://stevenxie.me to the see the result.
