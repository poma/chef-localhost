#!/bin/bash
SCRIPT_PATH="`dirname \"$0\"`"

if ! type "chef-solo" > /dev/null || ! type "berks" > /dev/null; then
	echo "Installing Chef-DK"
	apt-get install -y curl
	curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk
fi

#berks install
berks vendor /root/.chef/cookbooks --berksfile=$SCRIPT_PATH/Berksfile
chef-solo -c $SCRIPT_PATH/solo.rb -j $SCRIPT_PATH/solo.json
