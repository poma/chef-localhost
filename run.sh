#!/bin/bash
SCRIPT_PATH="`dirname \"$0\"`"

if ! type "chef-solo" > /dev/null || ! type "berks" > /dev/null; then
	echo "Installing Chef-DK"
	apt-get install -y wget
	wget https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.16.28-1_amd64.deb
	dpkg -i chefdk_0.16.28-1_amd64.deb
	apt-get install -f
	rm chefdk_0.16.28-1_amd64.deb
fi

#berks install
berks vendor /root/.chef/cookbooks --berksfile=$SCRIPT_PATH/Berksfile
chef-solo -c $SCRIPT_PATH/solo.rb -j $SCRIPT_PATH/solo.json
