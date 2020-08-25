#############################################
#
# Docker
#
#############################################
alias dps="docker ps -a"
alias dcup="docker-compose up"
alias dcstop="docker-compose stop"
alias dcrm="docker-compose rm"

#############################################
#
# Node
#
#############################################
alias nfresh="rm -rf node_modules/ && npm install"
alias ns="npm start"
alias nis="npm i && npm start"

#############################################
#
# React Native
#
#############################################
alias rnstartandroid='adb reverse tcp:8097 tcp:8097 && adb reverse tcp:8081 tcp:8081 && npx react-native run-android'
alias rnstartios='npx react-native run-ios'
alias rnlogandroid='npx react-native log-android'
alias rnlogios='npx react-native log-ios'
alias pixel='~/Library/Android/sdk/emulator/emulator -avd Pixel_2_API_29'
alias tab='~/Library/Android/sdk/emulator/emulator -avd Pixel_C_API_28'
alias reloadandroid='adb shell input text "RR"'
alias devmenuandroid='adb shell input keyevent 82'

#############################################
#
# Vagrant
#
#############################################
alias vup='vagrant up'
alias vdestroy='vagrant destroy'
alias vssh='vagrant ssh'
alias vreload='vagrant reload'
alias vhalt='vagrant halt'
alias vstatus='vagrant status'

#############################################
#
# fzf REPLs
#
#############################################
alias fzfjson='echo '' | fzf --print-query --preview "cat *.json | jq {q}"'
alias fzfls="echo '' | fzf --preview 'ls {q}'"
alias fzfrb="echo '' | fzf --print-query --preview 'ruby -e {q}'"