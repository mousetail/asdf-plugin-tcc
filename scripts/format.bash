#!/usr/bin/env bash

shfmt --language-dialect bash --write \
	./lib/*.bash \
	./bin/*
