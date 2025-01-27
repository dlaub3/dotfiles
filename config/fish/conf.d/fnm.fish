# fnm
set FNM_PATH "/home/$USER/.fnm"
if [ -d "$FNM_PATH" ]
  set PATH "$FNM_PATH" $PATH
end

if type -q fnm
  fnm env | source
end
