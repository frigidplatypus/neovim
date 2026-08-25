# Neovim Notes Keymaps

The `neovim-notes` package uses Space as both `mapleader` and `maplocalleader`.

## General

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>ch` | Clear highlights |
| Normal | `<leader>cs` | Clear search register |
| Normal | `<leader>bd` | Delete the current buffer |
| Normal | `<leader>bn` or `L` | Next buffer |
| Normal | `<leader>bp` or `H` | Previous buffer |
| Terminal | `<esc><esc>` | Exit terminal mode |

## Treesitter

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `gH` | Inspect Treesitter captures |
| Normal or Visual | `<leader>tP` | Inspect the Treesitter tree |

## Git

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>gg` | Open Lazygit in the current repository |

## SilverBullet

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>sf` | Find a SilverBullet page |
| Normal | `<leader>ss` | Search SilverBullet pages |
| Normal | `<leader>sb` | Show SilverBullet backlinks |
| Normal | `<leader>sj` | Open the SilverBullet journal |
| Normal | `<leader>sk` | Set the SilverBullet token for this session |
| Normal in SilverBullet buffers | `<CR>` | Follow a SilverBullet wiki link |

## Obsidian Navigation

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>oo` | Open the current note in Obsidian |
| Normal | `<leader>oq` or `<leader><leader>` | Quick-switch notes |
| Normal | `<leader>os` | Search the vault |
| Normal | `<leader>ob` | Show backlinks |
| Normal | `<leader>ol` | Show links in the current note |
| Normal | `<leader>ot` | Show the table of contents |
| Normal | `<leader>ow` | Switch workspace |
| Normal | `gf` | Follow a Markdown link, or use the normal `gf` behavior |
| Normal | `<cr>` | Follow a link or perform the context-sensitive Obsidian action |

## Obsidian Notes

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>onn` | Create a new note |
| Normal | `<leader>ont` | Create a note from a template |
| Visual | `<leader>one` | Extract the selection into a new note |
| Normal | `<leader>odt` | Open or create today's daily note |
| Normal | `<leader>ody` | Open or create yesterday's daily note |
| Normal | `<leader>odm` | Open or create tomorrow's daily note |
| Normal | `<leader>odd` | Browse daily notes |
| Visual | `<leader>oil` | Link the selection to a note |
| Visual | `<leader>oin` | Create and link a new note from the selection |
| Normal | `<leader>oip` | Paste an image into the vault |
| Normal | `<leader>oit` | Insert a template |
| Normal | `<leader>orr` | Rename the current note |
| Normal | `<leader>orc` | Toggle the current checkbox |

The launcher is `notes`. With no arguments it opens `$HOME/notes`; arguments are
passed through to Neovim, for example `notes README.md`.

SilverBullet uses `SILVERBULLET_URL` for the space URL and
`SILVERBULLET_TOKEN` for authentication. Set both before running `notes`.
