
# Just output the Packer variables.
echo "==> Variables Packer knows about."
echo

echo "==> PACKER_BUILD_NAME: ${PACKER_BUILD_NAME}"
echo "==> PACKER_BUILDER_TYPE: ${PACKER_BUILDER_TYPE}"

# Validation
if [ ! -z ${BENV_VAGRANT_USER+x} ]; then
    echo "==> BENV_VAGRANT_USER: ${BENV_VAGRANT_USER}"
else
    echo "BENV_VAGRANT_USER is required!"
    exit 1
fi

if [ ! -z ${BENV_VAGRANT_USER+x} ]; then
    echo "==> BENV_VAGRANT_PWD: ${BENV_VAGRANT_PWD}"
else
    echo "BENV_VAGRANT_PWD is required!"
    exit 1
fi

if [ ! -z ${BENV_VAGRANT_HOME+x} ]; then
    echo "==> BENV_VAGRANT_HOME: ${BENV_VAGRANT_HOME}"
else
    echo "BENV_VAGRANT_HOME is required!"
    exit 1
fi

if [ ! -z ${BENV_PROJECT_DATABASE_NAME+x} ]; then
    echo "==> BENV_PROJECT_DATABASE_NAME: ${BENV_PROJECT_DATABASE_NAME}"
else
    echo "BENV_PROJECT_DATABASE_NAME is required!"
    exit 1
fi

if [ ! -z ${BENV_VIRTUALENV_NAME+x} ]; then
    echo "--> BENV_VIRTUALENV_NAME: ${BENV_VIRTUALENV_NAME}"
else
    echo "BENV_VIRTUALENV_NAME is required!"
    exit 1
fi

echo

