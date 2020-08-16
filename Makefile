SHELL=/bin/bash

.PHONY: build test clean

prep:
		rvm use 2.5.7@dotfiles --create
		bundle install

build: prep
		rake build

test: prep
		rake test

acceptance: prep
		BEAKER_IS_PE=no BEAKER_PUPPET_COLLECTION=puppet5 PUPPET_INSTALL_TYPE=agent BEAKER_debug=true rake acceptance

smoke: prep
	  rake spec_prep
	  vagrant up

clean:
	  rake spec_clean
	  rvm gemset empty 2.5.7@dotfiles
		rm -rf pkg/
