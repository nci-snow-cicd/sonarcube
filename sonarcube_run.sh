#!/bin/bash

echo "Starting container : SonarQube 5.1"


# change the password
if [ ! -f /.password ]; then
        echo "Initializing the user password..."

        # generate password
        PASS=${CONTAINER_PASS:-$(date +%s | sha256sum | base64 | head -c 16 ; echo)}
        # change password
    # ---> put code here
    # touch this file ...
        touch /.password

        echo "Initializing the user password : done!"
fi

# display info
echo ""
echo "######################################################################"
echo "You can now connect to this CONTAINER using :"
echo ""
echo "    Username : admin"
if [ ! -d ${PASS} ]; then
        echo "    Password : admin"
else
        echo "    Password : ****************"
fi
echo ""
echo "######################################################################"
echo ""

# start service
exec ${SONAR_HOME}/bin/linux-x86-64/sonar.sh console
