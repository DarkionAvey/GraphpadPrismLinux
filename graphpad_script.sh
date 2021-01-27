[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"


# !!! Only works with the 64-bit version

#Based on this:
#https://raw.githubusercontent.com/corbindavenport/creative-cloud-linux/master/creativecloud.sh
POL_System_SetArch "amd64"

PREFIX="Prism"
WINEVERSION="6.0-staging"
TITLE="Prism8"
EDITOR="Graphpad"
GAME_URL="https://www.graphpad.com/"
AUTHOR="DarkionAvey"

#Initialization

POL_SetupWindow_Init
POL_SetupWindow_SetID 3251

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"


# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select Prism 8 64-bit installation file')"
INSTALLER="$APP_ANSWER"

# Create prefix and temporary download folder
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
POL_System_TmpCreate "PrismCache"
Set_OS "win7"

cd "$POL_System_TmpDir"
POL_Download_Resource  "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
POL_SetupWindow_wait "Please wait while winetricks is installed... (this might take a few minutes)" "$TITLE"
chmod +x winetricks 
./winetricks gdiplus msxml6 corefonts


POL_Wine_WaitBefore "$TITLE"
POL_AutoWine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
  
POL_Shortcut "prism.exe" "Graphpad Prism 8"
POL_System_TmpDelete

# All done
POL_SetupWindow_message "$(eval_gettext 'The installation is now complete')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
