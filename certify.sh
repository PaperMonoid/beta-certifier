#create-certificate-template -c $BETA_PROJECTS/beta-certifier/my-conf.ini
#instantiate-certificate-batch -c $BETA_PROJECTS/beta-certifier/my-conf.ini

cp $BETA_PROJECTS/beta-certifier/conf.ini $BETA_PROJECTS/beta-certifier/my-conf.ini
export HTML_CODE=$(tr -d '\n' < $BETA_PROJECTS/beta-certifier/certificate.html | sed "s/\//\\\\\//g")
sed -ie "s/<h1>Some html code<\/h1>/$HTML_CODE/g" $BETA_PROJECTS/beta-certifier/my-conf.ini
cat $BETA_PROJECTS/beta-certifier/my-conf.ini

python $BETA_PROJECTS/cert-tools/cert_tools/create_v2_certificate_template.py -c $BETA_PROJECTS/beta-certifier/my-conf.ini
python $BETA_PROJECTS/cert-tools/cert_tools/instantiate_v2_certificate_batch.py -c $BETA_PROJECTS/beta-certifier/my-conf.ini

rm my-conf.ini

CONTAINERID=$(docker ps -a | awk -F " " '{ if($2=="bc/cert-issuer:1.0") print $1 }')

docker start $CONTAINERID

docker cp $BETA_PROJECTS/beta-certifier/sample_data/unsigned_certificates/. $CONTAINERID:/etc/cert-issuer/data/unsigned_certificates
docker cp $BETA_PROJECTS/beta-certifier/certify_docker.sh $CONTAINERID:/

docker exec -i $CONTAINERID bash < certify_docker.sh

echo "Copying certificates..."
docker cp $CONTAINERID:/etc/cert-issuer/data/blockchain_certificates/. $BETA_PROJECTS/beta-certifier/data/blockchain_certificates
echo "Certificates copied!"

echo "Deleting old certificates..."
docker exec -ti $CONTAINERID sh -c "rm /etc/cert-issuer/data/unsigned_certificates/*.json && rm /etc/cert-issuer/data/blockchain_certificates/*.json"
echo "Certificates deleted!"

echo "Killing container..."
docker kill $CONTAINERID
echo "Container killed!"
