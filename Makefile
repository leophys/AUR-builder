go-compile:
	$(shell if [[ ! -d docker/golang ]]; then \
				mkdir -p docker/golang; \
			fi)
	$(shell cd aurbuilder \
	&& go build \
	&& mv aurbuilder ../docker/golang/)

go-build: go-compile
	docker build --build-arg BUILD_TYPE=golang -t aurbuilder-go -f docker/Dockerfile .

shell-build:
	docker build --build-arg BUILD_TYPE=shell -t aurbuilder -f docker/Dockerfile .

compile-image:
ifeq ($(GO),true)
	make go-build
else
	make shell-build
endif

compile: 
ifeq ($(TECH),go)
	make GO=true compile-image
	$(eval imagename := aurbuilder-go)
else
	make compile-image
	$(eval imagename := aurbuilder)
endif
	if [[ ! -d bin ]]; then mkdir bin; fi
	if [[ -f bin/aurbuilder ]]; then rm bin/aurbuilder; fi
	@echo '#!/usr/bin/env bash' >> bin/aurbuilder
	@echo '' >> bin/aurbuilder
	@echo 'if [[ ! -d ~/.cache/aurbuilder ]]' >> bin/aurbuilder
	@echo 'then' >> bin/aurbuilder
	@echo '    mkdir -p ~/.cache/aurbuilder && chmod 777 ~/.cache/aurbuilder' >> bin/aurbuilder
	@echo 'fi' >> bin/aurbuilder
	@echo 'docker run -ti -v ~/.cache/aurbuilder:/home/builder/store $(imagename) $$@'>> bin/aurbuilder
	chmod +x bin/aurbuilder	

install:
	cp bin/aurbuilder /usr/local/bin/
