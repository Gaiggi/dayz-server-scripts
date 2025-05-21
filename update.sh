#!/bin/bash

# Define variables for directories
SERVER_DIR="/home/user/servers/dayz-server"
STEAMCMD_DIR="/home/user/servers/steamcmd"

# Change directory to the DayZ server
cd "$SERVER_DIR" || { echo "Failed to change directory to $SERVER_DIR"; exit 1; }

# Download all workshop items using SteamCMD
"$STEAMCMD_DIR/steamcmd.sh" \
+force_install_dir "$SERVER_DIR" \
+login user \
+app_update 223350 \
+workshop_download_item 221100 2545327648 \
+workshop_download_item 221100 1559212036 \
+workshop_download_item 221100 1828439124 \
+quit

# List of mod IDs to remove and recreate symlinks
mod_ids=(1559212036 2545327648 1828439124)

# Remove existing mod folders and recreate symlinks
for mod_id in "${mod_ids[@]}"; do
    # Remove existing mod folder
    rm -rf "$SERVER_DIR/$mod_id" || { echo "Error removing mod folder $mod_id"; exit 1; }

    # Create symlink for new mods
    ln -s "$SERVER_DIR/steamapps/workshop/content/221100/$mod_id" "$SERVER_DIR/$mod_id" || { echo "Error creating symlink for $mod_id"; exit 1; }
done

# Remove all .bikey files from the keys folder
rm -f "$SERVER_DIR/keys/*.bikey" || { echo "Error removing .bikey files"; exit 1; }

# Copy .bikey files from the new mods to the keys folder
for item in "$SERVER_DIR/steamapps/workshop/content/221100/"*; do
    if [ -d "$item" ]; then
        for key_dir in "$item/keys" "$item/Keys" "$item/key" "$item/Key"; do
            if [ -d "$key_dir" ]; then
                cp "$key_dir"/*.bikey "$SERVER_DIR/keys/" || { echo "Error copying .bikey files from $key_dir"; exit 1; }
            fi
        done
    fi
done
