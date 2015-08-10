.. _ssl-tomcat-configuration:

========================
SSL Tomcat Configuration
========================




GENERATE KEYSTORE ON WEB:  
https://www.digicert.com/easy-csr/keytool.htm

CREATE KEYSTORE:
keytool -genkey -alias server -keyalg RSA -keysize 2048 -keystore keystore.jks -dname "CN=sangah.com,OU=IT Department, O=Sangah, L=Seoul, ST=Seoul, C=KR" && keytool -certreq -alias server -file request.csr -keystore keystore.jks && echo Your certificate signing request is in request.csr.  Your keystore file is keystore.jks.


GET CERTIFICATION:
The CSR file will be used by the Certificate Authority to create a Certificate that will identify your website as "secure".
Just follow the istruction.

http://www.symantec.com/verisign/ssl-certificates


GET ROOT CERTIFICATE:
Copy the content in a file with name root_ca.cer.
https://knowledge.verisign.com/support/ssl-certificates-support/index?page=content&id=AR1751

IMPORT ROOT CERT:
keytool -import -trustcacerts -alias root -keystore keystore.jks -file root_ca.cer


GET INTERMEDIATE CERTIFICATE:
Copy the content in a file with name intermediate.cer.
https://knowledge.verisign.com/support/ssl-certificates-support/index?page=content&id=AR1737

IMPORT INTERMEDIATE CERT:
keytool -import -trustcacerts -alias intermediate -keystore keystore.jks -file intermediate.cer


IMPORT CERTIFICATION:
keytool -import -trustcacerts -alias server -keystore keystore.jks -file ssl_cert.cer


TOMCAT SERVER CONFIGURATION:

Add the following connector to the service

<Connector port="8444" protocol="HTTP/1.1" SSLEnabled="true"
               maxThreads="150" scheme="https" secure="true"
               clientAuth="false" sslProtocol="TLS" keystoreFile="C:/Users/Disco/keystore.jks" keystorePass="123456" />


Free Trial SSL Certificate Browser Installation Instructions ( Trial Test Only ):
https://knowledge.verisign.com/support/ssl-certificates-support/index?page=content&actp=CROSSLINK&id=AR1738

FINISHED!


MORE INFO:

Installation Instructions for Tomcat using X.509 format: 
https://knowledge.verisign.com/support/ssl-certificates-support/index?page=content&actp=CROSSLINK&id=AR234

Installation Instructions for SSL Certificates: 
https://knowledge.verisign.com/support/ssl-certificates-support/index?page=content&actp=CROSSLINK&id=AR212

Symantec Intermediate CA Certificates ( ROOT, INTERMEDIATE ):
https://knowledge.verisign.com/support/ssl-certificates-support/index?page=content&actp=CROSSLINK&id=AR657 


KEYTOOL COMMANDS:

keytool -genkey -alias tomcat -keyalg RSA -keysize 2048 -keystore C:\Users\Disco\.keystore
keytool -certreq -keyalg RSA -alias tomcat -file certreq.csr -keystore C:\Users\Disco\.keystore
keytool -import -alias root -keystore sangah_com.jks -trustcacerts -file intermediate.cer
keytool -import -alias tomcat -keystore sangah_com.jks -file trial_certificate.cer
keytool -list -v -keystore  sangah_com.jks > cerinfo.log


OPENSSL:
set OPENSSL_CONF=c:\[PATH TO YOUR OPENSSL DIRECTORY]\bin\openssl.cfg

