-- Plain Neovim 0.12+ configuration migrated from the Nixvim modules in this repo.
-- Uses only Neovim's built-in plugin manager (`vim.pack.add`).
-- Copy/symlink this file as ~/.config/nvim/init.lua, or run with:
--   nvim -u /path/to/repo/nvim/init.lua

if vim.loader then
	vim.loader.enable()
end

local fn = vim.fn
local api = vim.api
local keymap = vim.keymap.set

local function notify(msg, level)
	vim.schedule(function()
		vim.notify(msg, level or vim.log.levels.WARN)
	end)
end

local function safe_require(mod)
	local ok, loaded = pcall(require, mod)
	if ok then
		return loaded
	end
	notify(("Could not require %q: %s"):format(mod, loaded))
	return nil
end

local function safe_setup(mod, opts)
	local loaded = safe_require(mod)
	if loaded and type(loaded.setup) == "function" then
		local ok, err = pcall(loaded.setup, opts or {})
		if not ok then
			notify(("Could not setup %q: %s"):format(mod, err))
		end
	end
	return loaded
end

local function plugin_path(name)
	return fn.stdpath("data") .. "/site/pack/core/opt/" .. name
end

local function exists(path)
	return vim.uv.fs_stat(path) ~= nil
end

-- -----------------------------------------------------------------------------
-- Built-in package manager
-- -----------------------------------------------------------------------------

api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local data = ev.data or {}
		local spec = data.spec or {}
		if spec.name == "nvim-treesitter" and (data.kind == "install" or data.kind == "update") then
			pcall(vim.cmd, "TSUpdate")
		end
	end,
})

vim.pack.add({
	-- UI/theme
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/itchyny/lightline.vim",
	"https://github.com/akinsho/barbar.nvim",
	"https://github.com/folke/which-key.nvim",

	-- Libraries/dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-neotest/nvim-nio",

	-- Navigation/search/files
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-file-browser.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/debugloop/telescope-undo.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/mbbill/undotree",
	"https://github.com/folke/flash.nvim",
	"https://github.com/nvim-mini/mini.nvim",

	-- Git/session/markdown
	"https://github.com/rmagatti/auto-session",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/kdheepak/lazygit.nvim",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/akinsho/git-conflict.nvim",
	"https://github.com/ThePrimeagen/git-worktree.nvim",
	"https://github.com/iamcco/markdown-preview.nvim",

	-- LSP/completion/format/lint
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mrcjkb/rustaceanvim",
	"https://github.com/jmbuhr/otter.nvim",
	"https://github.com/lukas-reineke/lsp-format.nvim",
	"https://github.com/nvimdev/lspsaga.nvim",
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1") },
	"https://github.com/ribru17/blink-cmp-spell",
	"https://github.com/Kaiser-Yang/blink-cmp-dictionary",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/gelguy/wilder.nvim",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/nvimtools/none-ls.nvim",

	-- Treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/HiPhish/rainbow-delimiters.nvim",
	"https://github.com/towolf/vim-helm",

	-- DAP
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/leoluz/nvim-dap-go",
	"https://github.com/julianolf/nvim-dap-lldb",
	"https://github.com/rcarriga/nvim-dap-ui",

	-- Testing
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/fredrikaverpil/neotest-golang",
	"https://github.com/rcasia/neotest-java",
	"https://github.com/rouge8/neotest-rust",
}, { confirm = false, load = true })

-- vim.pack does not run build hooks. Build telescope-fzf-native when possible.
do
	local fzf = plugin_path("telescope-fzf-native.nvim")
	local built = exists(fzf .. "/build/libfzf.so")
		or exists(fzf .. "/build/libfzf.dylib")
		or exists(fzf .. "/build/libfzf.dll")
	if exists(fzf) and not built and fn.executable("make") == 1 then
		pcall(function()
			vim.system({ "make" }, { cwd = fzf }):wait()
		end)
	end
end

-- -----------------------------------------------------------------------------
-- Core settings
-- -----------------------------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"

vim.opt.updatetime = 10
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.colorcolumn = "135"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.foldcolumn = "0"
vim.opt.autoindent = true
vim.opt.foldlevel = 99
vim.opt.hlsearch = true
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.scrolloff = 8
vim.opt.list = true
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions = "camel"

