-include .env

.PHONY: all clean remove install update build format anvil test testSepolia deployBasicNft deployBasicNftSepolia mintBasicNft mintBasicNftSepolia deployActionNft deployActionNftSepolia mintActionNft mintActionNftSepolia flipActionNft flipActionNftSepolia

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

all: clean remove install update build

# Clean the repo
clean :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add .

install :; forge install foundry-rs/forge-std@v1.9.7 && forge install openzeppelin/openzeppelin-contracts@v5.3.0

# Update Dependencies
update:; forge update

build:; forge build

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

test :; forge test

testSepolia :; forge test --rpc-url $(SEPOLIA_RPC_URL)

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast
SEPOLIA_NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --keystore $(SEPOLIA_KEYSTORE) --broadcast

deployBasicNft:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(NETWORK_ARGS)

deployBasicNftSepolia:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(SEPOLIA_NETWORK_ARGS) --etherscan-api-key $(ETHERSCAN_API_KEY)  --verify

mintBasicNft:
	@forge script script/Interactions.s.sol:MintBasicNft $(NETWORK_ARGS)

mintBasicNftSepolia:
	@forge script script/Interactions.s.sol:MintBasicNft $(SEPOLIA_NETWORK_ARGS)

deployActionNft:
	@forge script script/DeployActionNft.s.sol:DeployActionNft $(NETWORK_ARGS)

deployActionNftSepolia:
	@forge script script/DeployActionNft.s.sol:DeployActionNft $(SEPOLIA_NETWORK_ARGS) --etherscan-api-key $(ETHERSCAN_API_KEY)  --verify

mintActionNft:
	@forge script script/Interactions.s.sol:MintActionNft $(NETWORK_ARGS)

mintActionNftSepolia:
	@forge script script/Interactions.s.sol:MintActionNft $(SEPOLIA_NETWORK_ARGS)

# cast send <contract_address> "mintNft()" --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY)
# cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "mintNft()" --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

flipActionNft:
	@forge script script/Interactions.s.sol:FlipActionNft $(NETWORK_ARGS)

flipActionNftSepolia:
	@forge script script/Interactions.s.sol:FlipActionNft $(SEPOLIA_NETWORK_ARGS)