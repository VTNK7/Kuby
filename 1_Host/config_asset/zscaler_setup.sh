echo "Zscaler setup script for debian"
echo
echo "Launch in /home/vagrant directory, need /tmp/config_asset/zscaler.cer file in the same directory"
echo
sudo openssl x509 -inform DER -in /tmp/config_asset/zscaler.cer -out /tmp/config_asset/zscaler.crt
sudo cp /tmp/config_asset/zscaler.crt /usr/local/share/ca-certificates/
cd /usr/local/share/ca-certificates/
sudo update-ca-certificates
cd