vim.diagnostic.config({
	virtual_lines = { current_line = true },
	virtual_text = false,
})

api.nvim_set_hl(0, "Todo", { fg = "Blue", bg = "Yellow" })
api.nvim_set_hl(0, "TODO", { fg = "Blue", bg = "Yellow" })
api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
pcall(vim.cmd, "match TODO /TODO/")

-- -----------------------------------------------------------------------------
-- User commands and autocmds
-- -----------------------------------------------------------------------------

api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, { desc = "Disable autoformat-on-save", bang = true })

api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })

api.nvim_create_user_command("FormatToggle", function(args)
	if args.bang then
		vim.b.disable_autoformat = not vim.b.disable_autoformat
	else
		vim.g.disable_autoformat = not vim.g.disable_autoformat
	end
end, { desc = "Toggle autoformat-on-save", bang = true })

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*.feature",
	command = "setlocal tabstop=2 shiftwidth=2",
})

api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	command = "silent! RustFmt",
})

-- -----------------------------------------------------------------------------
-- Plugin configuration
-- -----------------------------------------------------------------------------

safe_setup("catppuccin", { flavour = "mocha" })
pcall(vim.cmd.colorscheme, "catppuccin-mocha")

safe_setup("nvim-web-devicons")

vim.g.lightline = {
	active = {
		left = { { "mode", "paste" }, { "readonly", "filename", "modified", "gitbranch" } },
		right = { { "lineinfo" }, { "percent" }, { "fileformat", "fileencoding", "filetype" } },
	},
	component_function = { gitbranch = "FugitiveHead" },
}

safe_setup("which-key", {
	spec = {
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]ebug" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>t", group = "[T]est" },
		{ "<leader>s", group = "[S]earch" },
	},
})

safe_setup("barbar")

safe_setup("auto-session", {
	enabled = true,
	auto_restore = true,
	auto_save = true,
})

safe_setup("gitsigns", {
	signs = {
		add = { text = " " },
		change = { text = " " },
		delete = { text = " " },
		untracked = { text = "" },
		topdelete = { text = "󱂥 " },
		changedelete = { text = "󱂧 " },
	},
})

safe_setup("git-conflict")
safe_setup("git-worktree")

vim.g.mkdp_theme = "light"
pcall(function()
	if
		fn.exists("*mkdp#util#install") == 1 and not exists(plugin_path("markdown-preview.nvim") .. "/app/node_modules")
	then
		vim.schedule(function()
			pcall(fn["mkdp#util#install"])
		end)
	end
end)

safe_setup("mini.indentscope", {
	symbol = "│",
	options = { try_as_border = true },
})

safe_setup("mini.surround", {
	mappings = {
		add = "gsa",
		delete = "gsd",
		find = "gsf",
		find_left = "gsF",
		highlight = "gsh",
		replace = "gsr",
		update_n_lines = "gsn",
	},
})

safe_setup("oil", {
	keymaps = {
		["<C-r>"] = "actions.refresh",
		["y."] = "actions.copy_entry_path",
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["g."] = "actions.toggle_hidden",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
	},
	view_options = { show_hidden = true },
	win_options = {},
	skip_confirm_for_simple_edits = true,
})

safe_setup("flash")
safe_setup("nvim-autopairs", {
	fast_wrap = { chars = { "{", "[", "(", "'", '"' } },
})

local wilder = safe_require("wilder")
if wilder then
	pcall(wilder.setup, { modes = { ":", "/", "?" } })
end

local telescope = safe_require("telescope")
if telescope then
	local ok, err = pcall(telescope.setup, {
		defaults = {
			layout_config = { horizontal = { prompt_position = "top" } },
			sorting_strategy = "ascending",
		},
		pickers = {
			colorscheme = { enable_preview = true },
			live_grep = {
				additional_args = function()
					return { "--hidden" }
				end,
			},
		},
		extensions = {
			["ui-select"] = {
				specific_opts = { codeactions = true },
			},
		},
	})
	if not ok then
		notify("Could not setup telescope: " .. err)
	end
	for _, extension in ipairs({ "fzf", "file_browser", "ui-select", "undo", "git_worktree" }) do
		pcall(telescope.load_extension, extension)
	end
