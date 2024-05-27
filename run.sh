#!/bin/zsh
GREEN='\033[0;32m'
NC='\033[0m' # No Color
SCRIPT_DIR=$(dirname "$(realpath "$0")")
echo "alias thycotic=$SCRIPT_DIR/generate-ssh-proxy.sh" >> ~/.zshrc
# shellcheck disable=SC1090
source ~/.zshrc
echo -e "${GREEN}thycotic is installed successfully${NC}"
