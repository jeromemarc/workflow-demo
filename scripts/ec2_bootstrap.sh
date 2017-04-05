#!/bin/bash
# Inserted into ec2 instance user-data - so is executed on boot.
# Nice way to bootstrap a vanilla ec2 AMI by talking to Ansible Tower.
# To understand Tower callbacks see http://docs.ansible.com/ansible-tower/latest/html/userguide/job_templates.html#provisioning-callbacks

# Enabled pipelining for Ansible
/usr/bin/perl -ni -e 'print unless /^Defaults \s+ requiretty/x' /etc/sudoers

limit=`wget -qO- http://instance-data/latest/meta-data/public-ipv4`
param=`echo {\"limit\": \"$limit\"}`

# Tower callback (via SSH forwarding):
tower=52.91.21.15
tower_user=admin
tower_password=password
template_key=0c3df5340427a69d4b6bcbb87e1b7282
template_id=1944

#if [[ -z ${tower} ]]; then
#    logger 'ansible: could not find tower host'
#    exit 1
#fi

echo "curl -f -k -H 'Content-Type: application/json' -XPOST -d '$param' --user $tower_user:$tower_password https://$tower:443/api/v1/job_templates/$template_id/launch/" | bash -

exit 1
