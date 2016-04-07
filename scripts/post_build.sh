# Debian/Ubuntu assumed.

export DEBIAN_FRONTEND=noninteractive

# Need to install these for later use.
echo "==> Installing some dependent packages."
apt-get install --assume-yes \
    linux-headers-$(uname -r) \
    build-essential \
    perl

##
## Configure Vagrant user.
##
echo "==> Configuring settings for Vagrant user. BENV_VAGRANT_USER: ${BENV_VAGRANT_USER}"
VAGRANT_SSH_KEY_URL=${VAGRANT_SSH_KEY_URL:-https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub}

# Add Vagrant user (if it doesn't already exist)
if ! id -u $BENV_VAGRANT_USER > /dev/null 2>&1; then
    echo '==> Creating Vagrant user'
    /usr/sbin/groupadd $BENV_VAGRANT_USER
    /usr/sbin/useradd $BENV_VAGRANT_USER -g $BENV_VAGRANT_USER -G sudo
    echo "${BENV_VAGRANT_USER}" | passwd --stdin $BENV_VAGRANT_USER
fi

##
## Tweek sudoers file.
##
echo '==> Configuring /etc/sudoers file.'
/usr/sbin/usermod -a -G sudo $BENV_VAGRANT_USER
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers
sed -i -e 's/%sudo\s\+ALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers

##
## Installing vagrant keys
##
echo '==> Installing Vagrant SSH key.'
mkdir -pm 700 $BENV_VAGRANT_HOME/.ssh
echo "==> Downloading SSH key from ${VAGRANT_SSH_KEY_URL}."
echo "==> Saving to ${BENV_VAGRANT_HOME}/.ssh/authorized_keys."
wget --no-check-certificate "${VAGRANT_SSH_KEY_URL}" \
    -O $BENV_VAGRANT_HOME/.ssh/authorized_keys \
    3>&1 1>&2 2>&3 3>&- 1>/dev/null | sed -e 's/^/.   /'
chmod 0600 $BENV_VAGRANT_HOME/.ssh/authorized_keys
chown -R $BENV_VAGRANT_USER:$BENV_VAGRANT_USER $BENV_VAGRANT_HOME/.ssh

##
## Miscellaneous
##
echo '==> Recording box config date.'
date > /etc/vagrant_box_build_time

echo '==> Customizing message of the day.'
echo > /etc/motd
echo 'Have a lot of fun!' >> /etc/motd
