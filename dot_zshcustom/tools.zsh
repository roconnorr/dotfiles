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
alias nr="npm run "
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

# Function for taking a screenshot with adb, appending manufacturer, device name, and timestamp to the filename
adbscreenshot() {
  local manufacturer=$(adb shell getprop ro.product.manufacturer | tr -d "[:space:]")
  local model=$(adb shell getprop ro.product.model | tr -d "[:space:]")
  local timestamp=$(date +%Y%m%d%H%M%S)
  local output_file="$HOME/Pictures/Screenshots/screenshot-${manufacturer}-${model}-${timestamp}.png"

  adb exec-out screencap -p > "$output_file"
}

# Function for recording the screen with adb, appending manufacturer, device name, and timestamp to the filename
function adbscreenrecord() {
  local manufacturer=$(adb shell getprop ro.product.manufacturer | tr -d "[:space:]")
  local model=$(adb shell getprop ro.product.model | tr -d "[:space:]")
  local timestamp=$(date +%Y%m%d%H%M%S)
  local output_file="$HOME/Pictures/Screencap/screenrecord-${manufacturer}-${model}-${timestamp}.mp4"

  if ! command -v adb &> /dev/null; then
      echo "Error: ADB is not installed or not in PATH"
      return 1
  fi

  if ! adb devices | grep -q device$; then
      echo "Error: No Android device connected"
      return 1
  fi

  echo "Starting screen recording..."
  echo "Output file: $output_file"
  echo "Press Ctrl+C to stop recording"

  # Function to clean up and save recording
  function cleanup_and_save() {
      echo "Stopping recording..."
      adb shell pkill -l SIGINT screenrecord
      sleep 2
      adb pull /sdcard/screen_recording.mp4 "$output_file"
      adb shell rm /sdcard/screen_recording.mp4
      echo "Screen recording saved to $output_file"
      trap - SIGINT  # Reset the trap
  }

  # Set trap for SIGINT (Ctrl+C)
  trap cleanup_and_save SIGINT

  # Start screen recording without time limit
  adb shell screenrecord /sdcard/screen_recording.mp4 &
  local pid=$!

  # Wait for the background process or until interrupted
  wait $pid

  # Reset the trap
  trap - SIGINT
}

# Function for streaming the screen with adb
adbstream() {
  adb exec-out screenrecord --output-format=h264 - | ffplay -framerate 60 -probesize 32 -sync video  -
}

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

function merge-build-pr() {
    local pr_number

    if [ $# -eq 0 ]; then
        echo -n "Enter the PR number: "
        read pr_number
    else
        pr_number=$1
    fi

    if [[ ! $pr_number =~ ^[0-9]+$ ]]; then
        echo "Invalid PR number. Please enter a valid number."
        return 1
    fi

    # Check out the PR
    if ! gh pr checkout $pr_number; then
        echo "Failed to check out PR #$pr_number"
        return 1
    fi

    # Create an empty commit and push
    if ! git commit --allow-empty -m "Trigger CI"; then
        echo "Failed to create empty commit"
        return 1
    fi

    if ! git push; then
        echo "Failed to push the commit"
        return 1
    fi

    if ! gh pr review $pr_number --approve; then
        echo "Failed to approve PR #$pr_number"
        return 1
    fi

    if ! gh pr merge $pr_number --auto --delete-branch --squash; then
        echo "Failed to merge PR #$pr_number"
        return 1
    fi

    echo "Successfully triggered CI for PR #$pr_number"
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

brewbundle() {
  case $1 in
      [work]* ) echo "Installing base+work Brewfiles"; cat Brewfile.base Brewfile.work | brew bundle install --file=-;;
      [home]* ) echo "Installing base+home Brewfiles"; cat Brewfile.base Brewfile.home | brew bundle install --file=-;;
      [base]* ) echo "Installing base Brewfile"; brew bundle install --file=Brewfile.base;;
      * ) echo "Invalid option";;
  esac
}

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
