# invero.nvim

A minimal, light-themed Neovim colorscheme built on the xterm 256-color palette.
Designed for daytime readability with high contrast and semantic color mapping.

## Features

- Light theme optimized for readability
- Xterm 256-color palette with GUI hex support
- Caching system for fast loading (serialized Lua)
- Plugin detection (lazy.nvim, native packages, paq)
- User-extensible highlights via `options.highlights(colors, color_tool)`
- Terminal theme generation for Kitty, WezTerm, and Ghostty

## Installation

With lazy.nvim:

```lua
{
  'triimd/invero.nvim',
  priority = 1000,
  config = function()
    require('invero').setup({
      -- transparent = true,  -- optional: transparent background
      -- highlights = function(colors, color_tool)
      --   return { Custom = { fg = colors.blue } }
      -- end,
    })
    vim.cmd('colorscheme invero')
  end,
}
```

For local development:

```lua
{ dir = '~/projects/flow/invero.nvim', priority = 1000 }
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
<<<<<<< HEAD
| Cyan    | 153   | `#afd7ff` | Secondary accent         |
=======
| Cyan    | 24    | `#005f87` | Secondary accent         |
>>>>>>> 31b29e2 (cache)
| Black   | 238   | `#444444` | Base text                |
| White   | 255   | `#eeeeee` | Base background          |

Semantic mappings:

```
base         = white     (#eeeeee)  -- background
text         = black     (#444444)  -- foreground
accent       = blue      (#005fff)  -- primary accent
<<<<<<< HEAD
accent_light = cyan      (#afd7ff)  -- secondary accent
=======
accent_light = cyan      (#005f87)  -- secondary accent
>>>>>>> 31b29e2 (cache)
syntax       = magenta   (#5f5f87)  -- language constructs
outline      = gray0     (#b2b2b2)  -- borders
muted        = gray1     (#9e9e9e)  -- secondary text
surface      = gray3     (#ffffff)  -- elevated surfaces
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
│       ├── kitty.lua                # Kitty theme template
│       ├── wezterm.lua              # WezTerm theme template
│       └── ghostty.lua              # Ghostty theme template
├── extras/                          # Pre-generated terminal configs
│   ├── kitty/invero_day.conf
│   ├── wezterm/invero_day.toml
│   └── ghostty/invero_day
└── scripts/
    └── build                        # Headless Nvim script to regenerate extras
```

## Terminal Themes

Pre-generated configs live in `extras/`. To regenerate after palette changes:

```bash
./scripts/build
```

Or from within Neovim:

```vim
:lua require('invero.extras').setup()
```

Copy the generated file to your terminal's config directory:

- **Kitty:** `cp extras/kitty/invero_day.conf ~/.config/kitty/themes/`
- **WezTerm:** `cp extras/wezterm/invero_day.toml ~/.config/wezterm/colors/`
- **Ghostty:** `cp extras/ghostty/invero_day ~/.config/ghostty/themes/`

## Plugin Integrations

Integrations are auto-detected and only applied if the plugin is installed:

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
Neovim's standard cache directory. To clear it:

```vim
:lua require('invero').invalidate_cache()
:colorscheme invero
```
