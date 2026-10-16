-- ============================================================
-- General settings
-- ============================================================

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt
local map = vim.keymap.set

-- Editing and display
opt.compatible = false
opt.number = true
opt.wrap = false
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.showmatch = true
opt.list = true
opt.autowrite = true
opt.autowriteall = true

-- Backup and swap files
opt.directory:remove(".")
opt.backupdir:prepend(vim.fn.expand("~/.vim/_backup//"))
opt.directory:prepend(vim.fn.expand("~/.vim/_temp//"))

-- List characters
local function set_listchars(show_tabs)
    local chars = {
        extends = ">",
        precedes = "<",
        trail = ".",
    }

    if show_tabs then
        chars.tab = "-."
    else
        chars.tab = "  "
    end

    opt.listchars = chars
end

vim.api.nvim_create_user_command("ShowTabs", function()
    set_listchars(true)
end, {})

vim.api.nvim_create_user_command("HideTabs", function()
    set_listchars(false)
end, {})

set_listchars(false)

-- ============================================================
-- General key mappings
-- ============================================================

map("i", "jj", "<Esc>")

map("n", "<C-Tab>", ":bnext<CR>")
map("n", "<C-S-Tab>", ":bprevious<CR>")

map("n", "<leader>lc", ":lclose<CR>")
map("n", "<leader>noh", ":nohlsearch<CR>")
map("n", "<C-1>", ":w<CR>")
map("n", "<leader>qq", ":q<CR>")
map("n", "<leader>qa", ":qa<CR>")
map("n", "<leader>ww", ":w<CR>")
map("n", "<leader>ee", ":Bclose<CR>")
map("n", "<leader>ra", ":bufdo e!<CR>")

map("n", "<leader>mm", ":make<CR>")
map("n", "<leader>co", ":copen<CR>")
map("n", "<leader>sm", ":messages<CR>")

map("n", "<leader>zw", ":ZoomWin<CR>")
map("n", "<leader>nt", ":NERDTreeToggle<CR>")

map("n", "<leader>ev", ":vsplit $MYVIMRC<CR>")
map("n", "<leader>sv", ":source $MYVIMRC<CR>")

map("n", "<leader>grr", ":!git co %<CR>")
map("n", "<leader>ccl", ":ccl<CR>")
map("n", "<leader>lia", ":cl<CR>")

vim.keymap.set("n", "<leader>gto", vim.lsp.buf.definition, {
    desc = "Go to definition",
    silent = true,
})

vim.keymap.set("n", "<leader>gtr", vim.lsp.buf.references, {
    desc = "Find references",
})

vim.keymap.set("n", "<leader>rrr", vim.lsp.buf.rename, {
    desc = "Rename symbol",
})

vim.keymap.set("n", "<leader>caa", vim.lsp.buf.code_action, {
    desc = "Code actions",
})

vim.keymap.set("n", "<leader>gti", vim.lsp.buf.implementation, {
    desc = "Go to implementation",
    silent = true,
})

vim.keymap.set("n", "<space>e", function()
    vim.diagnostic.open_float(nil, { scope = "cursor" })
end, { desc = "Show diagnostic message" })

map("n", "<leader>su", function()
    vim.cmd("sign unplace * buffer=" .. vim.api.nvim_get_current_buf())
end)

-- Change to the directory containing the current file
map("n", "<leader>cd", ":lcd %:h<CR>", { silent = true })

-- Underline current line with '='
map("n", "<leader>ul", ":t.<CR>Vr=", { silent = true })

-- Toggle wrapping
map("n", "<leader>tw", function()
    opt.wrap = not opt.wrap
    print("wrap = " .. tostring(opt.wrap:get()))
end, { silent = true })

-- Bubble lines up/down in visual mode
map("x", "<C-k>", "[egv")
map("x", "<C-j>", "]egv")

-- Shift-Insert behaves like middle mouse paste
map({ "n", "v" }, "<S-Insert>", "<MiddleMouse>")
map("!", "<S-Insert>", "<MiddleMouse>")

-- System clipboard
map("x", "<Space>y", '"+y')
map("n", "<Space>y", '"+yy')
map("n", "<leader>yy", '"+yy')
map("n", "<leader>pp", '"+p')
map("n", "<Space>p", '"+p')

vim.opt.grepprg = "rg --vimgrep --smart-case"

-- Common spelling corrections
vim.cmd([[
iabbrev waht what
iabbrev tehn then
]])

-- ============================================================
-- Diagnostics Automatically Show on CursorHold
-- ============================================================

--vim.o.updatetime = 300

--vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --callback = function()
        --vim.diagnostic.open_float(nil, { focus = false })
        --end,
        --})

-- ============================================================
-- Custom commands
-- ============================================================

