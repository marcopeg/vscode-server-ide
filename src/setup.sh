#!/bin/bash

source "$(dirname "$0")/setup-profile.sh"
source "$(dirname "$0")/setup-folders.sh"
source "$(dirname "$0")/setup-logs.sh"
source "$(dirname "$0")/setup-apt-get.sh"
source "$(dirname "$0")/setup-code-server.sh"
source "$(dirname "$0")/setup-docker.sh"
source "$(dirname "$0")/setup-traefik.sh"
source "$(dirname "$0")/setup-env.sh"
source "$(dirname "$0")/setup-htaccess.sh"
source "$(dirname "$0")/setup-rsa.sh"
source "$(dirname "$0")/setup-bashrc.sh"
source "$(dirname "$0")/setup-docker-compose.sh"
source "$(dirname "$0")/setup-scripts.sh"
source "$(dirname "$0")/setup-final.sh"
source "$(dirname "$0")/setup-sendgrid.sh"
reboot
