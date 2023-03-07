-- Viewer options: One may configure the viewer either by specifying a built-in
-- viewer method:
vim.g.vimtex_view_method = 'zathura'

-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
-- strongly recommended, you probably don't need to configure anything. If you
-- want another compiler backend, you can change it as follows. The list of
-- supported backends and further explanation is provided in the documentation,
-- see ":help vimtex-compiler".
vim.g.vimtex_compiler_method = 'latexmk'

-- Most VimTeX mappings rely on localleader and this can be changed with the
-- following line. The default is usually fine and is the symbol "\".
vim.g.maplocalleader = ","
vim.g.vimtex_fold_enabled = 1

-- Dunno
-- vim.opt.conceallevel = 2
-- % !TEX program = xelatex

vim.g.vimtex_syntax_conceal = {		-- enable or disable specific conceals
	accents = 1,
	ligatures = 1,
	cites = 1,
	fancy = 1,
	spacing = 0,			-- default: 1
	greek = 1,
	math_bounds = 1,
	math_delimiters = 1,
	math_fracs = 1,
	math_super_sub = 1,
	math_symbols = 1,
	sections = 0,
	styles = 1,
	}


