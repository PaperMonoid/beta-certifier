# β certifier
Blockchain is a promising technology which may solve many problems in different areas. β certifier applies this technology to generate and sign certificates to have a better control over the security and credibility of these documents.

## Quick start
We're building a prototype using the [MITs blockcerts project](https://github.com/blockchain-certificates), so the first step to get started is to clone the repositories and follow the instructions to set them up correctly:
```shell
# cert-tools creates certificates
https://github.com/blockchain-certificates/cert-tools.git

# cert-issuer signs certificates
git clone https://github.com/blockchain-certificates/cert-issuer.git
```

Now clone the β certifier repository to the same directory as the other projects:
```
# beta-certifier
git clone https://github.com/TritiumMonoid/beta-certifier.git
```

Run the following commands to generate certificates:
```shell
# set the projects directoy
BETA_PROJECTS=$PATH_TO_THE_PROJECTS_DIRECTORY

# give permissions to execute the script
chmod +x certify.sh

# execute the script
./certify.sh
```

The generated certificates will be in the path `data/blockchain_certificates/`
