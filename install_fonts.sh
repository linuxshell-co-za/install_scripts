#!/bin/bash

#=======================================================================================
# Script Name: install_fonts.sh
# Description: Automated installer for fonts
# Author: Gabriel Marais
# Maintainer: Gabriel Marais
# Email: gabriel@linuxshell.co.za
# Created: 2025-02-16
# Last Modified: 2025-02-16
#
# Version: 1.0.0
# Credit goes to Drew - JustAGuyLinux - https://justaguylinux.com/
# 
# Source Repository: https://github.com/linuxshell-co-za/
# Source Location: /install_scripts/install_fonts.sh
#
# Dependencies:
#   - apt (package manager)
#   - unzip
#   - wget
#   - sudo privileges
#
# Usage: ./install_fonts.sh
#
# Notes:
#   - Requires root/sudo privileges for installation
#   - Tested on LMDE 6
#   - Installs fonts in ~/.local/share/fonts/
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


# Define ANSI color codes
RED='\033[0;31m'     # Red for errors
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[0;33m'  # Yellow for warnings/info
BLUE='\033[0;34m'    # Blue for process information
NC='\033[0m'         # Reset/No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if 'unzip' is installed; if not, install it
if ! command_exists unzip; then
    echo -e "${YELLOW}Installing 'unzip'...${NC}"
    sudo apt install unzip -y
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}'unzip' installation successful!${NC}"
    else
        echo -e "${RED}'unzip' installation failed. Please install it manually.${NC}"
        exit 1
    fi
else
    echo -e "${BLUE}'unzip' is already installed. Proceeding...${NC}"
fi

# Create directory for fonts if it doesn't already exist
mkdir -p ~/.local/share/fonts
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Font directory created or already exists.${NC}"
else
    echo -e "${RED}Failed to create font directory. Exiting.${NC}"
    exit 1
fi

# Array of font names
fonts=(
    "CascadiaCode"
    "FiraCode"
    "Hack"
    "Inconsolata"
    "JetBrainsMono"
    "Meslo"
    "Mononoki"
    "RobotoMono"
    "SourceCodePro"
    "UbuntuMono"
    # Add additional fonts here if needed
)

# Function to check if font folder exists
check_font_installed() {
    local font_name=$1
    if [ -d ~/.local/share/fonts/$font_name ]; then
        return 0  # Font already installed
    else
        return 1  # Font not installed
    fi
}

# Loop through each font, check if it's installed, and install if not
for font in "${fonts[@]}"; do
    if check_font_installed "$font"; then
        echo -e "${YELLOW}Font $font is already installed. Skipping.${NC}"
        continue  # Skip installation if font is already installed
    fi

    echo -e "${BLUE}Installing font: $font${NC}"
    wget -q --show-progress "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$font.zip" -P /tmp
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to download font: $font${NC}"
        continue
    fi

    unzip -q /tmp/$font.zip -d ~/.local/share/fonts/$font/
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to extract font: $font. Skipping.${NC}"
        rm /tmp/$font.zip
        continue
    fi

    rm /tmp/$font.zip
    echo -e "${GREEN}Successfully installed font: $font${NC}"
done

# Update font cache
echo -e "${BLUE}Updating font cache...${NC}"
fc-cache -f
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Font cache updated successfully.${NC}"
else
    echo -e "${RED}Failed to update font cache. Please run 'fc-cache -f' manually.${NC}"
fi

echo -e "${GREEN}Font installation process completed!${NC}"

