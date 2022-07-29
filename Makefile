install:
	bundle install
	yarn install

lint:
	bundle exec rubocop

test:
	bundle exec rake test

.PHONY: test