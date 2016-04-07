
echo "==> Autoremoving any unneeded packages."
apt-get autoremove --assume-yes

echo "==> Removing provisioning files."
rm -rf ${BENV_VAGRANT_HOME}/files

