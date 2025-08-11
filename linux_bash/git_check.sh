#!/bin/bash

# repo : https://github.com/openmarmot/tech-notes/tree/main/linux_bash
# notes : checks all the folders in the directory where you put your git stuff
# and lets you know which ones need a commit or push

# Loop through each directory in the current directory
for dir in */; do
    # Remove trailing slash and check if it's a directory
    dir=${dir%/}
    if [ -d "$dir" ]; then
        # Check if directory contains a .git folder
        if [ -d "$dir/.git" ]; then
            
            # Change to the directory
            cd "$dir" || continue
            
            # Check for uncommitted changes
            if git status --porcelain | grep -q .; then
                status="Has uncommitted changes"
            else
                # Check for unpushed commits
                if git log origin/$(git rev-parse --abbrev-ref HEAD)..HEAD | grep -q .; then
                    status="Needs push to origin"
                else
                    status="Up to date"
                fi
            fi
            
            # Return to original directory
            cd - >/dev/null
        else
            status="Not a git repository"
        fi
        
        # Print status
        printf "%-30s : %s\n" "$dir" "$status"
    fi
done