-- These shell-based commands retain the behaviour of your
-- original Vimscript configuration.

vim.cmd([[
    command! -range StripLastChar <line1>,<line2>!rev | cut -c 2- | rev
    command! -range -nargs=1 StripLastChars <line1>,<line2>!rev | cut -c <f-args>- | rev
    command! -range -nargs=1 StripFirstChars <line1>,<line2>!cut -c <f-args>-
    command! -range TrimFront <line1>,<line2>!sed 's/^[ \t]*//g'
    command! Spacify :.s/\t/    /g
    command! SpacifyAll :%!expand -t4
    command! TabifyAll :%!unexpand -t4
    command! -range AddNumbers :<line1>,<line2>!nl | sed 's/ *//g'
]])

-- ============================================================
-- Language-specific settings
-- ============================================================

-- ============================================================
-- C# settings
-- ============================================================

local function build(path)
  vim.cmd("botright split")
  vim.cmd("terminal dotnet build " .. vim.fn.shellescape(path))
  vim.cmd("startinsert")
end

local function find_current_project()
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.fnamemodify(file, ":h")

  local projects = vim.fs.find(function(name)
    return name:match("%.csproj$") ~= nil
  end, {
    path = dir,
    upward = true,
  })

  return projects[1]
end

local function pick_and_build(pattern, title)
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  builtin.find_files({
    prompt_title = title,
    cwd = vim.fn.getcwd(),
    find_command = {
      "rg", "--files", "--hidden",
      "-g", pattern,
      "-g", "!**/bin/**",
      "-g", "!**/obj/**",
      "-g", "!**/.git/**",
    },
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        if not entry then
          return
        end

        local path = entry.path or entry.filename or entry.value
        actions.close(prompt_bufnr)

        vim.schedule(function()
          build(path)
        end)
      end)

      return true
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function(event)
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4

        local opts = { buffer = event.buf }

        -- Format C# with CSharpier
        vim.keymap.set("n", "<leader>fff", function()
            local cmd = { "csharpier", "format", "--write-stdout" }
            local input = table.concat(
                vim.api.nvim_buf_get_lines(event.buf, 0, -1, false),
                "\n"
            )

            local output = vim.fn.system(cmd, input)

            if vim.v.shell_error ~= 0 then
                vim.notify(
                    "CSharpier failed:\n" .. output,
                    vim.log.levels.ERROR
                )
                return
            end

            local lines = vim.split(output, "\n", { plain = true })
            if lines[#lines] == "" then
                table.remove(lines)
            end

            vim.api.nvim_buf_set_lines(event.buf, 0, -1, false, lines)
            vim.bo[event.buf].modified = true
        end, vim.tbl_extend("force", opts, {
            desc = "Format C# with CSharpier",
        }))

        -- Build the current project's nearest .csproj
        vim.keymap.set("n", "<leader>bbb", function()
            local project = find_current_project()

            if not project then
                vim.notify("No .csproj found", vim.log.levels.ERROR)
                return
            end

            build(project)
        end, vim.tbl_extend("force", opts, {
            desc = "Build current C# project",
        }))

        -- Pick a project to build
        vim.keymap.set("n", "<leader>bbp", function()
            pick_and_build("*.csproj", "Build C# Project")
        end, vim.tbl_extend("force", opts, {
            desc = "Pick C# project to build",
        }))

        -- Pick a solution to build
        vim.keymap.set("n", "<leader>bbs", function()
            pick_and_build(
                { "*.sln", "*.slnx" },
                "Build Solution"
            )
        end, vim.tbl_extend("force", opts, {
            desc = "Pick C# solution to build",
        }))
    end,
})


-- Lua settings
--
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
})

-- ============================================================
-- Plugins (vim-plug)
-- ============================================================

vim.cmd([[
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-git'

Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'

Plug 'vim-airline/vim-airline'
Plug 'vadimr/bclose.vim'

Plug 'flazz/vim-colorschemes'
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'doums/darcula'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.2.2' }
Plug 'natecraddock/telescope-zf-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'seblyng/roslyn.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'mason-org/mason.nvim'
Plug 'mason-org/mason-lspconfig.nvim'

call plug#end()
]])

-- ============================================================
-- Coc.nvim
-- ============================================================

vim.g.coc_global_extensions = {
    --"coc-tsserver",
    --"coc-json",
    --"coc-pyright",
    --"coc-rust-analyzer",
    --"coc-go",
    --"coc-clangd",
}

vim.opt.statusline:prepend("%{coc#status()}")

local function check_backspace()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

map("i", "<Tab>", function()
    if vim.fn["coc#pum#visible"]() == 1 then
        return vim.fn["coc#pum#next"](1)
    elseif check_backspace() then
        return "\t"
    else
        return vim.fn["coc#refresh"]()
    end
end, { expr = true, silent = true })

