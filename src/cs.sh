#!/bin/bash

# Calculate the CWD:
CWD="`dirname \"$0\"`"
CWD="`( cd \"$CWD\" && cd .. && pwd )`"

# Load the environment variables:
set -o allexport
source "${CWD}/.env"
set +o allexport

# Prepare the logs file
touch ${CODE_SERVER_LOGS}/cs.log

# Collect main command from first argument,
# or present a graphic menu to the user
if [ -n "${1}" ]
then
    CMD=${1}
else
    PS3='Please enter your choice: '
    options=("Start IDE" "Stop IDE" "IDE Status" "IDE Logs" "Change password" "Update DNS entries on CloudFlare" "Update Code Server IDE" "Cancel")
    select opt in "${options[@]}"
    do
        case $opt in
            "Start IDE")
                CMD=start
                break
                ;;
            "Stop IDE")
                CMD=stop
                break
                ;;
            "IDE Status")
                CMD=status
                break
                ;;
            "IDE Logs")
                CMD=logs
                break
                ;;
            "Change password")
                CMD=pwd
                break
                ;;
            "Update DNS entries on CloudFlare")
                CMD=dns
                break
                ;;
            "Update Code Server IDE")
                CMD=update
                break
                ;;
            "Cancel")
                CMD=cancel
                break
                ;;
        esac
    done
fi

case ${CMD} in
    "pwd")
        ${CODE_SERVER_CWD}/src/cs-pwd.sh ${@:2}
        ;;
    "dns")
        ${CODE_SERVER_CWD}/src/cs-dns.sh ${@:2}
        ;;
    "start")
        sudo systemctl start code-server-ide
        docker-compose -f ${CODE_SERVER_CWD}/docker-compose.yml up -d
        ;;
    "stop")
        sudo systemctl stop code-server-ide
        docker-compose -f ${CODE_SERVER_CWD}/docker-compose.yml down
        ;;
    "status")
        sudo systemctl status code-server-ide
        ;;
    "logs")
        (cd ${CODE_SERVER_CWD} && humble logs -f ${@:2})
        ;;
    "dns")
        ${CODE_SERVER_CWD}/src/cs-dns.sh ${@:2}
        ;;
    "update")
        (cs ${CODE_SERVER_CWD} && git pull)
        ;;
    "cancel")
        echo "Goobye."
        exit
        ;;
    *) echo "invalid option";;
esac
