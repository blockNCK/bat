/*
SPDX-License-Identifier: Apache-2.0
*/

'use strict';

// Bring key classes into scope, most importantly Fabric SDK network class
const fs = require('fs');
const yaml = require('js-yaml');
const { FileSystemWallet, Gateway } = require('fabric-network');


// Main program function
async function main () {

    // A gateway defines the peers used to access Fabric networks
    const gateway = new Gateway();

    // Main try/catch block
    try {

        // Load connection profile; will be used to locate a gateway
        let connectionProfile = yaml.safeLoad(fs.readFileSync('./gateway/networkConnection.yaml', 'utf8'));

        let configProfile = yaml.safeLoad(fs.readFileSync('config.yaml','utf8'));

        var user=configProfile.credentials.user;

        // A wallet stores a collection of identities for use
        const wallet = new FileSystemWallet(`./application/identity/user/adam/wallet/`);

        // Specify userName for network access
        const userName = 'Admin@supplier.nck.com';

        // Set connection options; identity and wallet
        let connectionOptions = {
            identity: userName,
            wallet: wallet,
            discovery: { enabled: false, asLocalhost: true }

        };


        await gateway.connect(connectionProfile, connectionOptions);
        const network = await gateway.getNetwork('nckchannel');
        const contract = await network.getContract('nckcc');
        const buyResponse = await contract.submitTransaction('queryBatchByBlock', '0');
        console.log(buyResponse);

    } catch (error) {

        console.log(`Error processing transaction. ${error}`);
        console.log(error.stack);

    } finally {

        // Disconnect from the gateway
        console.log('Disconnect from Fabric gateway.');
        gateway.disconnect();

    }
}
main().then(() => {

    console.log('Create batch complete.');

}).catch((e) => {

    console.log('create program exception.');
    console.log(e);
    console.log(e.stack);
    process.exit(-1);

});