end

safe_setup("nvim-treesitter.configs", {
	ensure_installed = {
		"bash",
		"json",
		"lua",
		"make",
		"markdown",
		"nix",
		"rust",
		"java",
		"clojure",
		"elixir",
		"html",
		"javascript",
		"typescript",
		"go",
		"regex",
		"toml",
		"vim",
		"vimdoc",
		"xml",
		"helm",
		"yaml",
	},
	auto_install = true,
	highlight = { enable = true },
})
safe_setup("treesitter-context")

-- blink.cmp
local blink = safe_require("blink.cmp")
if blink then
	local ok, err = pcall(blink.setup, {
		signature = { enabled = true },
		completion = {
			ghost_text = { enabled = true },
			documentation = { auto_show = true },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "spell" },
			providers = {
				lsp = { score_offset = 100 },
				spell = {
					module = "blink-cmp-spell",
					name = "Spell",
					score_offset = -10,
					opts = {},
				},
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					score_offset = -15,
					min_keyword_length = 4,
					opts = {},
				},
			},
		},
		keymap = {
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-e>"] = { "hide" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<Enter>"] = { "select_and_accept", "fallback" },
			["<C-p>"] = { "snippet_backward", "fallback" },
			["<C-n>"] = { "snippet_forward", "fallback" },
		},
	})
	if not ok then
		notify("Could not setup blink.cmp: " .. err)
		blink = nil
	end
end

-- lint/format
local lint = safe_require("lint")
if lint then
	lint.linters.buf_lint = lint.linters.buf_lint or {}
	lint.linters.buf_lint.append_fname = false
	lint.linters.buf_lint.args = { "--exclude-path .idea" }
	lint.linters_by_ft = {
		proto = { "buf_lint" },
		lua = { "selene" },
		json = { "jsonlint" },
		go = { "golangcilint" },
	}
	api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
		callback = function()
			pcall(lint.try_lint)
		end,
	})
end

local null_ls = safe_require("null-ls")
if null_ls then
	local sources = {}
	local function add(source)
		if source then
			table.insert(sources, source)
		end
	end
	add(null_ls.builtins.formatting.alejandra)
	add(null_ls.builtins.formatting.goimports)
	add(null_ls.builtins.formatting.gofumpt)
	add(null_ls.builtins.formatting.sqlfluff)
	add(null_ls.builtins.formatting.stylua)
	null_ls.setup({ sources = sources })
end

local lsp_format = safe_require("lsp-format")
if lsp_format then
	lsp_format.setup({
		html = { exclude = { "harper_ls", "copilot" }, sync = true },
		nix = { exclude = { "harper_ls", "copilot" }, sync = true, force = true },
		rust = { exclude = { "harper_ls", "copilot" }, sync = true },
		go = { exclude = { "harper_ls", "copilot" }, sync = true },
	})
end

safe_setup("lspsaga", {
	lightbulb = { debounce = 500, sign = false },
	rename = { auto_save = false },
})

safe_setup("otter", {
	handle_leading_whitespace = true,
	settings = {
		strip_wrapping_quote_characters = { "'", '"', "`", "#" },
	},
})

-- -----------------------------------------------------------------------------
-- LSP
-- -----------------------------------------------------------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
if blink and type(blink.get_lsp_capabilities) == "function" then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

local function lsp_config(name, config)
	config = config or {}
	config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
	pcall(vim.lsp.config, name, config)
end

lsp_config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			codelenses = {
				gc_details = true,
				fieldalignment = true,
				run_govulncheck = true,
				generate = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
			},
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			hints = {
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				rageVariableTypes = true,
			},
			completeUnimported = true,
			staticcheck = true,
		},
	},
})

lsp_config("jdtls", {
	settings = {
		java = {
			format = {
				settings = {
					url = fn.expand("~/.config/java/Default.xml"),
					profile = "custom",
				},
			},
		},
	},
})

for _, server in ipairs({
	"protols",
	"helm_ls",
	"elixirls",
	"sqls",
	"ts_ls",
	"golangci_lint_ls",
	"nixd",
	"harper_ls",
	"clojure_lsp",
	"taplo",
	"eslint",
	"terraformls",
	"yamlls",
	"jsonls",
	"dockerls",
	"lemminx",
}) do
	lsp_config(server)
