echo "Generating issuer..."
while ["$issuer" = ""]
do
    issuer=`bitcoin-cli getnewaddress`
    sleep 3
done
echo "Issuer:  $issuer"
sed -i.bak "s/<issuing-address>/$issuer/g" /etc/cert-issuer/conf.ini
bitcoin-cli dumpprivkey $issuer > /etc/cert-issuer/pk_issuer.txt
echo "Data dumped!"

echo "Transfering bitcoin..."
bitcoin-cli generate 101
bitcoin-cli sendtoaddress $issuer 5
echo "Bitcoin sent!"

echo "Signing certificates..."
cert-issuer -c /etc/cert-issuer/conf.ini
echo "Certificates were signed succesfully!"
