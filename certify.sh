create-certificate-template -c $BETA_PROJECTS/beta-certifier/conf.ini

instantiate-certificate-batch -c $BETA_PROJECTS/beta-certifier/conf.ini

#-i is for interactive -d is for detached
docker run -dt bc/cert-issuer:1.0 bash

CONTAINERID=$(docker ps | grep bc/cert-issuer:1.0 | awk -F " " '{print $1}' | tail -1)

docker cp $BETA_PROJECTS/beta-certifier/sample_data/unsigned_certificates/. $CONTAINERID:/etc/cert-issuer/data/unsigned_certificates
docker cp $BETA_PROJECTS/beta-certifier/certify_docker.sh $CONTAINERID:/

docker exec -i $CONTAINERID bash < certify_docker.sh

echo "Copying certificates..."
docker cp $CONTAINERID:/etc/cert-issuer/data/blockchain_certificates/. $BETA_PROJECTS/beta-certifier/data/blockchain_certificates
echo "Certificates copied!"

echo "Deleting container..."
docker ps | grep bc/cert-issuer:1.0 | awk -F " " '{print $1}' | tail -1 | xargs docker kill
echo "Container deleted!"
