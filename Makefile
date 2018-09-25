## Terraform commands:
.PHONY: init apply plan plan-destroy exec destroy fmt

TF = terraform
plan_out = terraform.tfplan

apply:
	@$(TF) apply
plan:
	@$(TF) plan -out=$(plan_out)
plan-destroy:
	@$(TF) plan -destroy -out=$(plan_out)
exec:
	@$(TF) apply "terraform.tfplan"
destroy:
	@$(TF) destroy
fmt:
	@$(TF) fmt


## Docker Machine commands:
.PHONY: mch-create

DKMCH = docker-machine

## mch-create creates a generic docker machine on the remote host.
## Variables: IPADDR, SSHKEY
SSHKEY = "./auth/id_ed25519.terraform"
IPADDR = "grapevine.stevenxie.me"
mch-create:
	@$(DKMCH) create --driver generic \
					 --generic-ip-address="$(IPADDR)" \
					 --generic-ssh-key="$(SSHKEY)" \
					 --generic-ssh-user=admin \
					 grapevine

mch-rm:
	@$(DKMCH) rm grapevine

mch-env:
	@tmp=$$(mktemp) && $(DKMCH) env grapevine > $$tmp && . $$tmp && rm $$tmp
