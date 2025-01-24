# fnm
set FNM_PATH "/home/$USER/.fnm"
if [ -d "$FNM_PATH" ]
  set PATH "$FNM_PATH" $PATH
  fnm env | source
end
