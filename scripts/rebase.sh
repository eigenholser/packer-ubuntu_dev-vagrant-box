# Debian/Ubuntu assumed.

export DEBIAN_FRONTEND=noninteractive

##
## Get current
##
echo '==> Updating system and installing dependencies.'
apt-get update

#echo "==> Removing existing linux-headers cuz Stackoverflow said so."
#apt-get remove --assume-yes linux-headers-$(uname -r)

echo "==> Doing apt-get upgrade"
apt-get upgrade -f --assume-yes;

#echo "==> Autoremoving unneeded packages."
#apt-get autoremove --assume-yes

echo "==> Installing dkms"
apt-get install --assume-yes dkms

# Need to reboot so VM tools installation has correct headers for running
# kernel
echo "==> Rebooting VM"
reboot

# This recommended in Packer docs so packer doesn't attempt to execute the next
# provisioning script. http://www.packer.io/docs/provisioners/shell.html
echo "==> Sleeping for 60 seconds for reboot."
sleep 60

