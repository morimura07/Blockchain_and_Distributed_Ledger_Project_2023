# First gym based on blockchain: dApp
In this folder is contained the application used to interact with the blockchain we are testing locally. 

The technology used to build the application is [Flutter](https://flutter.dev/), a Google's framework with the purpose of building in a fast and easy way an application.

# Gym App

Here the details about the repository.


## Code about blockchain
To set-up this project I used the [truffle suite](https://trufflesuite.com).

Unforutnately, I encountered quite a lot of problems on the road for compiling and deploying the Smart Contracts. \
Therefore, I reported down here the procedure that I found on my own to make the things work, it could be that if you follow the official guide it will work properly but, in my case, maybe for some dependency conflic in my environment, it's been complex.

### Installation procedure
- [installation of truffle](https://trufflesuite.com/docs/truffle/how-to/install/); I am using MacOS and the problem of this installation got me stuck for a while.
  
  First of all, I advise to install the Node Version Manager (`nvm`), so that in case in the future there will be the need. 
  
  Then, the guide that I linked here above, ask to install globally `truffle`, running the command `npm i -g truffle`. In my case, I got an error from the terminal saying that due to a previous bug of **npm** I had to run a command to fix the privilages problems of installing packages globally with npm (so, be carefoul reading the error message if you encounter one). 
  
  After installing **truffle** it's possible to run `truffle init`, the three folders will be created:
  - `contracts/`: Contains smart contract code.
  - `migrations/`: Contains migrations scripts which will be used be truffle to handle deployment.
  - `test/`: Contains test scripts `truffle-config.js`: Contains truffle configurations

- now run the command `npm init -y` from the folder from which you ran the command `truffle init`. If you get any error, please, create an empty `package.json` file.
- The contracts from openzeppelin are required, run the command `npm install @openzeppelin/contracts`.

  In theory, according to what it's written on the [truffle suite NPM guide](https://trufflesuite.com/docs/truffle/how-to/package-management-via-npm/), when I do an import like:
  ```solidity
  import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // NFT's standard
  ```
  >Since the path didn't start with ./, Truffle knows to look in your project's node_modules directory for the example-truffle-library folder. From there, it resolves the path to provide you the contract you requested.

### Compiling procedure
Once we completed succesfully the above procedure it's possible to run the command `truffle compile` or `truffle compile --all`.


[Here an article](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally) in case of problem with the global installation using npm.

 


<!-- It's important the version of solidity, I would suggest that if you want to create a contract do it using `truffle create contract <name of your contract>`. In this way, it will be more likely that the solidtiy version of your installation will be respected. -->