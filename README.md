# SplunkSetups
Simple Splunk setup scripts for a variety of causes

## Table of Contents
 1. [Useful Splunk CLI commands](https://github.com/gnubyte/SplunkSetups/blob/master/cliUsefulCommands.sh)
 1. [Single Splunk All In One Instance Setup Script](https://github.com/gnubyte/SplunkSetups/blob/master/singleAioInstance.sh)


------

### cliUsefulCommands.sh
_A list of commands found useful during deployment. Best for small teams or single server setups_

#### :fire: not intended for scripted deployments

When used in context, it is a good checklist for clearing fishbuckets, checking inputs, changing host level network configs for ease of splunk deployment server automation, etc.

**Scripts Contents:**
 - RHEL installation
 - add search peer
 - verifying who is running splunk
 - resetting splunk password
 - changing server hostname
 - change server config
 - list block devices attached to instance
 - report existing disk space used
 - Changing disk size, grow the partition if added scale
 - changing splunk host name
 - clear event data


### singleAioInstance.sh
Installation via tgz files of Splunk instance. Current link represents splunk 7.x
Run with elevated permissions, this will change the directories owner to Splunk and auto start the splunk instance.
**this will change the current password to changed**

#### :fire: RHEL based distros only

