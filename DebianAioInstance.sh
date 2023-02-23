# @Date: 08-01-2018
# @Version: 1.1.0
# @Author: Patrick Hastings
# @Distro: Debian 9.x x86_64
# @Instructions: Copy and paste this into a server and run with elevated permissions
# @Note: this will install splunk to opt directory by default
# ------


######### Debian Specifically ########
sudo apt-get update -y
sudo apt-get install man-db -y
sudo apt-get install nano -y && sudo apt-get update -y && sudo apt-get install wget -y
sudo apt-get install zip -y && sudo apt-get install unzip -y
sudo apt-get install fail2ban -y
sudo apt-get install ufw -y
#wget -O splunk-7.0.1-2b5b15c4ee89-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.1&product=splunk&filename=splunk-7.0.1-2b5b15c4ee89-Linux-x86_64.tgz&wget=true'
#wget -O splunk-8.2.3-cd0848707637-linux-2.6-amd64.deb 'https://download.splunk.com/products/splunk/releases/8.2.3/linux/splunk-8.2.3-cd0848707637-linux-2.6-amd64.deb'
#wget -O splunk-8.2.3-cd0848707637-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/8.2.3/linux/splunk-8.2.3-cd0848707637-Linux-x86_64.tgz'
wget -O splunk-9.0.4-de405f4a7979-linux-2.6-amd64.deb "https://download.splunk.com/products/splunk/releases/9.0.4/linux/splunk-9.0.4-de405f4a7979-linux-2.6-amd64.deb"
#sudo tar xvzf splunk-8.2.3-cd0848707637-Linux-x86_64.tgz -C /opt
sudo dpkg -i splunk-9.0.4-de405f4a7979-linux-2.6-amd64.deb
sudo groupadd splunk
sudo adduser --ingroup splunk --disabled-password --gecos "" splunk
sudo chown -R splunk:splunk /opt/splunk
sudo -H -u splunk /opt/splunk/bin/splunk start --accept-license
sudo -H -u splunk /opt/splunk/bin/splunk edit user admin -password changed -role admin -auth admin:changeme 
sudo -H /opt/splunk/bin/splunk enable boot-start -user splunk
export SPLUNK_HOME=/opt/splunk/ >> /home/splunk/.bashrc
export PATH=$SPLUNK_HOME/bin:$PATH >> /home/splunk/.bashrc
. /home/splunk/.bashrc
sudo apt-get install letsencrypt -y
