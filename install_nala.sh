#!/bin/bash

#!/bin/bash

#=======================================================================================
# Script Name: install_nala.sh
# Description: Install nala as a replacement for apt
# Author: Gabriel Marais
# Maintainer: Gabriel Marais
# Email: gabriel@linuxshell.co.za
# Created: 2025-02-17
# Last Modified: 2025-02-17
#
# Version: 1.0.0
# 
# Source Repository: https://github.com/linuxshell-co-za/
# Source Location: /install_scripts/install_nala.sh
#
# Dependencies:
#   - apt (package manager)
#   - sudo privileges
#
# Usage: ./install_nala.sh
#
# Notes:
#   - Requires root/sudo privileges for installation
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
#
# License: Creative Commons Legal Code - CC0 1.0 Universal
#
#=======================================================================================


# Ask user if they want to install nala
read -p "Would you like to install nala? (y/n): " answer

# Convert answer to lowercase
answer=${answer,,}

# Check the answer
if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
    echo "Installing nala..."
    sudo apt install nala
    echo "Fetching fastest mirrors..."
    sudo nala fetch
    echo "Installation complete!"
else
    echo "Installation cancelled. Exiting..."
    exit 0
fi



