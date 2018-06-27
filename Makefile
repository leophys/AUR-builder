go-compile:
	$(shell cd aurbuilder \
	&& go build \
	&& mv aurbuilder ../docker/golang/)

go-build: go-compile
	docker build --build-arg BUILD_TYPE=golang -t aurbuilder-go -f docker/Dockerfile .

shell-build:
	docker build --build-arg BUILD_TYPE=shell -t aurbuilder -f docker/Dockerfile .

compile:
ifeq ($(GO),true)
	make go-build
else
	make shell-build
endif

install: 
ifeq ($(TECH),go)
	make GO=true compile
	$(eval imagename := aurbuilder-go)
else
	make compile
	$(eval imagename := aurbuilder)
endif
	if [[ ! -d bin ]]; then mkdir bin; fi
	if [[ -f bin/aurbuilder ]]; then rm bin/aurbuilder; fi
	@echo '#!/usr/bin/env bash' >> bin/aurbuilder
	@echo '' >> bin/aurbuilder
	@echo 'if [[ ! -d /run/aurbuilder ]]' >> bin/aurbuilder
	@echo 'then' >> bin/aurbuilder
	@echo '    mkdir /tmp/aurbuilder' >> bin/aurbuilder
	@echo 'fi' >> bin/aurbuilder
	@echo 'docker run --rm -ti -v /tmp/aurbuilder:/home/builder/store $(imagename) $$@'>> bin/aurbuilder
	chmod +x bin/aurbuilder	
	@if [[ $$(id -u) -eq 0 ]]; then cp bin/aurbuilder /usr/local/bin/; fi