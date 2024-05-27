#!/bin/zsh
SCRIPT_DIR=$(dirname "$(realpath "$0")")
echo "alias thycotic=$SCRIPT_DIR/generate-ssh-proxy.sh" >> ~/.zshrc
