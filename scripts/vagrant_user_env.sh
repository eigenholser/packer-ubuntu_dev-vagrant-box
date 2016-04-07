
echo "==> Configuring Vagrant user environment"

cp ${BENV_VAGRANT_HOME}/files/vimrc ${BENV_VAGRANT_HOME}/.vimrc
rm ${BENV_VAGRANT_HOME}/files/vimrc

cat >>"${BENV_VAGRANT_HOME}/.bashrc" <<EOF
export PS1='\h:\w (\u)\$ '
export PAGER=less   # For psql mainly.
export LESS=-X      # Don't use screen.

# Virtualenvwrapper
export WORKON_HOME=\${HOME}/.virtualenvs
export PROJECT_HOME=/vagrant
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
EOF

source ${BENV_VAGRANT_HOME}/.bashrc

echo "==> Create default virtualenv ubuntu-dev"
su -l $BENV_VAGRANT_USER -c \
    "source /usr/share/virtualenvwrapper/virtualenvwrapper.sh; mkvirtualenv --system-site-packages ${BENV_VIRTUALENV_NAME}"

cat >>"${BENV_VAGRANT_HOME}/.bashrc" <<EOF
# Activate default virtualenv automatically.
workon ${BENV_VIRTUALENV_NAME}

EOF

cat >>"${BENV_VAGRANT_HOME}/.my.cnf" <<EOF
[mysql]
user=${BENV_VAGRANT_USER}
password='${BENV_VAGRANT_PWD}'
EOF

cat >>"${BENV_VAGRANT_HOME}/.bash_aliases" <<EOF
# Want fancy MariaDB client prompt.
alias mysql=\$(echo -e 'mysql --prompt="\033[01;32m\\u\033[01;37m@\033[01;32m\\h\033[01;37m:\033[01;33m\\d\033[01;34m>\033[00m\\_"')
EOF

cd $BENV_VAGRANT_HOME
chown $BENV_VAGRANT_USER:$BENV_VAGRANT_USER .my.cnf .bash_aliases .vimrc
cd -

