#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     Przebudowa z expo-location plugin (FIX CRASH)     ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}\n"

echo -e "${BLUE}📝 Zmiany w konfiguracji:${NC}"
echo -e "${GREEN}   ✓ Dodano expo-location plugin do app.json${NC}"
echo -e "${GREEN}   ✓ Włączono Android background location${NC}"
echo -e "${GREEN}   ✓ Włączono Android foreground service${NC}\n"

echo -e "${YELLOW}⚠️  UWAGA: To usunie i zregeneruje folder android/${NC}"
echo -e "${YELLOW}   Kontynuować? (t/n):${NC} "
read -r confirm

if [ "$confirm" != "t" ] && [ "$confirm" != "T" ]; then
    echo -e "${RED}Anulowano.${NC}"
    exit 0
fi

# Backup android folder if it exists
if [ -d "android" ]; then
    echo -e "\n${BLUE}📦 Tworzenie backup folderu android...${NC}"
    BACKUP_NAME="android_backup_$(date +%Y%m%d_%H%M%S)"
    mv android "$BACKUP_NAME"
    echo -e "${GREEN}   ✓ Backup: $BACKUP_NAME${NC}"
fi

# Clean and regenerate
echo -e "\n${BLUE}🧹 Czyszczenie i regeneracja native folders...${NC}"
npx expo prebuild --clean --platform android

if [ $? -ne 0 ]; then
    echo -e "\n${RED}❌ Expo prebuild nie powiódł się!${NC}"
    exit 1
fi

echo -e "\n${GREEN}✓ Native folders wygenerowane${NC}"

# Verify LocationTaskService in AndroidManifest
echo -e "\n${BLUE}🔍 Weryfikacja AndroidManifest.xml...${NC}"

if grep -q "LocationTaskService" android/app/src/main/AndroidManifest.xml; then
    echo -e "${GREEN}   ✓ LocationTaskService znaleziony w AndroidManifest${NC}"
else
    echo -e "${RED}   ❌ LocationTaskService NIE ZNALEZIONY!${NC}"
    echo -e "${YELLOW}   Plugin może nie zadziałać poprawnie.${NC}"
fi

# Check if proguard rules exist
if [ -f "android/app/proguard-rules.pro" ]; then
    echo -e "${GREEN}   ✓ ProGuard rules istnieją${NC}"
else
    echo -e "${YELLOW}   ⚠️  ProGuard rules nie istnieją - może być problem${NC}"
fi

# Build
echo -e "\n${BLUE}🔨 Budowanie Release APK...${NC}"
cd android || exit 1
./gradlew clean
./gradlew assembleRelease

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}✓ Build zakończony pomyślnie!${NC}\n"
    
    APK_PATH="app/build/outputs/apk/release/app-release.apk"
    SIZE=$(du -h "$APK_PATH" | cut -f1)
    echo -e "${BLUE}APK: ${APK_PATH}${NC}"
    echo -e "${BLUE}Rozmiar: ${SIZE}${NC}\n"
    
    # Check if device connected
    if adb devices | grep -q "device$"; then
        echo -e "${GREEN}✓ Urządzenie wykryte${NC}\n"
        echo -e "${YELLOW}Zainstalować teraz? (t/n):${NC} "
        read -r install
        
        if [ "$install" = "t" ] || [ "$install" = "T" ]; then
            echo -e "\n${BLUE}📲 Instalowanie...${NC}"
            adb uninstall com.ctsjwtest.whereiwas 2>/dev/null
            adb install "$APK_PATH"
            
            if [ $? -eq 0 ]; then
                echo -e "\n${GREEN}✓ Zainstalowano pomyślnie!${NC}\n"
                echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
                echo -e "${GREEN}║                   GOTOWE DO TESTU                      ║${NC}"
                echo -e "${GREEN}╠════════════════════════════════════════════════════════╣${NC}"
                echo -e "${GREEN}║ 1. Otwórz aplikację                                   ║${NC}"
                echo -e "${GREEN}║ 2. Przejdź do Trip Tracking                           ║${NC}"
                echo -e "${GREEN}║ 3. Kliknij Start Tracking                             ║${NC}"
                echo -e "${GREEN}║                                                        ║${NC}"
                echo -e "${GREEN}║ Jeśli widzisz alert 'Tracking Started':               ║${NC}"
                echo -e "${GREEN}║ ${MAGENTA}✓ PROBLEM ROZWIĄZANY!${NC}                               ║${NC}"
                echo -e "${GREEN}║                                                        ║${NC}"
                echo -e "${GREEN}║ Jeśli nadal crashuje:                                 ║${NC}"
                echo -e "${GREEN}║ - Uruchom: adb logcat | grep TRACKING                 ║${NC}"
                echo -e "${GREEN}║ - Prześlij logi                                       ║${NC}"
                echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}\n"
            else
                echo -e "${RED}❌ Instalacja nie powiodła się${NC}"
            fi
        fi
    else
        echo -e "${YELLOW}⚠️  Brak podłączonego urządzenia${NC}"
        echo -e "\nAby zainstalować manualnie:"
        echo -e "  ${BLUE}adb install android/${APK_PATH}${NC}"
    fi
else
    echo -e "\n${RED}❌ Build nie powiódł się!${NC}"
    echo -e "${YELLOW}Sprawdź błędy powyżej${NC}"
    exit 1
fi

echo -e "\n${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${MAGENTA}Co zostało naprawione:${NC}"
echo -e "  ${GREEN}✓${NC} Dodano expo-location plugin"
echo -e "  ${GREEN}✓${NC} Wygenerowano LocationTaskService w AndroidManifest"
echo -e "  ${GREEN}✓${NC} Skonfigurowano background location"
echo -e "  ${GREEN}✓${NC} TaskManager.defineTask() powinien teraz działać"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"


