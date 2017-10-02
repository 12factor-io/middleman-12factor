VERSION?=0.1

docker:
	@echo "==> Building container v${VERSION}..."
	@cd docker && \
	docker build \
		--file "Dockerfile" \
		--tag "12factor/middleman-12factor" \
		--tag "12factor/middleman-12factor:${VERSION}" \
		--pull \
		--rm \
		.

docker-push:
	@echo "==> Pushing to Docker registry..."
	@docker push "12factor/middleman-12factor:latest"
	@docker push "12factor/middleman-12factor:${VERSION}"

gem:
	@echo "==> Building and releasing gem v${VERSION}..."
	@rm -rf pkg/
	@bundle exec rake release

release: gem docker docker-push

.PHONY: docker docker-push gem release
