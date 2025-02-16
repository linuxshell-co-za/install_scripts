#!/bin/bash

#=======================================================================================
# Script Name: ghostty_installer.sh
# Description: Automated installer for Ghostty terminal emulator and its dependencies
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
# Source Location: /install_scripts/install_ghostty.sh
#
# Dependencies:
#   - apt (package manager)
#   - wget
#   - git
#   - sudo privileges
#
# Usage: ./install_ghostty.sh
#
# Notes:
#   - Requires root/sudo privileges for installation
#   - Tested on LMDE 6
#   - Installs Zig version 0.13.0 or higher if not present
#   - Creates temporary directory for build process
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
#     - Added version checking for Zig
#
# License: Creative Commons Legal Code - CC0 1.0 Universal
#
#=======================================================================================


# Set up error handling
set -e

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function for logging
log() {
    local level=$1
    shift
    case $level in
        "INFO") echo -e "${BLUE}[INFO]${NC} $*" ;;
        "SUCCESS") echo -e "${GREEN}[SUCCESS]${NC} $*" ;;
        "WARNING") echo -e "${YELLOW}[WARNING]${NC} $*" ;;
        "ERROR") echo -e "${RED}[ERROR]${NC} $*" ;;
    esac
}

# Dependencies
log "INFO" "Installing dependencies..."
sudo apt update
sudo apt install -y libgtk-4-dev libadwaita-1-dev git

# Create a temporary directory for the build
TMP_DIR=$(mktemp -d)
log "INFO" "Using temporary directory: $TMP_DIR"

# Check if Zig is installed and the version is 0.13.0 or higher
ZIG_REQUIRED_VERSION="0.13.0"
ZIG_BINARY="/usr/local/bin/zig"

check_zig_version() {
    local installed_version
    installed_version=$(zig version 2>/dev/null || echo "0.0.0")
    if [ "$(printf '%s\n' "$ZIG_REQUIRED_VERSION" "$installed_version" | sort -V | head -n1)" == "$ZIG_REQUIRED_VERSION" ]; then
        return 0
    else
        return 1
    fi
}

if command -v zig &> /dev/null && check_zig_version; then
    log "SUCCESS" "Zig $ZIG_REQUIRED_VERSION or higher is already installed. Skipping installation."
else
    log "INFO" "Downloading and installing Zig $ZIG_REQUIRED_VERSION..."
    ZIG_URL="https://ziglang.org/download/$ZIG_REQUIRED_VERSION/zig-linux-x86_64-$ZIG_REQUIRED_VERSION.tar.xz"
    cd "$TMP_DIR"
    wget "$ZIG_URL"
    tar -xf "zig-linux-x86_64-$ZIG_REQUIRED_VERSION.tar.xz"
    sudo mv "zig-linux-x86_64-$ZIG_REQUIRED_VERSION" /usr/local/zig
    sudo ln -sf /usr/local/zig/zig /usr/local/bin/zig
    log "SUCCESS" "Zig $ZIG_REQUIRED_VERSION installed successfully."
fi

# Verify Zig installation
log "INFO" "Checking Zig version..."
zig version || { log "ERROR" "Zig installation failed!"; exit 1; }

# Check if Ghostty is installed
if command -v ghostty &> /dev/null; then
    log "SUCCESS" "Ghostty is already installed. Skipping installation."
else
    log "INFO" "Cloning and building Ghostty..."
    git clone https://github.com/ghostty-org/ghostty
    cd ghostty
    sudo zig build -p /usr -Doptimize=ReleaseFast
    log "SUCCESS" "Ghostty installed successfully."
fi

# Clean up temporary files
log "INFO" "Cleaning up temporary files..."
if [[ -d "$TMP_DIR" ]]; then
    sudo rm -rf "$TMP_DIR"
    log "SUCCESS" "Temporary files removed."
else
    log "WARNING" "No temporary files to remove."
fi

log "SUCCESS" "Installation process completed successfully!"

