ifeq (, $(shell which docker))
    $(error "Docker is not installed!")
endif

.SHELLFLAGS = -ec
.DEFAULT_GOAL := help

VERSION_LOCK ?= Minor

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  upgrade-packages:  Upgrade all NuGet packages in the solution"
	@echo "                       Version lock options:"
	@echo "                         Major: Upgrade to the latest major version"
	@echo "                         Minor: Upgrade to the latest minor version (default)"
	@echo "                         Patch: Upgrade to the latest patch version"
	@echo "                       Example: make upgrade-packages VERSION_LOCK=Major"
	@echo "  help:              Show this help message"

.PHONY: upgrade-packages
upgrade-packages:
	@docker run -i --rm -v $(PWD):/app -w /app \
		-e DOTNET_SYSTEM_CONSOLE_ALLOW_ANSI_COLOR_REDIRECTION=true \
		-e TERM=xterm-256color \
		mcr.microsoft.com/dotnet/sdk:9.0 bash -c "\
		dotnet tool install --global dotnet-outdated-tool && \
		export PATH=\$$PATH:\$$HOME/.dotnet/tools && \
		dotnet outdated --upgrade --version-lock $(VERSION_LOCK)"