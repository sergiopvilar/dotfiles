#!/usr/bin/env bash

# Sets reasonable OS X defaults.
#

if [ "$(uname)" == "Darwin" ]; then

	# Close any open System Preferences panes, to prevent them from overriding
	# settings we’re about to change
	osascript -e 'tell application "System Preferences" to quit'

	# Ask for the administrator password upfront
	sudo -v

	# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

	###############################################################################
	# General UI/UX                                                               #
	###############################################################################

	# Set computer name (as done via System Preferences → Sharing)
	sudo scutil --set ComputerName "Hyperion"
	sudo scutil --set HostName "Hyperion"
	sudo scutil --set LocalHostName "Hyperion"
	sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Hyperion"

	# Disable the sound effects on boot
	sudo nvram SystemAudioVolume=" "

	# Expand save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

	# Expand print panel by default
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

	# Save to disk (not to iCloud) by default
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

	# Automatically quit printer app once the print jobs complete
	defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

	# Reveal IP address, hostname, OS version, etc. when clicking the clock
	# in the login window
	sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

	# Restart automatically if the computer freezes
	sudo systemsetup -setrestartfreeze on

	# Disable automatic capitalization as it’s annoying when typing code
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

	# Disable smart dashes as they’re annoying when typing code
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

	# Disable automatic period substitution as it’s annoying when typing code
	defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

	# Disable smart quotes as they’re annoying when typing code
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

	# Disable auto-correct
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

	# Disable the “Are you sure you want to open this application?” dialog
	defaults write com.apple.LaunchServices LSQuarantine -bool false

	# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
	/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

	# Disable press-and-hold for keys in favor of key repeat.
	defaults write -g ApplePressAndHoldEnabled -bool false

	# Use AirDrop over every interface. srsly this should be a default.
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

	# Set the Finder prefs for showing a few different volumes on the Desktop.
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

	###############################################################################
	# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
	###############################################################################

	# Trackpad: enable tap to click for this user and for the login screen
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

	# Disable “natural” (Lion-style) scrolling
	defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

	# Always show scrollbars
	defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

	# Increase sound quality for Bluetooth headphones/headsets
	defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

	# Enable full keyboard access for all controls
	# (e.g. enable Tab in modal dialogs)
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3


	# Use scroll gesture with the Ctrl (^) modifier key to zoom
	defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
	defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

	# Follow the keyboard focus while zoomed in
	defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

	# Set language and text formats
	# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
	# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
	defaults write NSGlobalDomain AppleLanguages -array "pt"
	defaults write NSGlobalDomain AppleLocale -string "pt_BR@currency=BRL"
	defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
	defaults write NSGlobalDomain AppleMetricUnits -bool true

	# Set the timezone; see `sudo systemsetup -listtimezones` for other values
	sudo systemsetup -settimezone "America/Recife" > /dev/null

	# Stop iTunes from responding to the keyboard media keys
	launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

	###############################################################################
	# Screen                                                                      #
	###############################################################################

	# Require password immediately after sleep or screen saver begins
	defaults write com.apple.screensaver askForPassword -int 1
	defaults write com.apple.screensaver askForPasswordDelay -int 0

	# Save screenshots to downloads directory
	defaults write com.apple.screencapture location -string "${HOME}/Downloads"

	# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
	defaults write com.apple.screencapture type -string "png"

	# Disable shadow in screenshots
	defaults write com.apple.screencapture disable-shadow -bool true

	###############################################################################
	# Finder                                                                      #
	###############################################################################

	# Set Desktop as the default location for new Finder windows
	# For other paths, use `PfLo` and `file:///full/path/here/`
	defaults write com.apple.finder NewWindowTarget -string "PfDe"
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

	# Finder: show hidden files by default
	defaults write com.apple.finder AppleShowAllFiles -bool true

	# Finder: show all filename extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	# Finder: show status bar
	defaults write com.apple.finder ShowStatusBar -bool true

	# Finder: show path bar
	defaults write com.apple.finder ShowPathbar -bool true

	# Keep folders on top when sorting by name
	defaults write com.apple.finder _FXSortFoldersFirst -bool true

	# When performing a search, search the current folder by default
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

	# Disable the warning when changing a file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

	# Avoid creating .DS_Store files on network or USB volumes
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

	# Automatically open a new Finder window when a volume is mounted
	defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
	defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
	defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

	# Use list view in all Finder windows by default
	# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

	# Disable the warning before emptying the Trash
	defaults write com.apple.finder WarnOnEmptyTrash -bool false

	# Show the ~/Library folder.
	chflags nohidden ~/Library

	# Expand the following File Info panes:
	# “General”, “Open with”, and “Sharing & Permissions”
	defaults write com.apple.finder FXInfoPanesExpanded -dict \
		General -bool true \
		OpenWith -bool true \
		Privileges -bool true

	###############################################################################
	# Dock, Dashboard, and hot corners                                            #
	###############################################################################

	# Set the icon size of Dock items to 64 pixels
	defaults write com.apple.dock tilesize -int 64

	# Change minimize/maximize window effect
	defaults write com.apple.dock mineffect -string "scale"

	# Wipe all (default) app icons from the Dock
	# This is only really useful when setting up a new Mac, or if you don’t use
	# the Dock to launch apps.
	#defaults write com.apple.dock persistent-apps -array

	# Disable Dashboard
	defaults write com.apple.dashboard mcx-disabled -bool true

	# Don’t automatically rearrange Spaces based on most recent use
	defaults write com.apple.dock mru-spaces -bool false

	# Don’t show recent applications in Dock
	defaults write com.apple.dock show-recents -bool false

	# Hot corners
	# Possible values:
	#  0: no-op
	#  2: Mission Control
	#  3: Show application windows
	#  4: Desktop
	#  5: Start screen saver
	#  6: Disable screen saver
	#  7: Dashboard
	# 10: Put display to sleep
	# 11: Launchpad
	# 12: Notification Center
	# Top left screen corner → Mission Control
	defaults write com.apple.dock wvous-tl-corner -int 2
	defaults write com.apple.dock wvous-tl-modifier -int 0
	# Top right screen corner → Desktop
	defaults write com.apple.dock wvous-tr-corner -int 12
	defaults write com.apple.dock wvous-tr-modifier -int 0
	# Bottom left screen corner → Start screen saver
	defaults write com.apple.dock wvous-bl-corner -int 11
	defaults write com.apple.dock wvous-bl-modifier -int 0
	# Bottom right screen corner → Start screen saver
	defaults write com.apple.dock wvous-br-corner -int 4
	defaults write com.apple.dock wvous-br-modifier -int 0

	###############################################################################
	# Spotlight                                                                   #
	###############################################################################

	# Hide Spotlight tray-icon (and subsequent helper)
	#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
	# Disable Spotlight indexing for any volume that gets mounted and has not yet
	# been indexed before.
	# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
	sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
	# Change indexing order and disable some search results
	# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
	# 	MENU_DEFINITION
	# 	MENU_CONVERSION
	# 	MENU_EXPRESSION
	# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
	# 	MENU_WEBSEARCH             (send search queries to Apple)
	# 	MENU_OTHER
	defaults write com.apple.spotlight orderedItems -array \
		'{"enabled" = 1;"name" = "APPLICATIONS";}' \
		'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
		'{"enabled" = 1;"name" = "DIRECTORIES";}' \
		'{"enabled" = 1;"name" = "PDF";}' \
		'{"enabled" = 1;"name" = "FONTS";}' \
		'{"enabled" = 0;"name" = "DOCUMENTS";}' \
		'{"enabled" = 0;"name" = "MESSAGES";}' \
		'{"enabled" = 0;"name" = "CONTACT";}' \
		'{"enabled" = 0;"name" = "EVENT_TODO";}' \
		'{"enabled" = 0;"name" = "IMAGES";}' \
		'{"enabled" = 0;"name" = "BOOKMARKS";}' \
		'{"enabled" = 0;"name" = "MUSIC";}' \
		'{"enabled" = 0;"name" = "MOVIES";}' \
		'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
		'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
		'{"enabled" = 0;"name" = "SOURCE";}' \
		'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
		'{"enabled" = 0;"name" = "MENU_OTHER";}' \
		'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
		'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
		'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
		'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
	# Load new settings before rebuilding the index
	killall mds > /dev/null 2>&1
	# Make sure indexing is enabled for the main volume
	sudo mdutil -i on / > /dev/null
	# Rebuild the index from scratch
	sudo mdutil -E / > /dev/null


	###############################################################################
	# Terminal & iTerm 2                                                          #
	###############################################################################

	# Only use UTF-8 in Terminal.app
	defaults write com.apple.terminal StringEncodings -array 4

	# Don’t display the annoying prompt when quitting iTerm
	defaults write com.googlecode.iterm2 PromptOnQuit -bool false

	###############################################################################
	# Activity Monitor                                                            #
	###############################################################################

	# Show the main window when launching Activity Monitor
	defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

	# Visualize CPU usage in the Activity Monitor Dock icon
	defaults write com.apple.ActivityMonitor IconType -int 5

	# Show all processes in Activity Monitor
	defaults write com.apple.ActivityMonitor ShowCategory -int 0

	# Sort Activity Monitor results by CPU usage
	defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
	defaults write com.apple.ActivityMonitor SortDirection -int 0

	###############################################################################
	# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
	###############################################################################

	# Use plain text mode for new TextEdit documents
	defaults write com.apple.TextEdit RichText -int 0
	# Open and save files as UTF-8 in TextEdit
	defaults write com.apple.TextEdit PlainTextEncoding -int 4
	defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

	###############################################################################
	# Mac App Store                                                               #
	###############################################################################

	# Enable the automatic update check
	defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

	# Check for software updates daily, not just once per week
	defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

	# Download newly available updates in background
	defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

	# Install System data files & security updates
	defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

	# Turn on app auto-update
	defaults write com.apple.commerce AutoUpdate -bool true

	# Allow the App Store to reboot machine on macOS updates
	defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

	###############################################################################
	# Photos                                                                      #
	###############################################################################

	# Prevent Photos from opening automatically when devices are plugged in
	defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
	echo "Done. Note that some of these changes require a logout/restart to take effect."
fi

if [ "$(uname)" == "Linux" ]; then
	sudo apt-get install zsh -y
fi

echo "Installing OMZSH"
export ZSH=$HOME/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
