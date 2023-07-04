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
alias ys="yarn start"
alias yis="yarn && yarn start"

#############################################
#
# React Native
#
#############################################
alias rnstartandroid='adb reverse tcp:8097 tcp:8097 && adb reverse tcp:8081 tcp:8081 && npx react-native run-android'
alias rnstartios='npx react-native run-ios'
alias rnlogandroid='npx react-native log-android'
alias rnlogios='npx react-native log-ios'
alias pixel2='emulator -avd Pixel_2_API_30'
alias pixel3a='emulator -avd Pixel_3a_API_30'
alias pixel4='emulator -avd Pixel_4_API_S'
alias android-tiny='emulator -avd 3.4_WQVGA_API_30'
alias killavd='adb emu kill'
alias reloadandroid='adb shell input text "RR"'
alias devmenuandroid='adb shell input keyevent 82'
alias iosrecord="xcrun simctl io booted recordVideo"
alias podi="cd ios && pod install && cd .."

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

#############################################
#
# github
#
#############################################
function pr-checkout() {
  local jq_template pr_number

  jq_template='"'\
'#\(.number) - \(.title)'\
'\t'\
'Author: \(.user.login)\n'\
'Created: \(.created_at)\n'\
'Updated: \(.updated_at)\n\n'\
'\(.body)'\
'"'

  pr_number=$(
    gh api 'repos/:owner/:repo/pulls' |
    jq ".[] | $jq_template" |
    sed -e 's/"\(.*\)"/\1/' -e 's/\\t/\t/' |
    fzf \
      --with-nth=1 \
      --delimiter='\t' \
      --preview='echo -e {2}' \
      --preview-window=top:wrap |
    sed 's/^#\([0-9]\+\).*/\1/'
  )

  if [ -n "$pr_number" ]; then
    gh pr checkout "$pr_number"
  fi
}

function pr-list() {
  gh api 'repos/:owner/:repo/pulls' |
    jq --raw-output '.[] | "#\(.number) \(.title)"'
}

function create-pr() {
  branchName=$(git rev-parse --abbrev-ref HEAD) && gh pr create -w -t="$branchName"
}

#############################################
#
# general
#
#############################################
# alias code='codium'
alias batp='bat --plain'
batdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}
