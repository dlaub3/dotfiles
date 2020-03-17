

set -x TERM screen-256color


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
  npx tslint (git diff --name-only --relative "@{$argv[1]}") --fix
end

function jsBeautify --description "beautify"
  npx prettier --write (git-changed)
end

function jsLint --description "lint"
  npx tslint (git-changed) --fix -c ./.tslintrc.ignore.json
end

