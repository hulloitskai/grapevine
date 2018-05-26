# DigitalOcean variables...
variable "do_token" {}

# SSH variables...
variable "personal_pubkey_path" {}
variable "terraform_pubkey_path" {}
variable "terraform_pvtkey_path" {}

# Ignition Config
variable "ignition_root_path" {}


# Configure DigitalOcean
provider "digitalocean" { token = "${var.do_token}" }


# Configure new 'terraform' public key for DigitalOcean
resource "digitalocean_ssh_key" "terraform" {
  name = "terraform-pubkey"
  public_key = "${file(var.terraform_pubkey_path)}"
}


# Configure existing public key for DigitalOcean
data "external" "personal_pubkey_fingerprint" {
  program = [
    "node",
    "scripts/fingerprintify.js",
    "${var.personal_pubkey_path}"]
}

# Configure Ignition config generator
data "external" "ignition_config" {
  program = [
    "node",
    "scripts/ignition-generator.js",
    "${var.ignition_root_path}"
  ]
}

#        (type)                 (name)
resource "digitalocean_droplet" "grapevine" {
  # Required configuration settings
  name = "grapevine"
  image = "coreos-beta"
  size = "s-1vcpu-1gb"
  region = "nyc1"

  # Optional configuration settings
  ssh_keys = [
    "${data.external.personal_pubkey_fingerprint.result.data}",
    "${digitalocean_ssh_key.terraform.fingerprint}"
  ]
  tags = [ "main" ]
  private_networking = true
  user_data = "${data.external.ignition_config.result.data}"

  # SSH connection
  connection {
    user = "dev"
    type = "ssh"
    private_key = "${file(var.terraform_pvtkey_path)}"
    timeout = "2m"
  }
}


# Floating IP for DigitalOcean
# Note: DigitalOcean's existing floating IPs cannot be reused (yet)...
#   Check https://github.com/terraform-providers/terraform-provider-digitalocean/issues/8
#   for progress. Because of this, we provision a new DNS record on Cloudflare for each
#   new DigitalOcean instance.
resource "digitalocean_floating_ip" "grapevine" {
  droplet_id = "${digitalocean_droplet.grapevine.id}"
  region = "${digitalocean_droplet.grapevine.region}"
}

output "grapevine_ip" {
  value = "${digitalocean_floating_ip.grapevine.ip_address}"
}
