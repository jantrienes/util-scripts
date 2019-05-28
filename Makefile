lint:
	shellcheck -x $$(grep -rl '^#!/.*sh' ./*)

test:
	bash -c 'cd tests && bats --tap *'
