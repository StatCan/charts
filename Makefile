NAME := sylus/charts
VERSION := $(or $(VERSION),$(VERSION),'latest')
PLATFORM := $(shell uname -s)

all: lint

lint:
	./test/lint.sh

.PHONY: \
	all \
	lint
