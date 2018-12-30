#!/bin/bash

# ~/.osx — http://mths.be/osx

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Menu bar: disable transparency
#xdefaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

echo "Hiding Time Machine and Volume icons"
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Disable smooth scrolling
# (Uncomment if you’re on an older Mac that messes up the animation)
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

echo "Increase window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "Display ASCII control characters using caret notation in standard text views"
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

echo "Disable automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

echo "Disable the crash reporter"
defaults write com.apple.CrashReporter DialogType -string "none"

echo "Set Help Viewer windows to non-floating mode"
defaults write com.apple.helpviewer DevMode -bool true

echo "Reveal IP address, hostname, OS version, etc. when clicking the clock"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "Restart automatically if the computer freezes"
systemsetup -setrestartfreeze on

echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "Increase sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo "Mute all sounds, including volume control feedback"
defaults write "com.apple.sound.beep.feedback" -int 0
defaults write "com.apple.systemsound" "com.apple.sound.uiaudio.enabled" -int 0

echo "Enable keyboard access for all controls"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Enable access for assistive devices"
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

echo "Enable scroll gesture with the Ctrl (^) modifier key to zoom"
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

echo "Follow the keyboard focus while zoomed in"
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

echo "Automatically illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -bool true

echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

###############################################################################
# Screen                                                                      #
###############################################################################

echo "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "$HOME/Desktop"

echo "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

echo "Requiring password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

echo "Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons"
defaults write com.apple.finder QuitMenuItem -bool true

echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Finder: allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo "Enable snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo "Set grid spacing for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 20" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 20" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 20" ~/Library/Preferences/com.apple.finder.plist

echo "Decrease the size of icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 36" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 36" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 36" ~/Library/Preferences/com.apple.finder.plist

echo "Use list view in all Finder windows by default"
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"

echo "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "Empty Trash securely by default"
defaults write com.apple.finder EmptyTrashSecurely -bool true

echo "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

echo "Show the ~/Library folder"
chflags nohidden ~/Library

echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Remove Dropbox’s green checkmark icons in Finder"
file=/Applications/Dropbox.app/Contents/Resources/check.icns
[ -e "$file" ] && mv -f "$file" "$file.bak"
unset file

###############################################################################
# Dock & hot corners                                                          #
###############################################################################

echo "Enable highlight hover effect for the grid view of a stack (Dock)"
defaults write com.apple.dock mouse-over-hilte-stack -bool true

echo "Enable spring loading for all Dock items"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

echo "Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1

echo "Group windows by application in Mission Control"
defaults write com.apple.dock "expose-group-by-app" -bool true

echo "Don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

echo "Don't show the Dashboard at all"
defaults write com.apple.dashboard mcx-disabled -boolean true

echo "Remove the auto-hiding Dock delay"
defaults write com.apple.Dock autohide-delay -float 0

echo "Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0

echo "Add iOS Simulator to Launchpad"
ln -s /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app

# Hot corners

echo "Top left screen corner → Mission Control"
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

echo "Top right screen corner → Desktop"
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

echo "Bottom left screen corner → Start screen saver"
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

echo "Don't send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "Set Safari’s home page to `about:blank` for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"

echo "Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo "Hide Safari’s bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "Disable Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "Make Safari’s search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

###############################################################################
# Chrome                                                                      #
###############################################################################

echo "Using the system-native print preview dialog in Chrome"
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true


###############################################################################
# iTunes                                                                      #
###############################################################################

echo "Disable the iTunes store link arrows"
defaults write com.apple.iTunes show-store-link-arrows -bool false

echo "Disable the Genius sidebar in iTunes"
defaults write com.apple.iTunes disableGeniusSidebar -bool true

echo "Disable the Ping sidebar in iTunes"
defaults write com.apple.iTunes disablePingSidebar -bool true

echo "Disable all the other Ping stuff in iTunes"
defaults write com.apple.iTunes disablePing -bool true

echo "Make ⌘ + F focus the search input in iTunes"
defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"

###############################################################################
# Mail                                                                        #
###############################################################################

echo "Disable send and reply animations in Mail.app"
defaults write com.apple.Mail DisableReplyAnimations -bool true
defaults write com.apple.Mail DisableSendAnimations -bool true

echo "Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"

###############################################################################
# Time Machine                                                                #
###############################################################################

echo "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "Disable local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

echo "Enable the debug menu in Address Book"
defaults write com.apple.addressbook ABShowDebugMenu -bool true

echo "Enable Dashboard dev mode (allows keeping widgets on the desktop)"
defaults write com.apple.dashboard devmode -bool true

echo "Enable the debug menu in iCal (pre-10.8)"
defaults write com.apple.iCal IncludeDebugMenu -bool true

echo "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0

echo "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

echo "Enable the debug menu in Disk Utility"
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

echo "Allow installing user scripts via GitHub or gists"
defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*"
defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://*.github.com/*"

###############################################################################
# Transmission.app                                                            #
###############################################################################

echo "Don’t prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false

echo "Trash original torrent files"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

echo "Hide the donate message"
defaults write org.m0k.transmission WarningDonate -bool false

echo "Hide the legal disclaimer"
defaults write org.m0k.transmission WarningLegal -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Address Book" "Calendar" "Contacts" "Dashboard" "Dock" "Finder" \
	"Mail" "Safari" "SizeUp" "SystemUIServer" "Transmission" \
	"Twitter" "iCal" "iTunes"; do
	killall "$app" > /dev/null 2>&1
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
