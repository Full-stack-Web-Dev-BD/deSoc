const solc= require('solc')
const fs = require('fs')
const UserManagement= fs.readFileSync('./contracts/UserManagement.sol')


const input = {
    language: 'Solidity',
    sources: {
        'UserManagement.sol': {
            content: UserManagement
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': ['abi', 'evm.bytecode']
            }
        },
        optimizer: {
            enabled: true,
            runs: 200
        },
        language: "Solidity",
        version: "0.8.17"
    }
};

const output = JSON.parse(solc.compile(JSON.stringify(input)));
if (output.errors) {
  console.error('Errors encountered during compilation:', output.errors);
} else {
  console.log("Compilation was successful, do something with the output");
}
