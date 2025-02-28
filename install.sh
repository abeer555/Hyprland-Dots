#!/bin/bash
# https://github.com/abeer555
# Function to print colored text
print_color() {
    local color="$1"
    local message="$2"
    tput setaf "$color"
    echo -e "$message"
    tput sgr0
}

# Function to print colored text without newline
print_color_nonl() {
    local color="$1"
    local message="$2"
    tput setaf "$color"
    echo -n "$message"
    tput sgr0
}

# Function to print newlines
print_newlines() {
    local count="$1"
    printf "\n%.0s" $(seq 1 "$count")
}

# Display important note
print_color 3 "IMPORTANT NOTE:"
print_color 3 "This script copies the Waybar configuration files and creates backups of your existing files."
print_color 3 "If you want to copy other configuration files, you will need to do so manually."
print_newlines 2

# Define source and destination directories
WAYBAR_CONFIG_SRC="./waybar/configs"
WAYBAR_STYLE_SRC="./waybar/style"
WAYBAR_CONFIG_DEST="$HOME/.config/waybar/configs"
WAYBAR_STYLE_DEST="$HOME/.config/waybar/style"
BACKUP_DIR="$HOME/.config/waybar/backup_$(date +%Y%m%d_%H%M%S)"

# Function to create backup
create_backup() {
    local dir="$1"
    local backup_dest="$BACKUP_DIR/$(basename "$dir")"
    
    if [ -d "$dir" ]; then
        print_color 6 "Creating backup of $dir..."
        mkdir -p "$backup_dest"
        cp -r "$dir"/* "$backup_dest"
        if [ $? -eq 0 ]; then
            print_color 2 "Backup created successfully at $backup_dest"
        else
            print_color 1 "Error: Failed to create backup of $dir"
            return 1
        fi
    else
        print_color 3 "No existing directory to backup at $dir"
    fi
}

# Function to copy files and check for errors
copy_files() {
    local src="$1"
    local dest="$2"
    
    if [ ! -d "$src" ]; then
        print_color 1 "Error: Source directory $src does not exist."
        return 1
    fi
    
    if [ ! -d "$dest" ]; then
        print_color 3 "Creating destination directory: $dest"
        mkdir -p "$dest"
    fi
    
    cp -r "$src"/* "$dest"
    if [ $? -eq 0 ]; then
        print_color 2 "Successfully copied files from $src to $dest"
    else
        print_color 1 "Error: Failed to copy files from $src to $dest"
        return 1
    fi
}

# Create backup directory
mkdir -p "$BACKUP_DIR"
print_color 6 "Creating backup directory at $BACKUP_DIR"

# Create backups of existing Waybar files
create_backup "$WAYBAR_CONFIG_DEST"
create_backup "$WAYBAR_STYLE_DEST"

# Copy Waybar config files
print_color 6 "Copying Waybar config files..."
copy_files "$WAYBAR_CONFIG_SRC" "$WAYBAR_CONFIG_DEST"

# Copy Waybar style files
print_color 6 "Copying Waybar style files..."
copy_files "$WAYBAR_STYLE_SRC" "$WAYBAR_STYLE_DEST"

print_color 2 "Installation completed successfully!"
print_newlines 2

# Add end message about changing Waybar layout and style
print_color 3 "IMPORTANT:"
print_color 3 "To complete the setup, please change the following:"
print_color 4 "1. Waybar layout: Set to '[BOT] KDE' (ALT+SUPER+B)"
print_color 4 "2. Waybar style: Set to '[Coloured] Translucent Alt' (CTRL+SUPER+B)"
print_color 3 "This dotfiles also contains hyprland config, rofi, kitty, ags. You can copy them manually."
print_newlines 2
print_newlines 1