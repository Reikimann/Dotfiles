local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

package.path = package.path .. ";./util/?.lua"
local lazyOpts = {
  change_detection = {
    notify = false,
  },
}

require("config")
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
  },
  lazyOpts,
})
