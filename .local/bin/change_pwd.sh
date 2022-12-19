# Use command below to get full-path. Useful when sorting multiple directories.
# fd . $search_dir --exact-depth=1 --type d --print0 | fzf --exit-0 --read0)

project () {
  local search_dir=~/coding

  local target_dir=$(fd . $search_dir --exact-depth=1 --type d --exec printf '{/}\0' | fzf --exit-0 --read0)

  cd $search_dir/$target_dir
}

configs () {
  local search_dir=~/.config

  local target_dir=$(fd . $search_dir --exact-depth=1 --type d --exec printf '{/}\0' | fzf --exit-0 --read0)

  cd $search_dir/$target_dir
}
