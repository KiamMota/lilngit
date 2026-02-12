# lilngit.nvim

Simple and direct git commands plugin for Neovim.

## Installation

### Method 1: Manual Installation

1. Copy the file `lilngit.nvim.lua` to `~/.config/nvim/lua/lilngit.lua`

2. In your `~/.config/nvim/init.lua`, add:
```lua
require('lilngit')
```

Or if you use `init.vim`:
```vim
lua require('lilngit')
```

### Method 2: With plugin manager (lazy.nvim)

Add to your `lazy.nvim`:

```lua
{
  dir = "~/.config/nvim/lua/",
  name = "lilngit",
  config = function()
    require('lilngit')
  end
}
```

### Method 3: With Packer

```lua
use {
  '~/.config/nvim/lua/lilngit.lua',
  config = function()
    require('lilngit')
  end
}
```

## Shortcuts

### `<leader>gc` - Git Commit
- Opens an input field to type the commit message
- Automatically runs `git add .` before committing
- Executes `git commit -m "your message"`
- All git output appears in Neovim's info buffer

### `<leader>gps` - Git Push
- Opens an input field to type the branch name
- Default suggested branch: `main`
- Executes `git push origin <branch>`
- Output appears in the info buffer

### `<leader>gpl` - Git Pull
- Opens an input field to type the branch name
- Default suggested branch: `main`
- Executes `git pull origin <branch>`
- Output appears in the info buffer

### `<leader>gs` - Git Status
- Shows the repository status
- Executes `git status`
- Output appears in the info buffer

## Usage Examples

1. Check repository status:
   ```
   <leader>gs
   ```

2. Make a commit:
   ```
   <leader>gc
   [Type message] fix: fixing form bug
   ```

3. Push:
   ```
   <leader>gps
   [Type branch] main
   ```

4. Pull:
   ```
   <leader>gpl
   [Type branch] develop
   ```

## Notes

- By default, `<leader>` in Neovim is the `\` key (backslash)
- You can change the leader in your `init.lua` with: `vim.g.mapleader = ' '` (space, for example)
- All commands show git output in Neovim's message buffer
- If you cancel the input (ESC), the command is aborted
- `git add .` in `<leader>gc` adds ALL modified files

## License

MIT - Do whatever you want with this code!
