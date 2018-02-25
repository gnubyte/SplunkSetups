# @Date: 02-25-2018
# @Author: Patrick Hastings
# @Instructions: Copy and paste this into a server and run with elevated permissions
# @Note: this will install splunk to opt directory by default
# ------


######### RHEL Specifically ########
sudo yum install nano -y && sudo yum update -y && sudo yum install wget -y
sudo yum install zip -y && sudo yum install unzip -y
wget -O splunk-7.0.1-2b5b15c4ee89-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.1&product=splunk&filename=splunk-7.0.1-2b5b15c4ee89-Linux-x86_64.tgz&wget=true'
sudo tar xvzf splunk-7.0.1-2b5b15c4ee89-Linux-x86_64.tgz -C /opt
export SPLUNK_HOME=/opt/splunk/ >> ~/.bashrc
. ~/.bashrc
sudo groupadd splunk
sudo adduser splunk -g splunk
sudo chown -R splunk:splunk /opt/splunk
sudo -H -u splunk /opt/splunk/bin/splunk start --accept-license
sudo -H -u splunk /opt/splunk/bin/splunk edit user admin -password changed -role admin -auth admin:changeme 
sudo -H -u splunk /opt/splunk/bin/splunk enable boot-start -user splunk