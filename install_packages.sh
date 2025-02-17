#!/bin/bash

#=======================================================================================
# Script Name: install_packages.sh
# Description: Automated package installer
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
# Source Location: /install_scripts/install_packages.sh
#
# Dependencies:
#   - apt (package manager)
#   - sudo privileges
#
# Usage: ./install_packages.sh
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
#     - Added color-coded output
#     - Added error handling
#
# License: Creative Commons Legal Code - CC0 1.0 Universal
#
#=======================================================================================

# Colors for text formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to install selected packages
install_packages() {
    echo -e "${GREEN}Installing selected packages...${NC}"
    sudo apt update && sudo apt install -y "$@"
}

# Function to display menu and get selection
display_menu() {
    local options=("$@")
    for i in "${!options[@]}"; do
        echo -e "${YELLOW}  $((i + 1)). ${options[i]}${NC}"
    done
    echo ""
    read -rp "Enter the numbers of your choices (space-separated): " selection
    echo "$selection"
}

# Function to convert user selection into package list
get_selected_packages() {
    local selection=($1) # User's selection (space-separated indices)
    local options=("${!2}") # Reference to the list of options
    local selected_items=()
    for index in "${selection[@]}"; do
        # Ensure valid index (e.g., user didn't enter an invalid number)
        if [[ $index -gt 0 && $index -le ${#options[@]} ]]; then
            selected_items+=("${options[index-1]}")
        fi
    done
    echo "${selected_items[@]}"
}

# File Managers
file_managers=("thunar" "pcmanfm" "krusader" "nautilus" "nemo" "dolphin" "ranger" "nnn" "lf")
echo -e "${CYAN}Choose File Managers to install:${NC}"
file_manager_selection=$(display_menu "${file_managers[@]}")
selected_file_managers=($(get_selected_packages "$file_manager_selection" file_managers[@]))

# Graphics
graphics=("gimp" "flameshot" "eog" "sxiv" "qimgv" "inkscape" "scrot")
echo -e "${CYAN}Choose Graphics Applications to install:${NC}"
graphics_selection=$(display_menu "${graphics[@]}")
selected_graphics=($(get_selected_packages "$graphics_selection" graphics[@]))

# Terminals
terminals=("alacritty" "gnome-terminal" "kitty" "konsole" "terminator" "xfce4-terminal")
echo -e "${CYAN}Choose Terminals to install:${NC}"
terminal_selection=$(display_menu "${terminals[@]}")
selected_terminals=($(get_selected_packages "$terminal_selection" terminals[@]))

# Text Editors
text_editors=("geany" "kate" "gedit" "l3afpad" "mousepad" "pluma")
echo -e "${CYAN}Choose Text Editors to install:${NC}"
text_editor_selection=$(display_menu "${text_editors[@]}")
selected_text_editors=($(get_selected_packages "$text_editor_selection" text_editors[@]))

# Multimedia
multimedia=("mpv" "vlc" "audacity" "kdenlive" "obs-studio" "rhythmbox" "ncmpcpp" "mkvtoolnix-gui")
echo -e "${CYAN}Choose Multimedia Applications to install:${NC}"
multimedia_selection=$(display_menu "${multimedia[@]}")
selected_multimedia=($(get_selected_packages "$multimedia_selection" multimedia[@]))

# Utilities
utilities=("gparted" "gnome-disk-utility" "neofetch" "nitrogen" "numlockx" "galculator" "cpu-x" "udns-utils" "whois" "curl" "tree" "btop" "htop" "bat" "brightnessctl" "redshift" "nettools")
echo -e "${CYAN}Choose Utilities Applications to install:${NC}"
utilities_selection=$(display_menu "${utilities[@]}")
selected_utilities=($(get_selected_packages "$utilities_selection" utilities[@]))

# Print summary of selections
echo -e "${GREEN}You have selected the following packages to install:${NC}"
echo -e "${CYAN}File Managers:${NC} ${selected_file_managers[*]}"
echo -e "${CYAN}Graphics Applications:${NC} ${selected_graphics[*]}"
echo -e "${CYAN}Terminals:${NC} ${selected_terminals[*]}"
echo -e "${CYAN}Text Editors:${NC} ${selected_text_edit
