# @Title: 2SH2IDX_Setup
# @Purpose: copy and paste-able instructions 
# @Date: 01-18-2018
# @Author: Patrick Hastings
# @Notes: Rinse and repeat for each Server. Intended for 2 search heads and 2 indexers, nonclustered
############# Server Update and my text editor of personal choice #####
sudo yum update -y
sudo yum install nano -y

# ------------------------------------------------------
############### RHEL SPLUNK INSTALL #####################
wget -O splunk-7.0.1-2b5b15c4ee89-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.1&product=splunk&filename=splunk-7.0.1-2b5b15c4ee89-linux-2.6-x86_64.rpm&wget=true'
rpm -i splunk*
export SPLUNK_HOME=/opt/splunk/
sudo su
chown -R splunk:splunk /opt/splunk
cd /opt/splunk/bin
./splunk start --accept-license
./splunk edit user admin -password PASSWORDHERE -role admin -auth admin:changeme 
cd /opt/splunk/bin && ./splunk enable boot-start -user splunk
shutdown -r 0

# on search heads ONLY...If AWS, USE PRIVATE IP! 
sudo ./splunk  add search-server <intended IDX1 | IDX2 ip>:8089 -auth admin:PASSWORD -remoteUsername admin -remotePassword PASSWORD
# add search-server adds search-peers (indexers) to search from

# ------------------------------------------------------
############### Verifying who is running Splunk ###############
cd ~
sudo su splunk
#logging in as splunk...
chown -R splunk:splunk /opt/splunk
# ps reports a snapshot of the current processes
# grep returns strings matching the param pattern(string in this case)
ps -eaf | grep splunk 
# check for who is running splunk(what user)


# ------------------------------------------------------
### IF PASSWORD NEED RESET FOR SPLUNK....
# rename the password to passwd.bak for backup purposes....
mv /opt/splunk/etc/passwd /opt/splunk/etc/passwd.BAK
cd /opt/splunk/bin && ./splunk restart
# restart splunk so it can check for that file and create a new passwd file

# ------------------------------------------------------
##### Other Useful Tidbits ######

cd/opt/splunk/bin && ./splunk restart


# ---------------------
# if same hostname because using AMI...
# Changes hostname

#enter role and number
sudo nano /etc/sysconfig/network
sudo reboot
hostname
# confirm hostname value is different


# Combining the dumb stuff I have to paste 4x times.....
sudo su && cd/opt/splunk/bin
hostname -v IDX-01.localhost.com
nano /opt/splunk/etc/system/local/server.conf

# ---------------------
# Expanding the File system after EBS expansion


sudo file -s /dev/xvd*
# list file system data for analysis
 
lsblk 
# list the block devices attached to your instance

df -h
# report existing disk space used

# recommended by AWS Team....but if using an AMI from them it automatically does this on reboot
sudo growpart /dev/xvdf 1


lsblk 
# confirm changes now
df -h
# ------------------------------------------------------
######### editing inputs for configuration to change HOST in Splunk ##########
sudo su
nano /opt/splunk/etc/system/local/inputs.conf
# switch your ip from last known to current actual ip

# -------------------------------------------------------
######## Cleaning event data ###########
cd /opt/splunk/bin/ && ./splunk stop
./splunk clean eventdata
# fishbucket will error out, clean it the old fashioned way
rm -r /opt/splunk/var/lib/splunk/fishbucket/.*
shutdown -r 0

