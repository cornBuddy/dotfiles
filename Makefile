.PHONY: pre-commit
pre-commit:
	pre-commit install
	pre-commit run --verbose --all-files --show-diff-on-failure
