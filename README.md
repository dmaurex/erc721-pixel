
# 👾 ERC721 Pixel NFT

Simple ERC721 **Non-Fungible Tokens (NFTs) called Pixel** built in Solidity. The two NFTs base on the OpenZeppelin smart contract library and use Foundry for automatic deployment and testing. The basic NFT is stored off-chain. The action-based NFT is stored on-chain and can change appearance based on the owners action:

<img src=wallet-screenshot.png width=280 alt=wallet-screenshot>


### Credit 🙏
This project is part of a code-along from the [Foundry Fundamentals](https://updraft.cyfrin.io/courses/foundry) course by [Cyfrin](https://cyfrin.io/). Big thanks for Patrick Collins and his team for offering free web3 education.

---

## ✨ Features

- **Off-chain NFT**: Image is stored in the IPFS network.
- **On-chain NFT**: Image is stored on-chain as an SVG.
- **Dynamic NFT**: Owner can flip the appearance of the NFT.
- **Accessible**: Any user can mint the NFTs for free.
- **Foundry-based Workflow**: Lightning-fast testing, scripting, and deployment.

---

## 📚 Tech Stack

| Tool            | Purpose                                     |
|-----------------|---------------------------------------------|
| Solidity        | Smart contract language                     |
| Foundry         | Compilation, testing, scripting             |
| OpenZeppelin Contracts | Base ERC721 NFT                      |
| MetaMask        | Wallet interaction                          |
| Sepolia Testnet | Live test environment                       |
| Makefile        | Streamlined local commands                  |

---

## 🚀 Getting Started
Follow these steps to clone, install, and test the project locally or on the Ethereum Sepolia testnet.

### 1. Prerequisites 🧰
You need to have Git and Foundry installed. Then clone the repository.

```shell
$ git clone https://github.com/dmaurex/erc721-pixel.git
$ cd erc721-pixel
```

### 2. Environment Setup 🔐
To run tests or deploy on Ethereum Sepolia testnet, create a `.env` file and set the following variables:
```
SEPOLIA_RPC_URL=...
SEPOLIA_KEYSTORE=...
ETHERSCAN_API_KEY=...
```

### 3. Building 🛠️
Install dependencies and build the contracts:

```shell
$ make build
```

### 4. Run Tests 📝
Run tests locally:

```shell
$ make test
# Or run a specific test
$ forge test --mt <specific-test> -vvvvv
```

Run fork tests on Ethereum Sepolia testnet:

```shell
$ make testSepolia
```


## 🌐 Deployment
For **local deployment via anvil**, start the anvil chain and run the deployment script:

```shell
# Basic NFT:
$ make anvil
$ make deployBasicNft
# Action NFT:
$ make anvil
$ make deployActionNft
```

To deploy on the **Ethereum Sepolia testnet**, the following command assumes the path to a keystore is configured with the environment variable `SEPOLIA_KEYSTORE`:

```shell
# Basic NFT:
$ make deployBasicNftSepolia
# Action NFT:
$ make deployActionNftSepolia
```


## 🖼️ Usage
Once the NFT contract is deployed, any account can mint NFTs for free.

### Basic NFT ⛓️‍💥
The basic NFT uses an **off-chain** image source. Specifically, it uses an IPFS URL that has to be configured for the constant `PIXEL` in the script `script/Interactions.s.sol`. Then, run the command to mint the NFT:

```shell
$ make mintBasicNft
```

### Action NFT ⛓️
The action-based NFT uses SVG images that are stored **on-chain** and can change between two appearances. You can configure what images are used for the NFT by specifying the path during deployment of the contract in the `script/DeployActionNft.s.sol` script. Then, run the command to mint the NFT:

```shell
$ make mintActionNft
```

Once the NFT has been minted, it can be added to your wallet, e.g., MetaMask. In the `NFTs` tab, click on `+ Import NFT` and provide the NFT contract address as well as the token ID. When using the local setup, make sure the anvil chain is still up and running.

If you encounter the error message `NFT can’t be added as the ownership details do not match`, try re-logging into your MetaMask account or re-opening your browser.

You can flip the action-based NFT between the states `run` and `stop` using the command:

```shell
$ make flipActionNft
```

To update the appearance of the NFT in the wallet after flipping it, unfortunately, you need to remove and re-import it.


---

## 📂 Project Structure
The repository follows the usual Foundry folder structure:

```bash
.
├── img/ — "Image files for the NFTs"
├── lib/
├── script/
│   ├── DeployActionNft.s.sol — "Deployment script"
│   ├── DeployBasicNft.s.sol — "Deployment script"
│   └── Interactions.s.sol — "Scripts to mint and flip NFTs"
├── src/
│   ├── ActionNft.sol — "On-chain action-based NFT contract"
│   └── BasicNft.sol — "Off-chain basic NFT contract"
├── test/
│   ├── integration/ — "Integration tests"
…   └── unit/ — "Unit tests"
```


## 📜 License
This project is licensed under the **MIT License**. See the [LICENSE](./LICENSE) file for more details.
