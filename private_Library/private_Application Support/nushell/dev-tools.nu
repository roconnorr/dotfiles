# -----------------------------------------------------
# Development Tools (Optional)
# -----------------------------------------------------
# Node/npm/yarn shortcuts
# Uncomment the source line in config.nu to enable

# Fresh install of node_modules
def nfresh [] {
    rm -rf node_modules/
    npm install
}

# npm start
def ns [] {
    npm start
}

# npm run with script argument
def nr [script: string] {
    npm run $script
}

# npm install and start
def nis [] {
    npm install
    npm start
}

# yarn start
def ys [] {
    yarn start
}

# yarn install and start
def yis [] {
    yarn
    yarn start
}