map("i", "<S-Tab>", function()
    if vim.fn["coc#pum#visible"]() == 1 then
        return vim.fn["coc#pum#prev"]()
    end
    return "<C-h>"
end, { expr = true, silent = true })

map("i", "<CR>", function()
    if vim.fn["coc#pum#visible"]() == 1 then
        return vim.fn["coc#pum#confirm"]()
    end
    return "<C-g>u<CR><C-r>=coc#on_enter()<CR>"
end, { expr = true, silent = true })

map("n", "[c", "<Plug>(coc-diagnostic-prev)")
map("n", "]c", "<Plug>(coc-diagnostic-next)")
map("n", "gd", "<Plug>(coc-definition)")
map("n", "gy", "<Plug>(coc-type-definition)")
map("n", "gi", "<Plug>(coc-implementation)")
map("n", "gr", "<Plug>(coc-references)")
map("n", "<leader>rn", "<Plug>(coc-rename)")

-- ============================================================
-- Telescope
-- ============================================================

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        -- Use the existing terminal-friendly defaults.
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
            },
        },
    },
    extensions = {
        -- Configuration can be added here if needed.
    },
})

telescope.load_extension("zf-native")

-- <Space>f: list all open buffers
map("n", "<Space>f", builtin.buffers, {
    desc = "Find open buffers",
})

-- <Space>u: recursively find files from the current working
-- directory, respecting .gitignore.
map("n", "<Space>u", function()
    builtin.find_files({
        cwd = vim.fn.getcwd(),
        hidden = true,
        no_ignore = false,
    })
end, {
desc = "Find files",
})

-- Optional extra Telescope mappings
map("n", "<leader>fg", builtin.live_grep, {
    desc = "Search text in files",
})

map("n", "<leader>fh", builtin.help_tags, {
    desc = "Search Neovim help",
})

-- Enable Tree-sitter highlighting for C#

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cs", "c_sharp" },
    callback = function()
        vim.treesitter.start()
    end,
})

-- ============================================================
-- Mason LSP Config
-- ============================================================

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        --"pyright",
        "rust_analyzer",
        "gopls",
        --"clangd",
        "jsonls",
        --"lua_ls",
        --"roslyn",
    },
})

-- ============================================================
-- C# / Roslyn
-- ============================================================

require("roslyn").setup({
    -- Keep the defaults initially.
})

vim.lsp.config("html", {})
vim.lsp.enable("html")

vim.lsp.config("roslyn", {
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
        },
    },
})

-- ============================================================
-- C# / Roslyn
-- ============================================================

vim.lsp.enable("roslyn")

require("roslyn").setup({
    -- Keep the defaults initially.
})

vim.lsp.config("roslyn", {
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
        },
    },
})

vim.lsp.enable("roslyn")

-- ============================================================
-- LSP Completion
-- ============================================================


vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(
                true,
                client.id,
                args.buf,
                { autotrigger = true }
            )
        end
    end,
})

-- ============================================================

vim.cmd.colorscheme("evening")

-- ============================================================
-- Tree-sitter highlight colours
-- ============================================================

local function set_csharp_highlights()
    local highlights = {
        -- Keywords: public, class, return, async, etc.
        ["@keyword"] = { fg = "#C586C0" },
        ["@keyword.modifier"] = { fg = "#C586C0" },
        ["@keyword.type"] = { fg = "#C586C0" },

        -- Types and interfaces
        ["@type"] = { fg = "#4EC9B0" },
        ["@type.builtin"] = { fg = "#569CD6" },
        ["@constructor"] = { fg = "#4EC9B0" },

        -- Methods and functions
        ["@function"] = { fg = "#DCDCAA" },
        ["@function.call"] = { fg = "#DCDCAA" },
        ["@function.method"] = { fg = "#DCDCAA" },
        ["@function.method.call"] = { fg = "#DCDCAA" },

        -- Variables and parameters
        ["@variable"] = { fg = "#9CDCFE" },
        ["@variable.parameter"] = { fg = "#9CDCFE" },
        ["@variable.member"] = { fg = "#9CDCFE" },

        -- Literals and comments
        ["@string"] = { fg = "#CE9178" },
        ["@number"] = { fg = "#B5CEA8" },
        ["@boolean"] = { fg = "#569CD6" },
        ["@comment"] = { fg = "#6A9955", italic = true },

        -- Attributes such as [Obsolete]
        ["@attribute"] = { fg = "#DCDCAA" },
    }

    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_csharp_highlights,
})

set_csharp_highlights()

-- ============================================================
-- Temporary fix for this version of Neovim (0.9.0) where semantic tokens cause 100% CPU usage in insert mode
-- ============================================================
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      -- Strips semantic tokens globally to prevent the 100% CPU insert mode hang
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
