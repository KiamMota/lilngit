-- git-shit.nvim
-- Simple git commands plugin for Neovim
-- 
-- Installation:
-- 1. Save this file as ~/.config/nvim/lua/git-shit.lua
-- 2. In your init.lua or init.vim, add: require('git-shit')
--
-- Shortcuts:
-- <leader>gc  - Git commit (opens input for commit message)
-- <leader>gps - Git push (opens input for branch name)
-- <leader>gpl - Git pull (opens input for branch name)
-- <leader>gs  - Git status (shows repository status)

local M = {}

-- Function to run git command and show output in info buffer
local function run_git_command(cmd, callback)
  local output = {}
  
  -- Execute command and capture output
  local handle = io.popen(cmd .. " 2>&1")
  if handle then
    for line in handle:lines() do
      table.insert(output, line)
    end
    handle:close()
  end
  
  -- Show output in Neovim's message buffer
  for _, line in ipairs(output) do
    vim.api.nvim_echo({{line, "Normal"}}, true, {})
  end
  
  if callback then
    callback(output)
  end
  
  return output
end

-- Function for git commit
function M.git_commit()
  vim.ui.input({
    prompt = "Commit message: ",
    default = ""
  }, function(commit_msg)
    if commit_msg and commit_msg ~= "" then
      -- Add all files
      vim.api.nvim_echo({{"Running: git add .", "Title"}}, true, {})
      run_git_command("git add .")
      
      -- Commit
      vim.api.nvim_echo({{"Running: git commit -m '" .. commit_msg .. "'", "Title"}}, true, {})
      run_git_command("git commit -m '" .. commit_msg:gsub("'", "'\\''") .. "'")
    else
      vim.api.nvim_echo({{"Commit cancelled", "WarningMsg"}}, true, {})
    end
  end)
end

-- Function for git push
function M.git_push()
  vim.ui.input({
    prompt = "Branch name: ",
    default = "main"
  }, function(branch)
    if branch and branch ~= "" then
      vim.api.nvim_echo({{"Running: git push origin " .. branch, "Title"}}, true, {})
      run_git_command("git push origin " .. branch)
    else
      vim.api.nvim_echo({{"Push cancelled", "WarningMsg"}}, true, {})
    end
  end)
end

-- Function for git pull
function M.git_pull()
  vim.ui.input({
    prompt = "Branch name: ",
    default = "main"
  }, function(branch)
    if branch and branch ~= "" then
      vim.api.nvim_echo({{"Running: git pull origin " .. branch, "Title"}}, true, {})
      run_git_command("git pull origin " .. branch)
    else
      vim.api.nvim_echo({{"Pull cancelled", "WarningMsg"}}, true, {})
    end
  end)
end

-- Function for git status
function M.git_status()
  vim.api.nvim_echo({{"Running: git status", "Title"}}, true, {})
  run_git_command("git status")
end

-- Create shortcuts with <leader>
function M.setup()
  -- <leader>gc - Git Commit
  vim.keymap.set('n', '<leader>gc', function()
    M.git_commit()
  end, { desc = 'Git Commit', silent = true })
  
  -- <leader>gps - Git Push
  vim.keymap.set('n', '<leader>gps', function()
    M.git_push()
  end, { desc = 'Git Push', silent = true })
  
  -- <leader>gpl - Git Pull
  vim.keymap.set('n', '<leader>gpl', function()
    M.git_pull()
  end, { desc = 'Git Pull', silent = true })
  
  -- <leader>gs - Git Status
  vim.keymap.set('n', '<leader>gs', function()
    M.git_status()
  end, { desc = 'Git Status', silent = true })
  
  vim.api.nvim_echo({{"git-shit.nvim loaded! Shortcuts: <leader>gc, <leader>gps, <leader>gpl, <leader>gs", "Title"}}, true, {})
end

-- Auto-setup when module is loaded
M.setup()

return M
