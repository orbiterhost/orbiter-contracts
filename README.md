## Orbiter Contracts

![cover](https://orbiter.host/og.png)

The official repo for Orbiter's smart contracts. This repo contains the following:
- **OrbiterSite** - Custom implementation of [IPCM](https://ipcm.dev)
- **OrbiterFactory** - Contract factory that enables easy deployment of OrbiterSite contracts

Both of these contracts are currently only deployed on [Base](https://base.org) at the following addresses
| Contract       | Address                                    |
|----------------|--------------------------------------------|
| OrbiterSite    | [0x404DA1447568eFe19a02638c6354608d83FbCb43](https://basescan.org/address/0x404DA1447568eFe19a02638c6354608d83FbCb43) |
| OrbiterFactory | [0x486Edc2E94926fd50398e2129089648b8B9E3D3A](https://basescan.org/address/0x486edc2e94926fd50398e2129089648b8b9e3d3a) |

## Development

To run these contracts locally first install [Foundry](https://book.getfoundry.sh/getting-started/installation).

Clone the repo and install the dependencies

```bash
git clone https://github.com/orbiterhost/orbiter-contracts
cd orbiter-contracts
forge install
```

Compile and run tests

```bash
forge compile
forge test
```

## Deployment

Deployement is very simple as it does not have any constructor arguments and just needs the factory to be deployed; the implementation address will be deployed simutaneously

```bash
forge create src/OrbiterFactory.sol:OrbiterFactory \
  --rpc-url <RPC_URL> \
  --account <YOUR_ACCOUNT> \
  --broadcast
```

## Contact

If you have questions feel free to reach out!

[steve@orbiter.host](mailto:steve@orbiter.host)
