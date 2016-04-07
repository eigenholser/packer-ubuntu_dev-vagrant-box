# This provisioning script runs after the Vagrant user is fully configured.

set -e

# https://mariadb.com
#
# Setup MariaDB for dev. Very quick and dirty. Only works on fresh install.
#
#   sudo sh mariadb_setup.sh
#

sql_commands=/tmp/mariadb_setup.sql

cat > $sql_commands <<End-Of-SQL
/* MariaDB setup */
UPDATE mysql.user SET Password=PASSWORD('${BENV_VAGRANT_PWD}') WHERE User='root';
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;

/* DB setup */
CREATE DATABASE IF NOT EXISTS $BENV_PROJECT_DATABASE_NAME;
CREATE USER '${BENV_VAGRANT_USER}'@'%' IDENTIFIED BY '${BENV_VAGRANT_PWD}';
GRANT ALL ON ${BENV_PROJECT_DATABASE_NAME}.* TO '${BENV_VAGRANT_USER}'@'%';
FLUSH PRIVILEGES;
End-Of-SQL

echo "==> Setting up the database."
mysql --user root < $sql_commands
rm $sql_commands
