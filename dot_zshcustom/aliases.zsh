# -----------------------------------------------------
# Shell Aliases
# -----------------------------------------------------

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "${method}"="lwp-request -m '${method}'"
done

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

## Command Aliases
alias x=exit
alias c=clear
alias s=screen
alias sr='screen -R'
alias sls='screen -ls'
alias sreload='source ~/.zshrc'
alias o='open'
alias cz='chezmoi'
alias rc='chezmoi cd && code .'
alias dots='chezmoi cd'
alias cza='chezmoi apply -v && source ~/.zshrc'

## Pipe Aliases (Global)
alias -g L='|less'
alias -g G='|grep'
alias -g T='|tail'
alias -g H='|head'
alias -g W='|wc -l'
alias -g S='|sort'

# git aliases
alias todos='git diff master...HEAD | grep -i "^+.*TODO"'

# Random
alias ytmp3="youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata "
alias shrug="echo '¯\_(ツ)_/¯'"
alias burnpc="cat ~/.zshcustom/art/burnpc.txt"
alias mushroom="cat ~/.zshcustom/art/mushroom.txt"
