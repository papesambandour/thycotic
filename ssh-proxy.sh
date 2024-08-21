#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
SCRIPT_DIR=$(dirname "$(realpath "$0")")
FILE="$SCRIPT_DIR/thycotic.config"
source "$SCRIPT_DIR/function.sh"
source "$SCRIPT_DIR/modules/validation.sh"

#Load Host module
source "$SCRIPT_DIR/modules/host.sh"

#Load Login module
source "$SCRIPT_DIR/modules/login.sh"



source "$SCRIPT_DIR/modules/get_thycotic_token.sh"
source "$SCRIPT_DIR/modules/get-proy-access.sh"
source "$SCRIPT_DIR/modules/command-ssh.sh"


exit
