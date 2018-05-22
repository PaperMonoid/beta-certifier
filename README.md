# β certifier
Blockchain is a promising technology which may solve many problems in different areas. β certifier applies this technology to generate and sign certificates to have a better control over the security and credibility of these documents.

## Quick start
We're building a prototype using the [MITs blockcerts project](https://github.com/blockchain-certificates), so the first step to get started is to clone the repositories and follow the instructions to set them up correctly:
```shell
# cert-tools creates certificates
git clone https://github.com/blockchain-certificates/cert-tools.git

# cert-issuer signs certificates
git clone https://github.com/blockchain-certificates/cert-issuer.git

# cert-viewer displays certificates
git clone https://github.com/blockchain-certificates/cert-viewer.git
```

* Note: If you want to display html certificates on the wallet-android app, apply the changes from this [pull request](https://github.com/blockchain-certificates/cert-tools/pull/27/commits/34c6bff62282c6c1fe96fd91bad4b9b80b5303e6) to *cert-tools/cert_tools/create_v2_certificate_template.py*.

Now clone the β certifier repository to the same directory as the other projects:
```
# beta-certifier
git clone https://github.com/TritiumMonoid/beta-certifier.git
```

* The project needs to be provided a public key and a private key to continue. Please ask for these files to the developer.
* If you're out of funds, please request more using [testnet faucet](https://testnet.manu.backend.hamburg/faucet) with the public key provided by the developer. The transaction may take many hours to complete.

Run the following commands to generate certificates:
```shell
# set the projects directoy
export BETA_PROJECTS=$PATH_TO_THE_PROJECTS_DIRECTORY

# give permissions to execute the script
chmod +x certify.sh

# execute the script
./certify.sh
```

The generated certificates will be in the path `data/blockchain_certificates/` and can be verified at [MITs blockcert projects website](https://www.blockcerts.org/)

If you want to issue more certificates you might want to clean the certificates directory with:
```shell
# give permissions to execute the script
chmod +x clean.sh

# execute the script
./clean.sh
```

In order to view your certificates with cert-viewer you need to serve a local json file with flask:
```shell
# install flask if needed
pip install flask

# change directory to beta-certifier
cd beta-certifier

# run server
python server/server.py
```

You may run cert-viewer now and validate your certificates with it.

## Common errors
If there are errors while running the docker container you might want to run the following command:
```shell
sudo chown $USER /var/run/docker.sock
```
