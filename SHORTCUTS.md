# Neovim Shortcuts Reference

> **Leader key**: `Space` | **Modes**: `n` = Normal, `i` = Insert, `v` = Visual, `t` = Terminal

---

## General

| Key | Action |
|---|---|
| `SPC w` | Save file |
| `SPC q` | Quit |
| `SPC /` | Clear search highlight |
| `SPC Enter` | Reload config |
| `SPC SPC` | Switch to last buffer |
| `SPC A` | Select all |
| `SPC D` | Duplicate line |

## Navigation & Scrolling

| Key | Action |
|---|---|
| `Ctrl+d` | Scroll down (centered) |
| `Ctrl+u` | Scroll up (centered) |
| `n` / `N` | Next/prev search (centered) |
| `Ctrl+h/j/k/l` | Move focus between windows |

## Clipboard

| Key | Action | Mode |
|---|---|---|
| `SPC y` | Copy to system clipboard | n, v |
| `SPC Y` | Copy entire file to clipboard | n |
| `SPC p` | Paste without overwriting register | v |

## Indenting

| Key | Action | Mode |
|---|---|---|
| `<` | Indent left (stays in visual) | v |
| `>` | Indent right (stays in visual) | v |
| `J` | Move selection down | v |
| `K` | Move selection up | v |

---

## 🤖 GitHub Copilot

| Key | Action | Mode |
|---|---|---|
| `Tab` | Accept suggestion | i |
| `Ctrl+]` | Next suggestion | i |
| `Ctrl+K` | Previous suggestion | i |
| `Ctrl+H` | Dismiss suggestion | i |
| `Ctrl+\` | Trigger suggestion | i |

**Commands**: `:Copilot auth` · `:Copilot status` · `:Copilot enable/disable` · `:Copilot panel`

---

## 🔍 Telescope (Fuzzy Finder)

| Key | Action |
|---|---|
| `SPC ff` | Find files |
| `SPC fg` | Live grep |
| `SPC fb` | Find buffers |
| `SPC fr` | Recent files |
| `SPC fh` | Help tags |
| `SPC fc` | Commands |
| `SPC fk` | Keymaps |
| `SPC fs` | Find string under cursor |
| `SPC fd` | Diagnostics |
| `SPC fe` | Focus Neo-tree |
| `Ctrl+p` | Git files |
| `SPC pf` | Find files (alt) |

### Inside Telescope

| Key | Action | Mode |
|---|---|---|
| `Ctrl+j/k` | Move up/down | i |
| `Ctrl+n/p` | Cycle history | i |
| `Ctrl+c` | Close | i |
| `Ctrl+x` | Open horizontal split | i |
| `Ctrl+v` | Open vertical split | i |
| `Ctrl+t` | Open in new tab | i |
| `Ctrl+q` | Send to quickfix | i |
| `Esc` | Close | n |

---

## 📝 LSP (Language Server)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gI` | Go to implementation |
| `gr` | Go to references |
| `K` | Hover documentation |
| `SPC D` | Type definition |
| `SPC rn` | Rename symbol |
| `SPC ca` | Code action |
| `SPC ld` | Open diagnostic float |
| `[d` / `]d` | Prev/next diagnostic |
| `SPC xd` | Diagnostics to location list |

### Import Management

| Key | Action |
|---|---|
| `SPC io` | Organize imports |
| `SPC ai` | Add missing imports |
| `SPC ri` | Remove unused imports |
| `SPC ui` | Update/fix imports |

---

## ✅ Completion (nvim-cmp)

| Key | Action | Mode |
|---|---|---|
| `Ctrl+n` | Next item | i |
| `Ctrl+p` | Previous item | i |
| `Ctrl+d` | Scroll docs up | i |
| `Ctrl+f` | Scroll docs down | i |
| `Ctrl+Space` | Trigger completion | i |
| `Ctrl+e` | Abort | i |
| `Enter` | Confirm selection | i |
| `Ctrl+l` | LuaSnip expand/jump forward | i, s |
| `Ctrl+b` | LuaSnip jump backward | i, s |

---

## 📁 File Explorer

### Neo-tree

| Key | Action |
|---|---|
| `SPC e` | Toggle Neo-tree |
| `SPC E` | Reveal current file |
| `SPC ge` | Neo-tree git status |

#### Inside Neo-tree

| Key | Action |
|---|---|
| `Enter` | Open |
| `s` | Open vsplit |
| `S` | Open split |
| `t` | Open in new tab |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut |
| `p` | Paste |
| `c` | Copy |
| `m` | Move |
| `P` | Toggle preview |
| `H` | Toggle hidden files |
| `/` | Fuzzy finder |
| `q` | Close |
| `?` | Show help |

### Oil.nvim

| Key | Action |
|---|---|
| `-` | Open parent directory |
| `SPC -` | Toggle oil float |

---

## 🔀 Git

### Gitsigns (Hunk Operations)

| Key | Action |
|---|---|
| `]c` / `[c` | Next/prev hunk |
| `SPC hs` | Stage hunk |
| `SPC hr` | Reset hunk |
| `SPC hS` | Stage buffer |
| `SPC hu` | Undo stage hunk |
| `SPC hR` | Reset buffer |
| `SPC hp` | Preview hunk |
| `SPC hb` | Blame line |
| `SPC hd` | Diff this |
| `SPC hD` | Diff this ~ |
| `SPC tb` | Toggle line blame |
| `SPC td` | Toggle deleted |

### Fugitive

