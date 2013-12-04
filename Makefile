REBAR=$(PWD)/rebar

.PHONY: all test

all: deps compile

deps:
	${REBAR} get-deps

compile:
	${REBAR} compile

quick:
	${REBAR} skip_deps=true compile

clean:
	${REBAR} clean

test:
	${REBAR} skip_deps=true eunit

go: start

start:
	erl -pa ebin -pa deps/*/ebin -s reloader
