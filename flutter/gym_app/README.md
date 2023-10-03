# Gym App

Here the details about the repository.


## Code about blockchain
To set-up this project I used the [truffle suite](https://trufflesuite.com).

Unforutnately, I encountered quite a lot of problems on the road for compiling and deploying the Smart Contracts. \
Therefore, I reported down here the procedure that I found on my own to make the things work, it could be that if you follow the official guide it will work properly but, in my case, maybe for some dependency conflic in my environment, it's been complex.

### Installation procedure
- [installation of truffle](https://trufflesuite.com/docs/truffle/how-to/install/); I am using MacOS and the problem of this installation got me stuck for a while.
  
  I wasn't able to install the truffle package immediately, because it would have required the run `sudo` command, which is ***not recommended*** by the guide that I just liked above here. \
  As a solution, I had to install locally the package, using `npm install truffle` (without the `-g` flag) and, in order to use the truffle command from the command line, I used `./node_modules/.bin/truffle <command>` instead of just `truffle <command>`.

  After installing **truffle** it's possible to run `truffle init`, the three folders will be created:
  - `contracts/`: Contains smart contract code.
  - `migrations/`: Contains migrations scripts which will be used be truffle to handle deployment.
  - `test/`: Contains test scripts `truffle-config.js`: Contains truffle configurations

- The contracts from openzeppelin, it means it's needed the run of: `npm install @openzeppelin/contracts`.
  
  After the installation, I moved the folder `@openzeppelin/contracts`, which can be found in the `node_modules/` folder, into the `contracts/` folder. It was an obligatory choice, since the command `./node_modules/.bin/truffle compile` was giving problems. In theory, according to what it's written on the [truffle suite NPM guide](https://trufflesuite.com/docs/truffle/how-to/package-management-via-npm/), when I do an import like:
  ```solidity
  import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // NFT's standard
  ```
  >Since the path didn't start with ./, Truffle knows to look in your project's node_modules directory for the example-truffle-library folder. From there, it resolves the path to provide you the contract you requested.

  But it wasn't true for my case, that's why I modified the import to:
  ```solidity
  import "./@openzeppelin/contracts/token/ERC721/ERC721.sol"; // NFT's standard
  ```

 


<!-- It's important the version of solidity, I would suggest that if you want to create a contract do it using `truffle create contract <name of your contract>`. In this way, it will be more likely that the solidtiy version of your installation will be respected. -->