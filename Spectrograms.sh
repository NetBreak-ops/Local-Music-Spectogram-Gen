#!/bin/bash

# Base Music Directory
MUSIC_DIR="$HOME/storage/music"

# Color codes
RED='\033[0;31m'     # Error messages
GREEN='\033[0;32m'   # Success messages
YELLOW='\033[0;33m'  # Folder names
BLUE='\033[0;34m'    # Music file names
NC='\033[0m'         # No color

# Function to generate spectrogram
generate_spectrogram() {
    local file="$1"
    local dir_path
    dir_path=$(dirname "$file")
    local filename
    filename=$(basename -- "$file")
    local filename_noext="${filename%.*}"

    local output_dir="$dir_path/Spectrograms"
    mkdir -p "$output_dir"

    local spectrogram_path="$output_dir/$filename_noext.png"

    echo -e "\n🎵 Processing: ${BLUE}$filename${NC}"

    # Generate spectrogram
    if ! ffmpeg -y -i "$file" -lavfi showspectrumpic=s=3840x2160:legend=1:color=rainbow:scale=log -frames:v 1 -update 1 "$spectrogram_path" &>/dev/null; then
        echo -e "${RED}❌ Error processing: $file${NC}"
    else
        echo -e "${GREEN}✅ Spectrogram saved in: $spectrogram_path${NC}"
    fi
}

# Function for Bulk Mode
bulk_process() {
    local current_dir="$1"

    while true; do
        clear
        echo -e "\n📁 Current Directory: ${YELLOW}$current_dir${NC}"
        echo "--------------------------------------"

        local items=()
        local index=1

        # List folders first
        for dir in "$current_dir"/*/; do
            [ -d "$dir" ] && items+=("$dir")
        done

        # List music files
        for file in "$current_dir"/*.{mp3,aac,m4a,flac,wav,ogg,opus}; do
            [ -e "$file" ] && items+=("$file")
        done

        # Display numbered list
        for item in "${items[@]}"; do
            if [ -d "$item" ]; then
                echo -e "$index) ${YELLOW}$(basename "$item")/${NC}"
            else
                echo -e "$index) ${BLUE}$(basename "$item")${NC}"
            fi
            index=$((index + 1))
        done

        echo -e "P) 📂 Process All Files Here"
        echo -e "B) ⬅️  Go Back"
        echo -e "X) ❌ Exit"

        read -p "Enter choice: " choice

        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#items[@]} )); then
            selected_item="${items[$((choice - 1))]}"
            
            if [ -d "$selected_item" ]; then
                bulk_process "$selected_item"  # Enter folder
            elif [ -f "$selected_item" ]; then
                generate_spectrogram "$selected_item"  # Process file
            fi
        elif [[ "$choice" == "P" || "$choice" == "p" ]]; then
            echo -e "${GREEN}🔄 Processing all files in: $current_dir${NC}"
            for file in "$current_dir"/*.{mp3,aac,m4a,flac,wav,ogg,opus}; do
                [ -e "$file" ] && generate_spectrogram "$file"
            done
        elif [[ "$choice" == "B" || "$choice" == "b" ]]; then
            return 1  # Go back
        elif [[ "$choice" == "X" || "$choice" == "x" ]]; then
            echo "🚪 Exiting script..."
            exit 0
        else
            echo -e "${RED}❌ Invalid selection. Try again.${NC}"
            sleep 1
        fi
    done
}

# Function for One-by-One Mode
one_by_one() {
    local current_dir="$1"

    while true; do
        clear
        echo -e "\n📁 Current Directory: ${YELLOW}$current_dir${NC}"
        echo "--------------------------------------"

        local items=()
        local index=1

        # List folders first
        for dir in "$current_dir"/*/; do
            [ -d "$dir" ] && items+=("$dir")
        done

        # List music files
        for file in "$current_dir"/*.{mp3,aac,m4a,flac,wav,ogg,opus}; do
            [ -e "$file" ] && items+=("$file")
        done

        # Display numbered list
        for item in "${items[@]}"; do
            if [ -d "$item" ]; then
                echo -e "$index) ${YELLOW}$(basename "$item")/${NC}"
            else
                echo -e "$index) ${BLUE}$(basename "$item")${NC}"
            fi
            index=$((index + 1))
        done

        echo -e "B) ⬅️  Go Back"
        echo -e "X) ❌ Exit"

        read -p "Enter choice: " choice

        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#items[@]} )); then
            selected_item="${items[$((choice - 1))]}"
            
            if [ -d "$selected_item" ]; then
                one_by_one "$selected_item"  # Enter folder
            elif [ -f "$selected_item" ]; then
                generate_spectrogram "$selected_item"  # Process file
                read -p "Press Enter to continue..."
            fi
        elif [[ "$choice" == "B" || "$choice" == "b" ]]; then
            return 1  # Go back
        elif [[ "$choice" == "X" || "$choice" == "x" ]]; then
            echo "🚪 Exiting script..."
            exit 0
        else
            echo -e "${RED}❌ Invalid selection. Try again.${NC}"
            sleep 1
        fi
    done
}

# Main Menu
while true; do
    clear
    echo -e "🎵 Select Mode:"
    echo -e "1) 🔹 One-by-One Mode (Select Individual Files)"
    echo -e "2) 🔸 Bulk Mode (Process Entire Folders)"
    echo -e "X) ❌ Exit"

    read -p "Enter choice: " mode_choice

    case "$mode_choice" in
        1) one_by_one "$MUSIC_DIR" ;;
        2) bulk_process "$MUSIC_DIR" ;;
        X|x) echo "🚪 Exiting script..."; exit 0 ;;
        *) echo -e "${RED}❌ Invalid choice. Try again.${NC}"; sleep 1 ;;
    esac
done

