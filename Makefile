# Makefile for srcenv

NORMAL=$$(tput sgr0 2> /dev/null || printf "\e[00m")
BOLD=$$(tput bold 2> /dev/null || printf "\e[1m")
GREEN=$$(tput setaf 2 2> /dev/null || printf "\e[32m")

.PHONY: list build test bump version

list:
	@echo "srcenv Makefile"
	@echo ""
	@echo "make ${BOLD}build     ${NORMAL}Run ShellCheck and generate man page"
	@echo "make ${BOLD}test      ${NORMAL}Run ShellCheck and test suite"
	@echo "make ${BOLD}version   ${NORMAL}Display or change srcenv version"
	@echo "make ${BOLD}list      ${NORMAL}Display this list"

build:
	@shellcheck --color=always srcenv srcenv.tests srcenv.version
	@pandoc --standalone --to man srcenv.1.md -o srcenv.1 && \
	echo "${GREEN}✔${NORMAL} Generate srcenv.1"

test:
	@shellcheck --color=always srcenv srcenv.tests srcenv.version
	@./srcenv.tests

bump:
	@./srcenv.version bump "${v}" "${from}"

version:
	@./srcenv.version "${v}" "${from}"
