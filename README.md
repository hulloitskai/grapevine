# Grapevine

_A personal server that powers https://stevenxie.me and associated services._

It is configured using [Terraform](https://www.terraform.io), and uses
[CoreOS](https://coreos.com) as a platform OS. All services running on Grapevine
are meant to be run through [Docker](https://docker.com), and deployed remotely
using [Docker Machine](https://docs.docker.com/machine/).

## Configuration

1. Create an `auth/`directory with the following pieces of data:

   - `admin.passhash`: a SHA-512 password hash generated using
     [`hash512`](https://github.com/steven-xie/hash512). The corresponding
     password will be the password for the primary user, `admin`.
   - `id_ed25519.pub`: a public key for personal access to the server. Should
     be generated along with a corresponding private key using:
     `ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "comment"`.
     See [this article](https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54)
     for a better explanation of the behind-the-scenes of this command.
   - `id_ed25519.terraform`, `id_ed25519.terraform.pub`: the public-private
     key pair that Terraform will use to access the server to perform remote
     provisioning. Generated the same way as `id_ed25519.pub`.

2. Create a `terraform.tfvars` of the following shape:

   ```hcl
   // Cloudflare
   cf_email = "..."
   cf_token = "..."

   // DigitalOcean
   do_token = "..."
   ```

3. Run `make apply` to automatically generate the infrastructure on DigitalOcean
   and Cloudflare.

## Deploying Docker Containers

### Configuration

1. Run `make mch-create` to create a Docker Machine corresponding to
   `grapevine`. You only have to do this step once.
2. Run `. machine.env.sh` to load the environment variables corresponding
   to this Docker Machine into the current shell. _This step has to be run
   every time you want to access the remote Docker daemon._
3. When you are done with deploying to the remote Docker daemon, switch back
   to the local daemon by running `. unmachine.env.sh`.

### Deploying

After sourcing the Docker Machine env variables, deploy a container /
composition of containers / stack / swarm the same way you would on a local
machine. For example, try:

```
docker run -d --name hello-world -p 80:8000 crccheck/hello-world
```

And try visiting http://stevenxie.me to the see the result.
