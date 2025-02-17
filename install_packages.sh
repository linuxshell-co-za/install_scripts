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

# Define colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
LIGHT_CYAN='\e[96m'
NC='\e[0m' # No Color (reset)

# Function to install selected packages
install_packages() {
    sudo apt install -y "$@"
}

# File Managers
file_managers=("thunar" "pcmanfm" "krusader" "nautilus" "nemo" "dolphin" "ranger" "nnn" "lf")

echo -e "${BLUE}Choose File Managers to install (space-separated list, e.g., 1 3 5):${NC}"
for i in "${!file_managers[@]}"; do
    echo -e "${CYAN}$((i+1)). ${file_managers[i]}${NC}"
done
read -rp "Selection: " file_manager_selection

selected_file_managers=()
for index in $file_manager_selection; do
    selected_file_managers+=("${file_managers[index-1]}")
done

# Graphics
graphics=("gimp" "flameshot" "eog" "sxiv" "qimgv" "inkscape" "scrot")

echo -e "${GREEN}Choose graphics applications to install (space-separated list, e.g., 1 3 5):${NC}"
for i in "${!graphics[@]}"; do
    echo -e "${CYAN}$((i+1)). ${graphics[i]}${NC}"
done
read -rp "Selection: " graphics_selection

selected_graphics=()
for index in $graphics_selection; do
    selected_graphics+=("${graphics[index-1]}")
done

# Terminals
terminals=("alacritty" "gnome-terminal" "kitty" "konsole" "terminator" "xfce4-terminal" )

echo -e "${MAGENTA}Choose Terminals to install (space-separated list, e.g., 1 3):${NC}"
for i in "${!terminals[@]}"; do
    echo -e "${CYAN}$((i+1)). ${terminals[i]}${NC}"
done
read -rp "Selection: " terminal_selection

selected_terminals=()
for index in $terminal_selection; do
    selected_terminals+=("${terminals[index-1]}")
done

# Text Editors
text_editors=("geany" "kate" "gedit" "l3afpad" "mousepad" "pluma")

echo -e "${YELLOW}Choose Text Editors to install (space-separated list, e.g., 1 3 5):${NC}"
for i in "${!text_editors[@]}"; do
    echo -e "${CYAN}$((i+1)). ${text_editors[i]}${NC}"
done
read -rp "Selection: " text_editor_selection

selected_text_editors=()
for index in $text_editor_selection; do
    selected_text_editors+=("${text_editors[index-1]}")
done

# Multimedia
multimedia=("mpv" "vlc" "audacity" "kdenlive" "obs-studio" "rhythmbox" "ncmpcpp" "mkvtoolnix-gui")

echo -e "${RED}Choose Multimedia applications to install (space-separated list, e.g., 1 3 5):${NC}"
for i in "${!multimedia[@]}"; do
    echo -e "${CYAN}$((i+1)). ${multimedia[i]}${NC}"
done
read -rp "Selection: " multimedia_selection

selected_multimedia=()
for index in $multimedia_selection; do
    selected_multimedia+=("${multimedia[index-1]}")
done

# utilities
utilities=( "gparted" "gnome-disk-utility" "neofetch" "nitrogen" "numlockx" "galculator" "cpu-x" "udns-utils" "whois" "curl" "tree" "btop" "htop" "bat" "brightnessctl" "redshift" ) 

echo -e "${LIGHT_CYAN}Choose utilities applications to install (space-separated list, e.g., 1 3 5):${NC}"
for i in "${!utilities[@]}"; do
    echo -e "${CYAN}$((i+1)). ${utilities[i]}${NC}"
done
read -rp "Selection: " utilities_selection

selected_utilities=()
for index in $utilities_selection; do
    selected_utilities+=("${utilities[index-1]}")
done

# Install selected packages
install_packages "${selected_file_managers[@]}" "${selected_graphics[@]}" "${selected_terminals[@]}" "${selected_text_editors[@]}" "${selected_multimedia[@]}" "${selected_utilities[@]}"
