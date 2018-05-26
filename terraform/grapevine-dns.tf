# Declare variables
variable "cf_email" { default = "steven.xie@outlook.com" }
variable "cf_token" {}
variable "cf_domain" { default = "stevenxie.me" }
variable "cf_proxied_names" { default = [ "stevenxie.me" ] }
variable "cf_exposed_names" { default = [ "grapevine.stevenxie.me"] }
variable "cf_exposed_ttl" { default = "120" }

# Configure Cloudflare provider
provider "cloudflare" {
  email = "${var.cf_email}"
  token = "${var.cf_token}"
}

# Create records for each record in 'cf_proxied_records'
resource "cloudflare_record" "proxied" {
  count = "${length(var.cf_proxied_names)}"
  domain = "${var.cf_domain}"
  name = "${element(var.cf_proxied_names, count.index)}"
  value = "${digitalocean_floating_ip.grapevine.ip_address}"
  type = "A"
  proxied = true
}

# Create records for each record in 'cf_proxied_records'
resource "cloudflare_record" "exposed" {
  count = "${length(var.cf_exposed_names)}"
  domain = "${var.cf_domain}"
  name = "${element(var.cf_exposed_names, count.index)}"
  value = "${digitalocean_floating_ip.grapevine.ip_address}"
  type = "A"
  ttl = 120
}

