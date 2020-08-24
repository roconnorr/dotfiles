# fzf REPLs
alias fzfjson='echo '' | fzf --print-query --preview "cat *.json | jq {q}"'
alias fzfls="echo '' | fzf --preview 'ls {q}'"
alias fzfrb="echo '' | fzf --print-query --preview 'ruby -e {q}'"