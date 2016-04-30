#!/bin/bash

source /etc/jelastic/environment;
export JAVA_HOME="/usr/java/default/";

#$J_OPENSHIFT_APP_ADM_USER        ;   Operate this variable for the username
#$J_OPENSHIFT_APP_ADM_PASSWORD    ;   Use this varible for your password

function _setPassword() {
        sed -i '/^admin=/d' ${CARTRIDGE_HOME}/versions/${Version}/standalone/configuration/mgmt-users.properties;
        pass_hash=`echo -n ${J_OPENSHIFT_APP_ADM_USER}:ManagementRealm:${J_OPENSHIFT_APP_ADM_PASSWORD}|md5sum|awk '{print $1}'`;
        echo " " >> ${CARTRIDGE_HOME}/versions/${Version}/standalone/configuration/mgmt-users.properties;
        echo ${J_OPENSHIFT_APP_ADM_USER}=${pass_hash} >> ${CARTRIDGE_HOME}/versions/${Version}/standalone/configuration/mgmt-users.properties;
        sed -i '/^ $/d' ${CARTRIDGE_HOME}/versions/${Version}/standalone/configuration/mgmt-users.properties;
}
