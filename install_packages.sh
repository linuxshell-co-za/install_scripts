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

# Function to display menu
display_menu() {
    local options=("$@")
    local prompt_message=$1
    shift
    echo -e "${CYAN}$prompt_message${NC}"
    for i in "${!options[@]}"; do
        echo -e "${YELLOW}$((i+1)). ${options[i]}${NC}"
    done
    read -rp "Selection (space-separated): " selection
    echo $selection
}

# Function to collect user's selections
collect_selections() {
    local selection=($1) # List of selected indices
    local options=("${!2}") # Reference to items array
    local selected_items=()
    for index in "${selection[@]}"; do
        selected_items+=("${options[index-1]}")
    done
    echo "${selected_items[@]}"
}

# File Managers
file_managers=("thunar" "pcmanfm" "krusader" "nautilus" "nemo" "dolphin" "ranger" "nnn" "lf")
file_manager_selection=$(display_menu "Choose File Managers to install:" "${file_managers[@]}")
selected_file_managers=($(collect_selections "$file_manager_selection" file_managers[@]))

# Graphics
graphics=("gimp" "flameshot" "eog" "sxiv" "qimgv" "inkscape" "scrot")
graphics_selection=$(display_menu "Choose Graphics Applications to install:" "${graphics[@]}")
selected_graphics=($(collect_selections "$graphics_selection" graphics[@]))

# Terminals
terminals=("alacritty" "gnome-terminal" "kitty" "konsole" "terminator" "xfce4-terminal")
terminal_selection=$(display_menu "Choose Terminals to install:" "${terminals[@]}")
selected_terminals=($(collect_selections "$terminal_selection" terminals[@]))

# Text Editors
text_editors=("geany" "kate" "gedit" "l3afpad" "mousepad" "pluma")
text_editor_selection=$(display_menu "Choose Text Editors to install:" "${text_editors[@]}")
selected_text_editors=($(collect_selections "$text_editor_selection" text_editors[@]))

# Multimedia
multimedia=("mpv" "vlc" "audacity" "kdenlive" "obs-studio" "rhythmbox" "ncmpcpp" "mkvtoolnix-gui")
multimedia_selection=$(display_menu "Choose Multimedia Applications to install:" "${multimedia[@]}")
selected_multimedia=($(collect_selections "$multimedia_selection" multimedia[@]))

# Utilities
utilities=("gparted" "gnome-disk-utility" "neofetch" "nitrogen" "numlockx" "galculator" "cpu-x" "udns-utils" "whois" "curl" "tree" "btop" "htop" "bat" "brightnessctl" "redshift" "nettools")
utilities_selection=$(display_menu "Choose Utilities Applications to install:" "${utilities[@]}")
selected_utilities=($(collect_selections "$utilities_selection" utilities[@]))

# Summary of selections and installation
echo -e "${GREEN}You have selected the following packages to install:${NC}"
echo -e "${CYAN}File Managers:${NC} ${selected_file_managers[*]}"
echo -e "${CYAN}Graphics Applications:${NC} ${selected_graphics[*]}"
echo -e "${CYAN}Terminals:${NC} ${selected_terminals[*]}"
echo -e "${CYAN}Text Editors:${NC} ${selected_text_editors[*]}"
echo -e "${CYAN}Multimedia Applications:${NC} ${selected_multimedia[*]}"
echo -e "${CYAN}Utilities:${NC} ${selected_utilities[*]}"

# Install selected packages
install_packages "${selected_file_managers[@]}" "${selected_graphics[@]}" "${selected_terminals[@]}" "${selected_text_editors[@]}" "${selected_multimedia[@]}" "${selected_utilities[@]}"
