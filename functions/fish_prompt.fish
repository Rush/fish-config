# Defined in /home/rush/.config/fish/functions/fish_prompt.fish @ line 25
function fish_prompt
  set -l last_status $status
  set fish_greeting
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)



  # output the prompt, left to right:
  # display 'user@host:'
  if test (whoami) = root
    set cwd $cyan(pwd)
    echo -n -s $red (whoami) $red @ $red (hostname|cut -d . -f 1) ": "
  else
    set cwd $cyan(prompt_pwd)
    echo -n -s $green (whoami) $green @ $green (hostname|cut -d . -f 1) ": "
  end

  # display the current directory name:
  echo -n -s $cwd $normal

  # show git branch and dirty state, if applicable:
#  if [ (_git_branch_name) ]
#    set -l git_branch '[' (_git_branch_name) ']'
#
#    if [ (_is_git_dirty) ]
#      set git_info $red $git_branch
#    else if [ (_is_git_dirty_new) ]
#      set git_info $yellow $git_branch
#    else
#      set git_info $green $git_branch
#    end
#    echo -n -s ' ' $git_info $normal
#  end
  echo -n -s (fish_git_prompt)

  set -l last_command $history[1]

  if test $last_status -ne 0
    set_color red
    printf ' %d' $last_status
    set_color normal
  end
  if test "$CMD_DURATION" -gt 10; and [ "$last_command" != "fish" ]
    set_color brblue
    if test "$CMD_DURATION" -ge 3600000
      printf ' %0.fh %0.fm' (math $CMD_DURATION / 3600000) (math $CMD_DURATION '%' 3600000 / 60000)
    else if test "$CMD_DURATION" -ge 60000
      printf ' %.0fm %.0fs' (math $CMD_DURATION / 60000) (math $CMD_DURATION '%' 60000 / 1000)
    else if test "$CMD_DURATION" -ge 1000
      printf ' %.0f.%02.0fs' (math $CMD_DURATION / 1000) (math $CMD_DURATION '%' 1000 / 10)
    else
      printf ' %.0fms' $CMD_DURATION
    end
    set_color normal
  end

  # terminate with a nice prompt char:
  echo -n -s ' » ' $normal

end