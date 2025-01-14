#!/bin/bash

# Define the state file
TOGGLE_STATE_FILE="/tmp/hypr_toggle_state"

# Check if the file exists, if not create it and set the default state
if [ ! -f "$TOGGLE_STATE_FILE" ]; then
  echo "0" >"$TOGGLE_STATE_FILE"
fi

# Read the current state
STATE=$(cat "$TOGGLE_STATE_FILE")

if [ "$STATE" -eq "0" ]; then
  # Perform action 1 (e.g., movetoworkspacesilent)
  hyprctl dispatch movetoworkspacesilent special:magic
  echo "1" >"$TOGGLE_STATE_FILE"
else
  # Perform action 2 (e.g., reset or another command)
  hyprctl dispatch movetoworkspace 1
  echo "0" >"$TOGGLE_STATE_FILE"
fi
