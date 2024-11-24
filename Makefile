# Makefile for srcenv

.PHONY: build
build:
	@pandoc --standalone --to man srcenv.1.md -o srcenv.1 && \
    printf "\e[32m✔ Generate srcenv.1\e[00m\n"

.PHONY: test
test:
	@./srcenv.tests
