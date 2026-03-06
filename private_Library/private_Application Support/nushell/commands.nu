# -----------------------------------------------------
# Custom Commands and Functions
# -----------------------------------------------------

# Get public IP address
def ip [] {
    dig +short myip.opendns.com @resolver1.opendns.com
}

# Get local IP address
def localip [] {
    ipconfig getifaddr en0
}

# Today's date in YYYY-MM-DD format
def td [] {
    date now | format date "%Y-%m-%d"
}

# Display PATH entries one per line
def path [] {
    $env.PATH | each { |p| echo $p }
}

# Get weather for a location (defaults to auckland)
def weather [location: string = "auckland"] {
    curl -4 $"wttr.in/($location)"
}

# Extract archived files
def extract [file: path] {
    if not ($file | path exists) {
        error make {msg: $"'($file)' is not a valid file"}
    }

    let filename = ($file | path basename)

    # Check for compound extensions like .tar.gz
    if ($filename | str ends-with ".tar.gz") {
        tar -zxvf $file
    } else if ($filename | str ends-with ".tar.bz2") {
        tar -jxvf $file
    } else if ($filename | str ends-with ".tgz") {
        tar -zxvf $file
    } else if ($filename | str ends-with ".tbz2") {
        tar -jxvf $file
    } else {
        # Single extension check
        let ext = ($file | path parse | get extension)

        match $ext {
            "bz2" => { bunzip2 $file },
            "dmg" => { hdiutil mount $file },
            "gz" => { gunzip $file },
            "tar" => { tar -xvf $file },
            "zip" | "ZIP" => { unzip $file },
            "pax" => { cat $file | pax -r },
            "rar" => { unrar x $file },
            "Z" => { uncompress $file },
            _ => { error make {msg: $"'($file)' cannot be extracted/mounted via extract()"} }
        }
    }
}

# Show git diff with bat syntax highlighting
def batdiff [] {
    git diff --name-only --diff-filter=d | xargs bat --diff
}

# Chezmoi apply with verbose output
# Note: Unlike zsh version, this won't reload the shell automatically
# You'll need to restart nu manually if config files change
def cza [] {
    chezmoi apply -v
    print "Config applied. Restart nushell for changes to take effect."
}