end

api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local bufnr = event.buf
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local function lsp_map(keys, rhs, desc, mode)
			keymap(mode or "n", keys, rhs, { buffer = bufnr, silent = true, desc = desc })
		end

		lsp_map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
		lsp_map("grt", function()
			require("telescope.builtin").lsp_definitions()
		end, "LSP: [G]oto [D]efinition")
		lsp_map("grr", function()
			require("telescope.builtin").lsp_references()
		end, "LSP: [G]oto [R]eferences")
		lsp_map("gri", function()
			require("telescope.builtin").lsp_implementations()
		end, "LSP: [G]oto [I]mplementation")
		lsp_map("grT", function()
			require("telescope.builtin").lsp_type_definitions()
		end, "LSP: Type [D]efinition")
		lsp_map("<leader>ld", function()
			require("telescope.builtin").lsp_document_symbols()
		end, "LSP: [D]ocument [S]ymbols")
		lsp_map("<leader>lw", function()
			require("telescope.builtin").lsp_dynamic_workspace_symbols()
		end, "LSP: [W]orkspace [S]ymbols")

		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = bufnr,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = bufnr,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
			api.nvim_create_autocmd("LspDetach", {
				group = api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			lsp_map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
			end, "LSP: [T]oggle Inlay [H]ints")
		end

		if lsp_format and not vim.g.disable_autoformat and not vim.b[bufnr].disable_autoformat then
			pcall(lsp_format.on_attach, client, bufnr)
		end

		if not blink and client and client:supports_method("textDocument/completion") then
			pcall(vim.lsp.completion.enable, true, client.id, bufnr, { autotrigger = true })
		end
	end,
})

for _, server in ipairs({
	"protols",
	"helm_ls",
	"elixirls",
	"sqls",
	"ts_ls",
	"gopls",
	"golangci_lint_ls",
	"nixd",
	"harper_ls",
	"clojure_lsp",
	"taplo",
	"eslint",
	"terraformls",
	"yamlls",
	"jsonls",
	"dockerls",
	"lemminx",
	"jdtls",
}) do
	pcall(vim.lsp.enable, server)
end

-- -----------------------------------------------------------------------------
-- DAP
-- -----------------------------------------------------------------------------

local dap = safe_require("dap")
if dap then
	fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
	fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition" })
	fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
end

safe_setup("nvim-dap-virtual-text")
safe_setup("dap-go")

local codelldb = fn.exepath("codelldb")
if codelldb ~= "" then
	safe_setup("dap-lldb", { codelldb_path = codelldb })
else
	safe_setup("dap-lldb")
end

safe_setup("dapui", {
	icons = {
		expanded = "▾",
		collapsed = "▸",
		current_frame = "*",
	},
	controls = {
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "⏎",
			step_over = "⏭",
			step_out = "⏮",
			step_back = "b",
			run_last = "▶▶",
			terminate = "⏹",
			disconnect = "⏏",
		},
	},
})

if dap then
	local dapui = safe_require("dapui")
	if dapui then
		dap.listeners.after.event_initialized.dapui_config = dapui.open
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close
	end
end

_G.get_args = function()
	local args = fn.input("Args: ")
	return vim.split(args, " ", { trimempty = true })
end

-- -----------------------------------------------------------------------------
-- Testing
-- -----------------------------------------------------------------------------

local neotest = safe_require("neotest")
if neotest then
	local adapters = {}
	local function add_adapter(mod, opts)
		local adapter = safe_require(mod)
		if adapter then
			local ok, configured = pcall(adapter, opts or {})
			table.insert(adapters, ok and configured or adapter)
		end
	end

	add_adapter("neotest-golang", { dap_go_enabled = true })
	add_adapter("neotest-java", { junit_jar = vim.env.JUNIT_JAR or vim.env.JUNIT_PLATFORM_CONSOLE_STANDALONE_JAR })
	add_adapter("neotest-rust", { dap_adapter = "lldb", args = { "--no-capture" } })

	local ok, err = pcall(neotest.setup, {
		adapters = adapters,
		log_level = "debug",
		diagnostic = { severity = "info" },
		output = { enabled = true },
		output_panel = { enabled = true, open = "botright split | resize 15" },
		quickfix = { enabled = false },
	})
	if not ok then
		notify("Could not setup neotest: " .. err)
	end
