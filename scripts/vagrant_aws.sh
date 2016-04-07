# This provisioning script runs after the Vagrant user is fully configured.

set -e

# https://vagrantup.com
#
# This needs to be updated periodically to remain current. From virtual
# machine, just run the provisioning script like this:
#
#   sudo sh vagrant_aws.sh
#
vagrant_package=vagrant_1.8.1_x86_64.deb

# Because Packer is so large ('cuz aren't all Go executables?) a developer may
# want to download it locally into the ubuntu-dev/files directory. We check
# for the local file before fetching it from the net.
if [ -e ${BENV_VAGRANT_HOME}/files/$vagrant_package ]; then
    echo "==> Using local Vagrant package."
else
    echo "==> Downloading Vagrant package."
    curl --silent --insecure -L \
        https://releases.hashicorp.com/vagrant/1.8.1/{$vagrant_package} \
        --output ${BENV_VAGRANT_HOME}/files/#1
fi

echo "==> Installing Vagrant package."
dpkg -i ${BENV_VAGRANT_HOME}/files/${vagrant_package}
rm ${BENV_VAGRANT_HOME}/files/${vagrant_package}

echo "==> Installing Vagrant AWS plugin."
su -l $BENV_VAGRANT_USER -c "vagrant plugin install vagrant-aws"

