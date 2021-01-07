# ENV
set -x SHELL (which fish)
fish_vi_key_bindings
# fish_default_key_bindings
switch (uname)
    case Linux
        set -x PATH /usr/bin/vendor_perl $PATH
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    case Darwin
    case FreeBSD NetBSD DragonFly
        echo Hi Beastie!
    case '*'
        echo Hi, stranger!
end

set -x RIPGREP_CONFIG_PATH ~/.ripgreprc
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!{.git,node_modules,dist}"'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
alias fzf_preview='fzf --preview "bat --style=numbers --color=always {} | less -R"'

alias nvimdiff='nvim -p (git diff --name-only --relative && git diff --staged --name-only --relative && git ls-files -o --exclude-standard)'
# alias
alias ls="exa --long --header"
alias ll="ls -alh"
alias gcap="git commit -am \"make prettier 💋\""

#tmux default
alias tmux-default="~/.tmux/launch_scripts/default.sh"

# JS Helpers
alias git-changed="git diff --name-only --relative && git diff --staged --name-only --relative && git ls-files -o --exclude-standard"

alias jsonPretty="pbpaste | jq | pbcopy && pbpaste | jq"

function myPrettierAge --description "beautify <interval>" 
  npx prettier@1.19.1 --write (git diff --name-only --relative "@{$argv[1]}")
end

function myPrettier --description "beautify"
  npx prettier@1.19.1 --write (git-changed)
end

function myStylelintAge --description "lint"
  set files_list (git diff --name-only --relative "@{$argv[1]}" | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx stylelint@12.0.0 $files_list --config ./stylelint.config.js
  else
    echo "no files"
  end
end

function myStyleLint --description "lint"
  set files_list (git-changed | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx stylelint@12.0.0 $files_list --config ./stylelint.config.js
  else
    echo "no files"
  end
end

function myEslint --description "lint"
  set files_list (git-changed | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx eslint $files_list $argv[1]
  else
    echo "no files"
  end
end

function myEslintAge --description "lintAge <interval>"
  set files_list (git diff --name-only --relative "@{$argv[1]}" | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx eslint $files_list $argv[2]
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


function jsImport --description "copy the import path to the clipboard"
   rg " $argv[1]" -l | rg "$argv[1]" | pbcopy
end

function lorem --description "get lorem text" 
  ~/.dotfiles/lorem.pl $argv[1] | pbcopy
  pbpaste
end

function j_test --description "run jest tests for the current directory, or provide a path"
  set dir (pwd | sed -E 's/^.+src/src/')
  if not set -q argv[1]
    npx jest $dir 
  else if test $argv[1] = '--coverage'
    npx jest $dir \
    --coverage \
    --collectCoverageFrom=\"$dir/\*\*/\*.{ts,tsx}\" \
    --coveragePathIgnorePatterns=\"__tests__/\"
  else if not set -q argv[2]
    npx jest $argv[1] 
  else if test $argv[2] = '--coverage'
    npx jest $argv[1] \
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
