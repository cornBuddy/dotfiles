.PHONY: workstation
workstation:
	ansible-playbook -vv --diff workstation.yml

.PHONY: pre-commit
pre-commit:
	pre-commit install
	pre-commit run --verbose --all-files --show-diff-on-failure
