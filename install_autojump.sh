#!/bin/bash

#=======================================================================================
# Script Name: install_autojump.sh
# Description: Automated package installer for autojump
# Author: Gabriel Marais
# Maintainer: Gabriel Marais
# Email: gabriel@linuxshell.co.za
# Created: 2025-02-16
# Last Modified: 2025-02-16
#
# Version: 1.0.0
# Github Repo : https://github.com/wting/autojump
# 
# Source Repository: https://github.com/linuxshell-co-za/
# Source Location: /install_scripts/install_autojump.sh
#
# Dependencies:
#   - Python 3
#   - sudo privileges
#
# Usage: ./install_autojump.sh
#
# Notes:
#   - Tested on LMDE 6
#
# Exit Codes:
#   0 - Success
#   1 - Installation failed
#   2 - Missing dependencies
#   3 - Insufficient permissions
#
# Changelog:
#   v1.0.0 - 2025-02-16
#     - Initial release
#     - Added color-coded output
#     - Added error handling
#
# License: Creative Commons Legal Code - CC0 1.0 Universal
#
#=======================================================================================

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print error and exit
error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Function to print success
print_success() {
    echo -e "${GREEN}$1${NC}"
}

# Function to print info
print_info() {
    echo -e "${BLUE}$1${NC}"
}

# Main installation
print_info "Starting autojump installation..."

# Clone repository
if ! git clone https://github.com/wting/autojump.git; then
    error_exit "Failed to clone repository"
fi

# Change directory
cd autojump/ || error_exit "Failed to enter autojump directory"

# Run installer
print_info "Running installer..."
if ! ./install.py; then
    error_exit "Installation script failed"
fi

# Add to bashrc
AUTOJUMP_CONFIG="[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh"
if ! echo "$AUTOJUMP_CONFIG" >> ~/.bashrc; then
    error_exit "Failed to update .bashrc"
fi

# Clean up
cd .. || error_exit "Failed to return to parent directory"
rm -rf autojump/

print_success "Installation completed successfully!"
print_info "Please restart your terminal or run 'source ~/.bashrc' to start using autojump"
