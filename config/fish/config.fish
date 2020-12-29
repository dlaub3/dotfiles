# ENV
fish_vi_key_bindings
# fish_default_key_bindings
switch (uname)
    case Linux
        set -x PATH /usr/bin/vendor_perl $PATH
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    case Darwin
        set -x PATH /usr/local/bin $PATH
        set -x PATH /usr/local/opt/node@12/bin $PATH
        set -x PATH /usr/local/opt/python@3.8/bin $PATH
    case FreeBSD NetBSD DragonFly
          echo Hi Beastie!
    case '*'
            echo Hi, stranger!
end

set -x RIPGREP_CONFIG_PATH ~/.ripgreprc
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!{.git,node_modules,dist}"'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
alias fzf_preview='fzf --preview "bat --style=numbers --color=always {} | less -R"'

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

function lorem --description "get lorem text" 
  ~/.dotfiles/lorem.pl $argv[1] | pbcopy
  pbpaste
end

function j_test --description "run jest tests for the current directory, or provide a path"
  set dir (pwd | sed -E 's/^.+src/src/')
  if not set -q argv[1]
    yarn jest $dir 
  else if test $argv[1] = '--coverage'
    yarn jest $dir \
    --coverage \
    --collectCoverageFrom=\"$dir/\*\*/\*.{ts,tsx}\" \
    --coveragePathIgnorePatterns=\"__tests__/\"
  else if not set -q argv[2]
    yarn jest $argv[1] 
  else if test $argv[2] = '--coverage'
    yarn jest $argv[1] \
    --coverage \
    --collectCoverageFrom=\"$argv[1]\*\*/\*.{ts,tsx}\" \
    --coveragePathIgnorePatterns=\"__tests__/\"
   else
     echo "💩 - garbage in garbage out"
  end
end

switch (uname)
    case Linux
    case Darwin
    case FreeBSD NetBSD DragonFly
        echo Hi Beastie!
    case '*'
        echo Hi, stranger!
end
