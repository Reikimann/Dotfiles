return {
  {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local logo = [[
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       
      ⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀       
      ⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠀       
      ⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⠀⠀⠀⠀       
      ⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀       
      ⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀       
      ⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀       
      ⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀       
      ⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄       
      ⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿       
      ⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸       
      ⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈       
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       
      ⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀       
      ⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀       
    ]]
    -- logo = string.rep("\n", 2) .. logo .. "\n\n"
    local opts = {
      theme = 'hyper',
      hide = {
        statusline = false,
      },
      config = {
        disable_move = true,
        week_header = {
          true
        },
        packages = {
          enable = false
        },
        header = vim.split(logo, "\n"),
        project = {
          enable = true,
          limit = 8,
          action = "Telescope find_files cwd='/home/reikimann/coding/'"
        },
        mru = {
          limit = 10
        },
        shortcut = {
          {icon = " ", group = "@property", desc = "Edit Config", key = "c", action = "e ~/.config/nvim/init.lua"},
          {icon = "󰊳 ", group = "String", desc = "Lazy",        key = "l", action = ":Lazy"},
          {icon = " ", group = "DiagnosticHint", desc = "Dotfiles", key = "d", action = ""},
          {icon = " ", group = "Number", desc = "Quit Neovim", key = "q", action = ":qa"},
        },
        footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "", "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }
    return opts
  end,
  },
}