end

-- -----------------------------------------------------------------------------
-- Keymaps
-- -----------------------------------------------------------------------------

local map_opts = { silent = true }
local function map(mode, lhs, rhs, opts)
	keymap(mode, lhs, rhs, vim.tbl_extend("force", map_opts, opts or {}))
end

map({ "n", "v" }, "L", "$")
map({ "n", "v" }, "H", "^")
map("n", "<leader>uid", function()
	local uuid = fn.system("uuidgen"):gsub("\n", ""):lower()
	api.nvim_put({ uuid }, "", true, true)
end, { desc = "Put UUID" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<leader>cp", "<cmd>MarkdownPreview<cr>", { desc = "Markdown Preview" })
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit (root dir)" })
map("n", "<leader>glb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Blame current line" })
map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open file tree" })
map("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", { desc = "File browser" })
map("n", "<leader>ut", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undotree" })
map("n", "<leader>fE", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "File browser" })
map("n", "<C-t>", function()
	require("telescope.builtin").live_grep({ default_text = "TODO", initial_mode = "normal" })
end)

-- Harpoon
map("n", "<leader>ha", function()
	require("harpoon"):list():add()
end)
map("n", "<C-e>", function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end)
for i = 1, 5 do
	map("n", "<leader>" .. i, function()
		require("harpoon"):list():select(i)
	end)
end

map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Enbale git blame" })

-- DAP
map("n", "<leader>dB", function()
	require("dap").set_breakpoint(fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint Condition" })
map("n", "<leader>db", ":DapToggleBreakpoint<cr>", { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", ":DapContinue<cr>", { desc = "Continue" })
map("n", "<leader>da", function()
	require("dap").continue({ before = _G.get_args })
end, { desc = "Run with Args" })
map("n", "<leader>dC", function()
	require("dap").run_to_cursor()
end, { desc = "Run to cursor" })
map("n", "<leader>dg", function()
	require("dap").goto_()
end, { desc = "Go to line (no execute)" })
map("n", "<leader>di", ":DapStepInto<cr>", { desc = "Step into" })
map("n", "<leader>dj", function()
	require("dap").down()
end, { desc = "Down" })
map("n", "<leader>dk", function()
	require("dap").up()
end, { desc = "Up" })
map("n", "<leader>dl", function()
	require("dap").run_last()
end, { desc = "Run Last" })
map("n", "<leader>do", ":DapStepOut<cr>", { desc = "Step Out" })
map("n", "<leader>dO", ":DapStepOver<cr>", { desc = "Step Over" })
map("n", "<leader>dp", function()
	require("dap").pause()
end, { desc = "Pause" })
map("n", "<leader>dr", ":DapToggleRepl<cr>", { desc = "Toggle REPL" })
map("n", "<leader>ds", function()
	require("dap").session()
end, { desc = "Session" })
map("n", "<leader>dt", ":DapTerminate<cr>", { desc = "Terminate" })
map("n", "<leader>du", function()
	require("dapui").toggle()
end, { desc = "Dap UI" })
map("n", "<leader>dw", function()
	require("dap.ui.widgets").hover()
end, { desc = "Widgets" })
map({ "n", "v" }, "<leader>de", function()
	require("dapui").eval()
end, { desc = "Eval" })

-- Tests
map("n", "<leader>tt", function()
	require("neotest").run.run(fn.expand("%"))
end, { desc = "Run File" })
map("n", "<leader>tT", function()
	require("neotest").run.run(vim.uv.cwd())
end, { desc = "Run All Test Files" })
map("n", "<leader>tr", function()
	require("neotest").run.run()
end, { desc = "Run Nearest" })
map("n", "<leader>td", function()
	require("neotest").run.run({ strategy = "dap" })
end, { desc = "Run Nearest with debugger" })
map("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Toggle Summary" })
map("n", "<leader>to", function()
	require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "Show Output" })
map("n", "<leader>tO", function()
	require("neotest").output_panel.toggle()
end, { desc = "Toggle Output Panel" })
map("n", "<leader>tS", function()
	require("neotest").run.stop()
end, { desc = "Stop" })

-- Gitsigns/Fugitive/conflicts/worktrees
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
map("n", "<leader>ph", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
map("n", "<leader>hdt", "<cmd>Gvdiffsplit!<cr>", { desc = "Diff this" })
map("n", "ga", "<cmd>diffget //2<cr>", { desc = "Accept left" })
map("n", "gl", "<cmd>diffget //3<cr>", { desc = "Accept right" })
map("n", "<leader>gwt", "<cmd>Telescope git_worktree git_worktree<cr>", { desc = "Worktree telescope" })
map("n", "<leader>gwc", "<cmd>Telescope git_worktree create_git_worktree<cr>", { desc = "Worktree create" })
map("n", "]c", "<cmd>GitConflictNextConflict<CR>")
map("n", "[c", "<cmd>GitConflictPrevConflict<CR>")

-- Lspsaga
map({ "n", "v" }, "gra", "<cmd>Lspsaga code_action<cr>", { desc = "LSP code action" })
map({ "n", "v" }, "grn", "<cmd>Lspsaga rename<cr>", { desc = "LSP rename" })
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next diagnostic" })
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Previous diagnostic" })

-- Buffers
map("n", "]b", "<cmd>BufferNext<CR>", { desc = "Buffer next" })
map("n", "[b", "<cmd>BufferPrevious<CR>", { desc = "Buffer previous" })
map("n", "d<TAB>", "<Cmd>BufferClose!<CR>")
map("n", "D<TAB>", "<Cmd>BufferCloseAllButCurrent<CR>")
map("i", "<C-[>", "<Esc>", { noremap = true })

-- Flash
map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
map("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
map("c", "<C-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- Telescope
local function telescope_builtin(name, opts)
	return function()
		require("telescope.builtin")[name](opts or {})
	end
end

map("n", "<leader>sh", telescope_builtin("help_tags"), { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", telescope_builtin("keymaps"), { desc = "[S]earch [K]eymaps" })
map("n", "<leader>ss", telescope_builtin("builtin"), { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>sw", telescope_builtin("grep_string"), { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", telescope_builtin("live_grep"), { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", telescope_builtin("diagnostics"), { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", telescope_builtin("resume"), { desc = "[S]earch [ ]esume" })
map("n", "<leader>sf", telescope_builtin("oldfiles"), { desc = "[S]earch Recent Files ('.' for repeat)" })
map("n", "<leader><leader>", telescope_builtin("buffers"), { desc = "[ ] Find existing buffers" })
map("n", "<leader>:", telescope_builtin("command_history"), { desc = "Command History" })
map("n", "<leader>b", telescope_builtin("buffers"), { desc = "+buffer" })
map("n", "<leader>ff", telescope_builtin("find_files"), { desc = "Find project files" })
map("n", "<C-p>", telescope_builtin("git_files"), { desc = "Search git files" })
map("n", "<leader>gc", telescope_builtin("git_commits"), { desc = "Commits" })
map("n", "<leader>gs", telescope_builtin("git_status"), { desc = "Status" })
map("n", "<leader>sa", telescope_builtin("autocommands"), { desc = "Auto Commands" })
map("n", "<leader>sb", telescope_builtin("current_buffer_fuzzy_find"), { desc = "Buffer" })
map("n", "<leader>sC", telescope_builtin("commands"), { desc = "Commands" })
map("n", "<leader>sD", telescope_builtin("diagnostics"), { desc = "Workspace diagnostics" })
map("n", "<leader>sH", telescope_builtin("highlights"), { desc = "Search Highlight Groups" })
map("n", "<leader>sM", telescope_builtin("man_pages"), { desc = "Man pages" })
map("n", "<leader>sm", telescope_builtin("marks"), { desc = "Jump to Mark" })
map("n", "<leader>so", telescope_builtin("vim_options"), { desc = "Options" })
map("n", "<leader>sR", telescope_builtin("resume"), { desc = "Resume" })
map("n", "<leader>uC", telescope_builtin("colorscheme"), { desc = "Colorscheme preview" })
