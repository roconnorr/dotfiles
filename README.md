# dotfiles

### Setup

`/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/roconnorr/dotfiles/master/init.sh)"`

### Firefox

After installing, open `about:config` and set:

- `toolkit.legacyUserProfileCustomizations.stylesheets` → `true`
- `sidebar.revamp` → `false`

These are required for the custom `userChrome.css` to work.
