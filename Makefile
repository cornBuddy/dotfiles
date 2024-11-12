.PHONY: workstation
workstation: galaxy
	ansible-playbook -vv --diff workstation.yml

.PHONY: galaxy
galaxy:
	ansible-galaxy role install -r requirements.yml

.PHONY: pre-commit
pre-commit:
	pre-commit install
	pre-commit run --verbose --all-files --show-diff-on-failure
