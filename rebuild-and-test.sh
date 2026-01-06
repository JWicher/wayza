#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Rebuilding and Testing Production APK ===${NC}\n"

# Navigate to android directory
cd "0-android" || exit 1

# Clean previous builds
echo -e "${YELLOW}Cleaning previous builds...${NC}"
./gradlew clean

# Build release APK
echo -e "${YELLOW}Building release APK...${NC}"
./gradlew assembleRelease

# Check if build was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Build successful!${NC}\n"
    
    # Check if device is connected
    if adb devices | grep -q "device$"; then
        echo -e "${YELLOW}Device detected. Installing APK...${NC}"
        adb install -r app/build/outputs/apk/release/app-release.apk
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}APK installed successfully!${NC}\n"
            
            # Clear old logs
            echo -e "${YELLOW}Clearing old logs...${NC}"
            adb logcat -c
            
            echo -e "${GREEN}Ready to test!${NC}"
            echo -e "${YELLOW}Now:${NC}"
            echo "1. Open the app on your device"
            echo "2. Click 'tracking'"
            echo -e "3. Watch the logs below for any errors\n"
            
            echo -e "${YELLOW}Monitoring logs (press Ctrl+C to stop):${NC}\n"
            
            # Monitor logs
            adb logcat | grep --line-buffered -i "whereiwas\|AndroidRuntime\|FATAL\|SQLite\|expo"
        else
            echo -e "${RED}Failed to install APK${NC}"
            exit 1
        fi
    else
        echo -e "${RED}No device connected!${NC}"
        echo "Please connect your device via USB and enable USB debugging"
        echo -e "\nAPK location: ${YELLOW}0-android/app/build/outputs/apk/release/app-release.apk${NC}"
        exit 1
    fi
else
    echo -e "${RED}Build failed! Check the errors above.${NC}"
    exit 1
fi

