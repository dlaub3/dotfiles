# alias
alias ll="ls -alh"
alias gcap="git commit -am \"make prettier 💋\""

#tmux default
alias tmux-default="~/.tmux/launch_scripts/default.sh"

# JS Helpers
alias git-changed="git diff --name-only --relative && git diff --staged --name-only --relative && git ls-files -o --exclude-standard"

function jsBeautifyAge --description "beautify <interval>" 
  npx prettier --write (git diff --name-only --relative "@{$argv[1]}")
end

function jsLintAge --description "lintAge <interval>"
  npx tslint (git diff --name-only --relative "@{$argv[1]}" | grep '\.[t|j]sx\?$' ) --fix
end

function jsBeautify --description "beautify"
  npx prettier --write (git-changed)
end

function jsLint --description "lint"
  npx tslint (git-changed | grep '\.[t|j]sx\?$') --fix -c ./.tslintrc.ignore.json
end

function showFiles --description "search files and list filenames"
  egrep -C 3 -rl $argv[1] . | fzf --preview 'bat --style=numbers --color=always {} | less -R' 
end

function showContents --description "search files and list contents"
  egrep -C 3 -rl $argv[1] . | xargs egrep -C2 --color $argv[1]
end
