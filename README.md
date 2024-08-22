## Band Oracle Workshop

## Foundry Documentation

https://book.getfoundry.sh/

## Setup

### Install Foundry

[Foundry Installation Guide](https://book.getfoundry.sh/getting-started/installation)

### Run Foundryup

```
foundryup
```

### Install dependencies

```
forge install
```

## Resources

### Connecting to the XRPL EVM Sidechain
|Slides|Link|
|---|---|
|Band Oracle Workshop|[Band Oracle Workshop](slides/bandworkshop.pdf)|

|EVM Dev|Resource|
|---|---|
|Faucet & Bridge|https://bridge.devnet.xrpl.org/|
|Explorer|https://explorer.xrplevm.org/|
|RPC|https://rpc-evm-sidechain.xrpl.org/|
|ChainId|1440002|

### Additional Resources
|XRPL Resources|Link|
|---|---|
|XRPL Docs|https://xrpl.org/|
|XRPL Evm Docs|https://xrplevm.org/|
|Grants|https://xrplgrants.org/|
|Accelerator|https://xrplaccelerator.org/|


### Additional Resources
- [Live example of this demo's contract](https://explorer.xrplevm.org/address/0x5deDf28FE20896E63304C643Af8c3A38f561e267?tab=contract)
- [Devnet Oracle Contract](https://explorer.xrplevm.orgg/address/0xdE2022A8aB68AE86B0CD3Ba5EFa10AaB859d0293/read-contract#address-tabs)
- [Band Protocol's Solidity Standard Reference Contracts](https://github.com/bandprotocol/band-std-reference-contracts-solidity)


## Band Oracle Workshop

*This contract is used to fetch the price of a token from the band protocol oracle on xrpl devnet.* 

> Note: the devnet oracle price feed only has support for the following tokens:
> 
> - XRP
> - BTC
> - ETH
>

### Calling the contract via Foundry
* Running this command will grab the price of three tokens from the oracle contract on the devnet, priced in USD.
* It will return the price data as a tuple of three values, encoded in hex. 
* To decode the hex data, use the decode.py script in the tools directory. 
Example contract call:
```
 cast call 0xdE2022A8aB68AE86B0CD3Ba5EFa10AaB859d0293 \
--rpc-url https://rpc-evm-sidechain.xrpl.org \
 "getReferenceDataBulk(string[],string[])" "["BTC","XRP","ETH"]" "["USD","USD","USD"]"
```
Decode script:
```
python3 tools/decode.py [hex data]
```
Example decoded data:
```
python3 tools/decode.py 0x00000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000bdcd1584a20828c607e0000000000000000000000000000000000000000000000000000000066b3964a0000000000000000000000000000000000000000000000000000000066c66fa400000000000000000000000000000000000000000000000006ef9d3de56541d10000000000000000000000000000000000000000000000000000000066b3964a0000000000000000000000000000000000000000000000000000000066c66fa400000000000000000000000000000000000000000000008210431fa95aab338b0000000000000000000000000000000000000000000000000000000066b3964a0000000000000000000000000000000000000000000000000000000066c66fa4
```
Resulting example output (these numbers would need to have their decimal points moved to the left by the consumer application to be human readable):
```
Decoded Prices: [56019399896237565829246, 499790972828598737, 2399248544722519274379]
```

## Deploying the contract

Note: the constructor args is the address of the oracle contract on the devnet, do not change this value.

1. Replace <private-key> with the private key of the account that will be used to deploy the contract. This account must have enough XRP to pay the gas for the deployment. 

2. Change the file path to the location of the contract on your local machine. Also change the contract name to the name of the contract you are deploying. e.g. `BandWorkshop.sol:BandWorkshop`. Do this for **both** the **forge create** and **forge verify-contract commands**.

```
forge create --rpc-url https://rpc-evm-sidechain.xrpl.org \
    --constructor-args 0xdE2022A8aB68AE86B0CD3Ba5EFa10AaB859d0293 \
    --private-key <private-key> \
    src/BandWorkshop.sol:BandWorkshop
```

## Verifying the contract

1. Replace <contract-address> with the "Deployed to" address shown after deployment in your terminal.

```
forge verify-contract  --chain-id 1440002 --verifier=blockscout \
--verifier-url=https://evm-sidechain.xrpl.org/api \
<contract-address>  src/BandWorkshop.sol:BandWorkshop
```
