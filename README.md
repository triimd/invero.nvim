# invero.nvim

A minimal, light-themed Neovim colorscheme built on the xterm 256-color palette.
Designed for daytime readability with high contrast and semantic color mapping.

## Features

- Light theme optimized for readability
- Xterm 256-color palette with GUI hex support
- Caching system for fast loading (serialized Lua)
- Plugin integration detection through Neovim's native `vim.pack`
- User-extensible highlights via `options.highlights(colors, color_tool)`
- Theme generation for Kitty, WezTerm, Ghostty, Herdr, Zellij, and the Pi coding agent

## Requirements

- Neovim 0.12 or newer

## Installation

Register Invero with `vim.pack` before loading the colorscheme:

```lua
vim.pack.add({
  'https://github.com/triimd/invero.nvim',
})

require('invero').setup({
  -- transparent = true,  -- optional: transparent background
  -- highlights = function(colors, color_tool)
  --   return { Custom = { fg = colors.blue } }
  -- end,
})
vim.cmd('colorscheme invero')
```

## Color Palette

The "day" variant uses these base colors:

| Name    | Index | Hex       | Usage                    |
| ------- | ----- | --------- | ------------------------ |
| Red     | 196   | `#ff0000` | Errors, deletions        |
| Green   | 35    | `#00af5f` | Additions, success       |
| Yellow  | 166   | `#d75f00` | Warnings, highlights     |
| Blue    | 27    | `#005fff` | Primary accent           |
| Magenta | 60    | `#5f5f87` | Syntax (keywords, types) |
| Cyan    | 38    | `#00afd7` | Secondary accent         |
| Black   | 238   | `#444444` | Base text                |
| White   | 255   | `#eeeeee` | Base background          |

Semantic mappings:

```
base         = white     (#eeeeee)  -- background
text         = black     (#444444)  -- foreground
accent       = blue      (#005fff)  -- primary accent
accent_light = cyan      (#00afd7)  -- secondary accent
syntax       = magenta   (#5f5f87)  -- language constructs
outline      = gray0     (#8a8a8a)  -- borders
muted        = gray1     (#9e9e9e)  -- secondary text
surface      = gray3     (#dadada)  -- elevated surfaces
```

## Structure

```
invero.nvim/
├── colors/                          # Vim colorscheme entry points
│   ├── invero.lua                   # Auto variant selector
│   ├── invero-day.lua               # Day variant
│   └── invero-night.lua             # Night variant (placeholder)
├── lua/invero/
│   ├── init.lua                     # Main entry, setup() and load()
│   ├── colors/
│   │   └── day.lua                  # Day palette definition
│   ├── groups/
│   │   ├── editor.lua               # UI elements (Normal, StatusLine, Pmenu, etc.)
│   │   ├── syntax.lua               # Language highlights + diagnostics
│   │   ├── terminal.lua             # ANSI terminal colors (0-15)
│   │   └── integrations/
│   │       ├── nvim_tree.lua        # nvim-tree highlights
│   │       ├── telescope.lua        # Telescope highlights
│   │       └── treesitter.lua       # Treesitter capture groups
│   ├── lib/
│   │   ├── setup.lua                # Theme loading logic
│   │   ├── highlights.lua           # Highlight generation pipeline
│   │   ├── cache.lua                # Serialization/caching
│   │   ├── integrations.lua         # Plugin detection
│   │   ├── plugin_map.lua           # Plugin name mappings
│   │   └── utils.lua                # Template engine, utilities
│   └── extras/
│       ├── init.lua                 # Extra generation orchestrator
│       ├── comments.lua             # Generated-file comment formatters
│       ├── kitty.lua                # Kitty theme template
│       ├── wezterm.lua              # WezTerm theme template
│       ├── ghostty.lua              # Ghostty theme template
│       ├── herdr.lua                # Herdr theme template
│       ├── pi.lua                   # Pi coding agent theme template
│       └── zellij.lua               # Zellij theme template
├── extras/                          # Pre-generated theme configs
│   ├── kitty/invero-day.conf
│   ├── wezterm/invero-day.toml
│   ├── ghostty/invero-day
│   ├── herdr/invero-day.toml
│   ├── pi/invero-day.json
│   └── zellij/invero-day.kdl
└── scripts/
    ├── build                        # Regenerate extras
    └── install                      # Install generated themes
```

## Terminal Themes

Pre-generated configs live in `extras/`. The build script resolves the repository root itself, so it can be run from any directory:

```bash
./scripts/build
```

Installation is handled separately and supports each generated format:

```bash
./scripts/install kitty             # Install every Kitty variant
./scripts/install pi day            # Install only the Pi day variant
./scripts/install herdr night       # Select the Herdr night variant
./scripts/install all day           # Install the day variant for every target
```

The variant defaults to `all`; Herdr defaults to `day` because its config can
contain only one active custom theme. Installed filenames are identical to the
files under `extras/`. Destination directories can be overridden with `KITTY_THEME_DIR`,
`WEZTERM_COLOR_DIR`, `GHOSTTY_THEME_DIR`, `ZELLIJ_THEME_DIR`, `PI_THEME_DIR`,
and `HERDR_CONFIG_FILE`.

Or from within Neovim:

```vim
:lua require('invero.extras').setup()
```

Copy the generated file to your terminal's config directory:

- **Kitty:** `cp extras/kitty/invero-day.conf ~/.config/kitty/themes/`
- **WezTerm:** `cp extras/wezterm/invero-day.toml ~/.config/wezterm/colors/`
- **Ghostty:** `cp extras/ghostty/invero-day ~/.config/ghostty/themes/`
- **Herdr:** merge `extras/herdr/invero-day.toml` into `~/.config/herdr/config.toml`
- **Zellij:** `cp extras/zellij/*.kdl ~/.config/zellij/themes/`

Select a generated Zellij variant in `~/.config/zellij/config.kdl`:

```kdl
theme "invero-day"
```

Zellij also supports automatic host color-scheme selection:

```kdl
theme_light "invero-day"
theme_dark "invero-night"
```

## Pi Coding Agent Themes

Install either generated variant in Pi's global theme directory at
`~/.config/pi/themes/`:

```bash
./scripts/install pi day
# Or: ./scripts/install pi night
```

Then select `invero-day` or `invero-night` from `/settings`.

## Plugin Integrations

Integrations are auto-detected and only applied if the plugin was activated with
`vim.pack.add()` before loading Invero:

- **nvim-tree.lua** - File explorer highlights
- **Telescope** - Search match highlighting
- **Treesitter** - Semantic syntax capture groups

## Highlight Pipeline

```
Color Palette (colors/day.lua)
  → gen_color_tool() converts indices to {cterm, gui}
    → Group modules return highlight tables
      → highlights.lua normalizes to nvim_set_hl format
        → Cache serializes to Lua file
          → On next load, cached file is loaded directly
```

## Configuration

```lua
require('invero').setup({
  transparent = false,  -- transparent background
  highlights = function(colors, color_tool)
    -- Override or add highlight groups
    return {
      Comment = { fg = color_tool(245) },
      MyCustomGroup = { fg = colors.blue, bold = true },
    }
  end,
})
```

## Cache

Highlights are cached as serialized Lua for fast startup. The cache is stored in
Neovim's standard cache directory. To reload the theme after editing source files:

```vim
:InveroReload day
```
