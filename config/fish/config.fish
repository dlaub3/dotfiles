# fish_default_key_bindings
switch (uname)
    case Linux
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
alias gcp="git commit -m \"make prettier 💋\""

function goto --description "A better cd"
fish_vi_key_bindings
  cd (fgo $argv)
end

#tmux default
alias tmux-default="~/.tmux/launch_scripts/default.sh"

alias jsonPretty="pbpaste | jq | pbcopy && pbpaste | jq"

function freePort --description "kill the process on a specified port"
  if test -n $argv[1] 

    set PID (lsof -t -i:$argv[1])

    if test $status -ne 0
      echo "Port $argv[1] is already free."
      return # nothing more to do
    end

    kill -9 $PID # this isn't nice
  
    if test $status -ne 0
      echo "Failed to kill PID: $PID"
    else
      echo "Killed PID: $PID"
    end
  else
    echo "You didn't specify a port."
  end
end

alias scripts="jq < package.json '.scripts' | tr -d '{}' | fzf | awk -F': ' '{ print \$1}' | tr  -d '\"' | sed 's/^://g' | xargs yarn"

# JS Helpers
alias git-changed="git diff HEAD origin/dev --name-only --relative --diff-filter=ACM && git diff --staged --name-only --relative --diff-filter=ACM && git ls-files -o --exclude-standard"

function myPrettier --description "run prettier"
  set npm_bin (npm bin)
  set files_list (git-changed | grep '\.[t|j]sx\?$')
  if test "$files_list"
    $npm_bin/prettier $argv[1..-1] $files_list # --write
  else
    echo "no files"
  end
end


function myStylelintJs --description "run stylelint"
  set npm_bin (npm bin)
  set -x STYLELINT_TYPE js
  set files_list (git-changed | grep '\.[t|j]sx\?$')
  if test "$files_list"
    $npm_bin/stylelint $argv[1..-1] $files_list # --fix
  else
    echo "no files"
  end
end

function myEslint --description "run eslint"
  set npm_bin (npm bin)
  set files_list (git-changed | grep '\.[t|j]sx\?$')
  if test "$files_list"
    $npm_bin/eslint $argv[1..-1] $files_list  # --fix
  else
    echo "no files"
  end
end

function myPrettierAge --description "beautify <interval>" 
  set files_list (git diff --name-only --relative "@{$argv[1]}" | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx prettier@1.19.1 --write $files_list 
  else
    echo "no files"
  end
end


function myStylelintAge --description "lint"
  set -x STYLELINT_TYPE js
  set files_list (git diff --name-only --relative "@{$argv[1]}" | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx stylelint@12.0.0 $files_list --config ./stylelint.config.js
  else
    echo "no files"
  end
end


function myEslintAge --description "lintAge <interval>"
  set files_list (git diff --name-only --relative "@{$argv[1]}" | grep '\.[t|j]sx\?$')
  if test "$files_list"
    npx eslint $files_list $argv[2..-1]

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


function myJsImport --description "copy the import path to the clipboard"
   rg " $argv[1]" -l | rg "$argv[1]" | pbcopy
end

function lorem --description "get lorem text" 
  ~/.dotfiles/lorem.pl $argv[1] | pbcopy
  pbpaste
end

function go_test --description "add colors to go test" 
  set GREP_COLOR "01;33"
  go test $argv | sed ''/PASS/s//(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//(printf "\033[31mFAIL\033[0m")/'' |  egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
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

alias_scripts