| Key | Action |
|---|---|
| `SPC gs` | Git status |
| `SPC gbl` | Git blame |
| `SPC gc` | Git commit |
| `SPC gd` | Git diff split |
| `SPC gB` | Git branch |
| `SPC glg` | Git log graph |
| `SPC gst` | Git stash |
| `SPC gsa` | Git stash apply |
| `SPC gsp` | Git stash pop |
| `SPC gaa` | Git add all |
| `SPC gq` | Quit diff mode |

#### Inside Fugitive Window

| Key | Action |
|---|---|
| `SPC p` | Git push |
| `SPC P` | Git pull --rebase |

### LazyGit & Diffview

| Key | Action |
|---|---|
| `SPC z` | Open LazyGit |
| `SPC gdo` | Open Diffview |
| `SPC gdc` | Close Diffview |
| `SPC gdh` | File history |

---

## 🧪 Testing (vim-test)

| Key | Action |
|---|---|
| `SPC tn` | Run nearest test |
| `SPC tf` | Run file tests |
| `SPC ts` | Run test suite |
| `SPC tl` | Run last test |
| `SPC tw` | Watch file tests |
| `SPC tc` | Run with coverage |

---

## 🐛 Debug (DAP)

| Key | Action |
|---|---|
| `SPC db` | Toggle breakpoint |
| `SPC dc` | Continue |
| `SPC di` | Step into |
| `SPC do` | Step over |
| `SPC dO` | Step out |
| `SPC dr` | Open REPL |
| `SPC dl` | Run last |
| `SPC dt` | Terminate |
| `SPC du` | Toggle DAP UI |
| `SPC de` | Evaluate expression (n, v) |

### Python Debug

| Key | Action |
|---|---|
| `SPC dn` | Debug nearest test |
| `SPC df` | Debug test class |
| `SPC ds` | Debug selection (v) |

---

## 🔧 Formatting & Diagnostics

| Key | Action |
|---|---|
| `SPC lf` | Format buffer |
| `SPC xx` | Toggle diagnostics (Trouble) |
| `SPC xX` | Buffer diagnostics (Trouble) |
| `SPC cL` | LSP definitions/refs (Trouble) |
| `SPC xL` | Location list (Trouble) |
| `SPC xQ` | Quickfix list (Trouble) |

---

## 🔎 Search & Replace (Spectre)

| Key | Action |
|---|---|
| `SPC S` | Toggle Spectre |
| `SPC sw` | Search current word |
| `SPC sp` | Search in current file |

---

## ⚡ Flash (Quick Navigation)

| Key | Action | Mode |
|---|---|---|
| `s` | Flash jump | n, x, o |
| `S` | Flash treesitter | n, x, o |
| `r` | Remote flash | o |
| `R` | Treesitter search | o, x |
| `Ctrl+s` | Toggle flash search | c |

---

## 📌 Harpoon (Quick File Switching)

| Key | Action |
|---|---|
| `SPC ha` | Add file to harpoon |
| `SPC hh` | Harpoon quick menu |
| `SPC 1-4` | Jump to harpoon file 1-4 |
| `SPC hp` | Previous harpoon file |
| `SPC hn` | Next harpoon file |

---

## 🎨 Themes

| Key | Action |
|---|---|
| `SPC cs` | Choose theme (Telescope) |
| `SPC cp` | Preview current theme |
| `SPC cv` | Cycle theme variants |
| `SPC cV` | Show theme info |

---

## 📂 Folding

| Key | Action |
|---|---|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zr` | Fold less |
| `zm` | Fold more |
| `zp` | Peek fold |
| `za` | Toggle fold |
| `zc` / `zo` | Close/open fold |
| `SPC fD` | Debug fold settings |

---

## 📋 REST Client

| Key | Action |
|---|---|
| `SPC rr` | Run request under cursor |
| `SPC rl` | Re-run last request |

---

## 💬 Comments

| Key | Action |
|---|---|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gc` | Comment operator (+ motion) |
| `gb` | Block comment operator |
| `gcO` / `gco` | Comment above/below |
| `gcA` | Comment at end of line |

---

## 📎 Surround

| Key | Action |
|---|---|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |

---

## 🖥️ Claude Code Integration

| Key | Action |
|---|---|
| `SPC cc` | Open Claude Code (vertical split) |
| `SPC ch` | Open Claude Code (horizontal split) |
| `SPC cT` | Toggle Claude Code terminal |
| `SPC cf` | Copy current file to clipboard |
| `SPC cs` | Copy selection to clipboard (v) |

### Claude Terminal Keymaps

| Key | Action | Mode |
|---|---|---|
| `Esc` | Exit terminal mode | n |
| `Ctrl+h/j/k/l` | Navigate windows | t |
| `Ctrl+v` | Paste from clipboard | t |

---

## 📝 Console Logging (Dev)

| Key | Action |
|---|---|
| `SPC cl` | `console.log()` for word |
| `SPC cw` | `console.warn()` for word |
| `SPC ce` | `console.error()` for word |

---

## 🐍 Python

| Key | Action |
|---|---|
| `SPC vs` | Select Python venv |
| `SPC vc` | Select cached venv |

---

## 📝 TODO Comments

| Key | Action |
|---|---|
| `]t` / `[t` | Next/prev todo |
| `SPC xt` | Todos in Trouble |
| `SPC xT` | Todo/Fix/Fixme in Trouble |
| `SPC st` | Todos in Telescope |

---

## ⌨️ Useful Vim Commands

```vim
:Lazy                " Plugin manager UI
:Mason               " LSP server manager
:LspInfo             " LSP status
:checkhealth         " Diagnose issues
:Copilot auth        " Authenticate Copilot
:Copilot status      " Check Copilot status
:ConformInfo         " Formatter info
:Trouble             " Diagnostics panel
```
