SHELL := /bin/bash
RM=rm

ContrPath=$(shell find src -name '*.sol')
ContrDirs=$(dir $(shell find src -name '*.sol'))
ContrFiles=$(notdir $(shell find src -name '*.sol'))
ContrDirsAndFiles=$(foreach v, $(ContrPath), $(dir $v) $(notdir $v))


# NULL=$(shell source .env)
include .env


.PHONY: build test

all: build

install:
	forge install

update:
	forge update

fmt:
	forge fmt

lint:
	solhint -c .solhint.json src/*.sol script/*.sol test/*.sol

chain:
	# source .env
	anvil --host 127.0.0.1 -p 8545 --chain-id 1234 -b 5 -a 10 --balance 10000000000000

types:
	typechain --target ethers-v6 --out-dir build/types 'build/abis/**/*.json'

compile:
	forge build
	# mkdir -p build/abis
	# forge inspect -C src Counter abi > build/abis/Counter.abi

build: compile types

clean:
	forge clean
	$(RM) -rf build

test:
	# source .env
	forge test --gas-report -vv
	# forge snapshot --gas-report --snap gas_usage1.txt
	# forge snapshot --gas-report --diff gas_usage1.txt

dep:
	# source .env
	forge create src/Counter.sol:Counter --constructor-args "10" --private-key $(PRIVATE_KEY)

task1:
	# source .env
	forge script script/Counter.s.sol:CounterScript --private-key $(PRIVATE_KEY) -v --broadcast
	forge script script/Counter.s.sol -s "run(uint256 v1)" --private-key $(PRIVATE_KEY) -v --broadcast 20
