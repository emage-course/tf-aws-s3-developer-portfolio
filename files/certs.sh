

##############################################################################################################################
### Step 3. Create self signed certificate
##############################################################################################################################

sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo usermod -aG docker ${USER}

mkdir -p /etc/jenkins/
mkdir -p /etc/jenkins/ssl 

mkdir -p certs
cd certs

cat << EOF >> domains.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = kendopx.com
DNS.2 = jenkins.kendopx.com
IP.1 = 3.131.188.146
EOF

### create keys using this file
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout RootCA.key -out RootCA.pem -subj "/C=US/CN=Kendopz-Root-CA"
openssl x509 -outform pem -in RootCA.pem -out RootCA.crt
openssl req -new -nodes -newkey rsa:2048 -keyout localhost.key -out localhost.csr -subj "/C=US/ST=Texas/L=Katy/O=Kendopz-Certificates/CN=localhost.local"
openssl x509 -req -sha256 -days 1024 -in localhost.csr -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile domains.ext -out localhost.crt

### Convert to support https
sudo mkdir -p /etc/jenkins/ssl
sudo cp localhost.crt /etc/jenkins/ssl/jenkins.kendopx.com.crt
sudo cp localhost.crt /etc/jenkins/ssl/registry.jenkins.kendopx.com.crt
sudo cp localhost.key /etc/jenkins/ssl/jenkins.kendopx.com.key
sudo cp localhost.key /etc/jenkins/ssl/registry.jenkins.kendopx.com.key

### For Docker to connect to self signed jenkins server, we have to add the certificate in following location:
sudo mkdir -p /etc/docker/certs.d/registry.jenkins.kendopx.com
sudo cp localhost.crt /etc/docker/certs.d/registry.jenkins.kendopx.com/ca.crt