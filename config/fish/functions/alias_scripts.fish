# this function enables calling running bash function as commands 

function alias_scripts --description "alias the scripts found in ~/.dotfiles/scripts."
  for file in $HOME/.dotfiles/scripts/*.sh
    set command (basename $file | sed s/.sh//)
    alias $command="bash $file"
  end
end
