project () {
  local search_dir=~/coding
  local preview_cmd="eza -lah --sort=type --icons --no-permissions --no-filesize --no-time --no-user $search_dir/{}"

  local target_dir=$(fd . $search_dir --exact-depth=1 --type d --exec printf '{/}\0' | fzf --preview $preview_cmd --exit-0 --read0)

  if [[ -n $target_dir ]]; then
    cd $search_dir/$target_dir
    eza -lah --group-directories-first --icons
  fi
}

configs () {
  local search_dir=~/.config
  local preview_cmd="eza -lah --sort=type --icons --no-permissions --no-filesize --no-time --no-user $search_dir/{}"

  local target_dir=$(fd . $search_dir --exact-depth=1 --type d --exec printf '{/}\0' | fzf --preview $preview_cmd --exit-0 --read0)

  if [[ -n $target_dir ]]; then
    cd $search_dir/$target_dir
    eza -lah --group-directories-first --icons
  fi
}

school () {
  local search_dir=~/dox/school
 
  # Piping into `sed -Ez "s|(.*)\/|\1|"` will remove the last slash
  local target_dir=$(fd . --base-directory $search_dir --min-depth=1 --type d --print0 --strip-cwd-prefix | sed -Ez "s|(.*)\/|\1|" | fzf --exit-0 --read0)

  if [[ -n $target_dir ]]; then
    cd $search_dir/$target_dir
    eza -lah --group-directories-first --icons
  fi
}
