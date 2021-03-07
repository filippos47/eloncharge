build:
	$(MAKE) -C cli-client build
	$(MAKE) -C back-end build
	$(MAKE) -C front-end build

install:
	$(MAKE) -C cli-client install
	$(MAKE) -C back-end install
	$(MAKE) -C front-end install

test:
	$(MAKE) -C cli-client test
	$(MAKE) -C back-end test
