# Makefile for srcenv

NORMAL=$$(tput sgr0 2> /dev/null || printf '\033[0m')
BOLD=$$(tput bold 2> /dev/null || printf '\033[1m')
GREEN=$$(tput setaf 2 2> /dev/null || printf '\033[32m')

.PHONY: list build bench test bump version

list:
	@echo 'srcenv Makefile'
	@echo
	@echo "make ${BOLD}build     ${NORMAL}Run ShellCheck and generate man page"
	@echo "make ${BOLD}bench     ${NORMAL}Run ShellCheck and benchmark suite"
	@echo "make ${BOLD}test      ${NORMAL}Run ShellCheck and test suite"
	@echo "make ${BOLD}bump      ${NORMAL}Bump srcenv version"
	@echo "make ${BOLD}version   ${NORMAL}Display or change srcenv version"
	@echo "make ${BOLD}list      ${NORMAL}Display this list"

build:
	@shellcheck --color=always srcenv srcenv.benchmarks srcenv.tests srcenv.version && \
	echo "${GREEN}✔${NORMAL} ShellCheck"
	@pandoc --standalone --to man srcenv.1.md -o srcenv.1 && \
	echo "${GREEN}✔${NORMAL} Generate srcenv.1"

bench:
	@shellcheck --color=always srcenv srcenv.benchmarks srcenv.tests srcenv.version && \
	echo "${GREEN}✔${NORMAL} ShellCheck"
	@WARMUP=${w}; \
	./srcenv.benchmarks ${c} $${WARMUP:+--warmup} $${WARMUP:+"$$WARMUP"}

test:
	@shellcheck --color=always srcenv srcenv.benchmarks srcenv.tests srcenv.version && \
	echo "${GREEN}✔${NORMAL} ShellCheck"
	@./srcenv.tests ${t}

bump:
	@./srcenv.version bump "${v}" "${from}"

version:
	@./srcenv.version "${v}" "${from}"
