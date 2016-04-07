
echo "PACKER_BUILD_NAME: ${PACKER_BUILD_NAME}"
echo "PACKER_BUILDER_TYPE: ${PACKER_BUILDER_TYPE}"
echo "BENV_VAGRANT_USER: ${BENV_VAGRANT_USER}"
echo "BENV_VAGRANT_HOME: ${BENV_VAGRANT_HOME}"

if [ "${PACKER_BUILDER_TYPE%%-*}" = "vmware" ]; then
    echo "==> Installing VMware Tools"
    cd /tmp
    mkdir -p /mnt/cdrom
    mount -o loop ${BENV_VAGRANT_HOME}/linux.iso /mnt/cdrom
    tar zxf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
    /tmp/vmware-tools-distrib/vmware-install.pl --default
    rm ${BENV_VAGRANT_HOME}/linux.iso
    umount /mnt/cdrom
    rmdir /mnt/cdrom
fi


if [ "${PACKER_BUILDER_TYPE%%-*}" = "virtualbox" ]; then
    echo "==> Installing VirtualBox guest additions"

    # Assume that we've installed all the prerequisites:
    # kernel-headers-$(uname -r) kernel-devel-$(uname -r) gcc make perl
    # from the install media via ks.cfg

    VBOX_VERSION=$(cat ${BENV_VAGRANT_HOME}/.vbox_version)
    mount -o loop ${BENV_VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
    sh /mnt/VBoxLinuxAdditions.run --nox11 3>&1 1>&2 2>&3 3>&- 1>/dev/null | sed -e 's/^/.   /'
    umount /mnt
    rm -rf ${BENV_VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso

    if [ $VBOX_VERSION = "4.3.10" ]; then
        ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
    fi
fi

