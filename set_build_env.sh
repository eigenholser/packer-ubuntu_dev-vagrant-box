# This will get you started with a minimum of typing.
#
# To activate, do this:
#
#   source set_build_env.sh
#
# before you start your Packer build.

# Example. Set them here or somewhere else if you like.
# export BOX_NAME=mybox
# export PROJECT_DATABASE_NAME=mydatabase
# export PROJECT_NAME=myproject

export BOX_DIR=${HOME}/boxes
export VAGRANT_USERNAME=vagrant
export VAGRANT_PASSWORD=vagrant
export UBUNTU_1404_SERVER_ISO_PATH=${HOME}/Downloads/ubuntu-14.04.4-server-amd64.iso
export UBUNTU_1404_SERVER_ISO_CHECKSUM=3ffb7a3690ce9a07ac4a4d1b829f990681f7e47d
export BENV_PROJECT_DATABASE_NAME=${PROJECT_DATABASE_NAME:-devdb}
export BENV_BOX_HOSTNAME=${BOX_NAME:-ubuntu-dev}
export BENV_VIRTUALENV_NAME=${PROJECT_NAME:-venv}

