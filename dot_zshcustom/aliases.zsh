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

# today's date
alias td='echo $(date +%Y-%m-%d)'

# date and time? - add

# # Directory shortcuts
# hash -d pack=$HOME/.cache/vim/pack/plugins/start
# hash -d vim=/usr/share/vim/vim82
# hash -d d=$HOME/code/arp242.net/_drafts
# hash -d p=$HOME/code/arp242.net/_posts
# hash -d go=/usr/lib/go/src
# hash -d c=$HOME/code
# hash -d gc=$HOME/code/goatcounter

# So if I have an idea for a new post here I just type vi ~d/$(td)-idea.markdown and presto (td is alias td='echo $(date +%Y-%m-%d)').

# create a temp shortcut for the current dir
hashcwd() { hash -d "$1"="$PWD" }

## Command Aliases
alias x=exit
alias c=clear
alias s=screen
alias sr='screen -R'
alias sls='screen -ls'
alias sreload='source ~/.zshrc'
alias o='open'
alias cz='chezmoi'
alias rc='chezmoi edit'
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
alias todos='git diff $(git branch -l master main | sed "s/^* //")...HEAD | grep -i -B 1 -A 1 "^+.*TODO"'
alias consolelogs='git diff $(git branch -l master main | sed "s/^* //")...HEAD | grep -i -B 1 -A 1 "^+.*console"'

# Random
alias ytmp3="youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata "
alias shrug="echo '¯\_(ツ)_/¯'"
alias burnpc="cat ~/.zshcustom/art/burnpc.txt"
alias mushroom="cat ~/.zshcustom/art/mushroom.txt"

# streams
alias brainfeeder="streamlink --stdout https://www.twitch.tv/brainfeeder 720p | iina --stdin"
