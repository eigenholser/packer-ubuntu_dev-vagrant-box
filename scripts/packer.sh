# This provisioning script runs after the Vagrant user is fully configured.

set -e

# https://packer.io
#
# This needs to be updated periodically to remain current. From virtual
# machine, just run the provisioning script like this:
#
#   sudo sh packer.sh
#
packer_package=packer_0.9.0_linux_amd64.zip

# Because Packer is so large ('cuz aren't all Go executables?) a developer may
# want to download it locally into the ubuntu-dev/files directory. We check
# for the local file before fetching it from the net.
if [ -e ${BENV_VAGRANT_HOME}/files/$packer_package ]; then
    echo "==> Using local Packer package."
else
    echo "==> Downloading Packer package."
    curl --silent --insecure -L \
        https://releases.hashicorp.com/packer/0.9.0/{$packer_package} \
        --output ${BENV_VAGRANT_HOME}/files/#1
fi

# Remove old packer executable if present.
#rm -f /usr/bin/packer

echo "==> Installing Packer"
cd /usr/bin
unzip -qq ${BENV_VAGRANT_HOME}/files/$packer_package
rm -f ${BENV_VAGRANT_HOME}/files/$packer_package

