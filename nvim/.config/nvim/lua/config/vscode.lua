local vscode = require("vscode")
local map = vim.keymap.set

-- Même leader que LazyVim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Options de base (alignées sur LazyVim)
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 300

local function action(name)
  return function()
    vscode.action(name)
  end
end

-- Fichiers / recherche
map("n", "<leader><space>", action("workbench.action.quickOpen"), { desc = "Find files" })
map("n", "<leader>ff", action("workbench.action.quickOpen"), { desc = "Find files" })
map("n", "<leader>fr", action("workbench.action.openRecent"), { desc = "Recent" })
map("n", "<leader>/", action("workbench.action.findInFiles"), { desc = "Grep" })
map("n", "<leader>sg", action("workbench.action.findInFiles"), { desc = "Grep" })
map("n", "<leader>ss", action("workbench.action.gotoSymbol"), { desc = "Goto symbol" })
map("n", "<leader>sS", action("workbench.action.showAllSymbols"), { desc = "Workspace symbol" })
map("n", "<leader>,", action("workbench.action.showAllEditors"), { desc = "Switch buffer" })
map("n", "<leader>e", action("workbench.view.explorer"), { desc = "Explorer" })

-- Buffers
map("n", "<S-h>", action("workbench.action.previousEditor"), { desc = "Prev buffer" })
map("n", "<S-l>", action("workbench.action.nextEditor"), { desc = "Next buffer" })
map("n", "<leader>bd", action("workbench.action.closeActiveEditor"), { desc = "Delete buffer" })
map("n", "<leader>bo", action("workbench.action.closeOtherEditors"), { desc = "Delete other buffers" })

-- Code (LSP)
map("n", "gd", action("editor.action.revealDefinition"), { desc = "Goto definition" })
map("n", "gr", action("editor.action.goToReferences"), { desc = "References" })
map("n", "gI", action("editor.action.goToImplementation"), { desc = "Implementation" })
map("n", "gy", action("editor.action.goToTypeDefinition"), { desc = "Type definition" })
map("n", "K", action("editor.action.showHover"), { desc = "Hover" })
map({ "n", "v" }, "<leader>ca", action("editor.action.quickFix"), { desc = "Code action" })
map("n", "<leader>cr", action("editor.action.rename"), { desc = "Rename" })
map({ "n", "v" }, "<leader>cf", action("editor.action.formatDocument"), { desc = "Format" })
map("n", "<leader>cd", action("editor.action.marker.next"), { desc = "Next diagnostic" })
map("n", "]d", action("editor.action.marker.next"), { desc = "Next diagnostic" })
map("n", "[d", action("editor.action.marker.prev"), { desc = "Prev diagnostic" })

-- Git
map("n", "<leader>gg", action("workbench.view.scm"), { desc = "Source control" })
map("n", "]h", action("workbench.action.editor.nextChange"), { desc = "Next hunk" })
map("n", "[h", action("workbench.action.editor.previousChange"), { desc = "Prev hunk" })

-- Fenêtres / splits
map("n", "<leader>-", action("workbench.action.splitEditorDown"), { desc = "Split below" })
map("n", "<leader>|", action("workbench.action.splitEditorRight"), { desc = "Split right" })
map("n", "<C-h>", action("workbench.action.navigateLeft"), { desc = "Go left" })
map("n", "<C-j>", action("workbench.action.navigateDown"), { desc = "Go down" })
map("n", "<C-k>", action("workbench.action.navigateUp"), { desc = "Go up" })
map("n", "<C-l>", action("workbench.action.navigateRight"), { desc = "Go right" })

-- Terminal / debug
map("n", "<leader>ft", action("workbench.action.terminal.toggleTerminal"), { desc = "Terminal" })
map("n", "<leader>db", action("editor.debug.action.toggleBreakpoint"), { desc = "Toggle breakpoint" })
map("n", "<leader>dc", action("workbench.action.debug.continue"), { desc = "Continue" })
map("n", "<leader>do", action("workbench.action.debug.stepOver"), { desc = "Step over" })
map("n", "<leader>di", action("workbench.action.debug.stepInto"), { desc = "Step into" })

-- Commentaires (gcc / gc en visuel)
map({ "n", "v" }, "gc", "<Plug>VSCodeCommentary", { remap = true })
map("n", "gcc", "<Plug>VSCodeCommentaryLine", { remap = true })

-- Quitter / sauver
map("n", "<leader>w", action("workbench.action.files.save"), { desc = "Save" })
map("n", "<leader>qq", action("workbench.action.closeWindow"), { desc = "Quit" })

-- Navigation dans les lignes enroulées
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
