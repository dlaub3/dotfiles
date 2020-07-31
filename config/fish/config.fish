# ENV
switch (uname)
    case Linux
            echo Hi Tux!
    case Darwin
        set -x PATH /usr/local/bin $PATH
        set -x PATH /usr/local/opt/node@12/bin $PATH
    case FreeBSD NetBSD DragonFly
            echo Hi Beastie!
    case '*'
            echo Hi, stranger!
end
# alias
alias ls="exa --long --header"
alias ll="ls -alh"
alias gcap="git commit -am \"make prettier 💋\""

#tmux default
alias tmux-default="~/.tmux/launch_scripts/default.sh"

# JS Helpers
alias git-changed="git diff --name-only --relative && git diff --staged --name-only --relative && git ls-files -o --exclude-standard"

alias jsonPretty="pbpaste | jq | pbcopy && pbpaste | jq"

function jsImport --description "copy the import path to the clipboard"
   rg " $argv[1]" -l | rg "$argv[1]" | pbcopy
end

function jsBeautifyAge --description "beautify <interval>" 
  npx prettier@1.19.1 --write (git diff --name-only --relative "@{$argv[1]}")
end

function jsBeautify --description "beautify"
  npx prettier@1.19.1 --write (git-changed)
end

function styleLintAge --description "lint"
  set files_list (git diff --name-only --relative "@{$argv[1]}" | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx stylelint@12.0.0 $files_list --config ./stylelint.config.js
  else
    echo "no files"
  end
end

function styleLint --description "lint"
  set files_list (git-changed | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx stylelint@12.0.0 $files_list --config ./stylelint.config.js
  else
    echo "no files"
  end
end

function tsLint --description "lint"
  set files_list (git-changed | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx tslint $files_list --fix -c ./.tslintrc.ignore.json
  else
    echo "no files"
  end
end

function tsLintNoSort --description "lint"
  set files_list (git-changed | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx tslint $files_list --fix
  else
    echo "no files"
  end
end

function tsLintAge --description "lintAge <interval>"
  set files_list (git diff --name-only --relative "@{$argv[1]}" | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx tslint $files_list --fix
  else
    echo 'no files'
  end
end

function showFiles --description "search files and list filenames"
  egrep -C 3 -rl $argv[1] . | fzf --preview 'bat --style=numbers --color=always {} | less -R' 
end

function showContents --description "search files and list contents"
  egrep -C 3 -rl $argv[1] . | xargs egrep -C2 --color $argv[1]
end

fnm env --multi | source
starship init fish | source
