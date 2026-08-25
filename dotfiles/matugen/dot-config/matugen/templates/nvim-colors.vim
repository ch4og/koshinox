" Matugen Neovim colorscheme template.
" Based on https://github.com/InioX/matugen-themes (MIT License).
" Copyright (c) 2011-2025 The Bootstrap Authors
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

hi Normal guibg=None guifg={{ colors.on_surface.dark.hex }}
hi Comment guibg=None guifg={{ colors.on_surface_variant.dark.hex }}

hi Delimiter guibg=None guifg={{ colors.on_surface.dark.hex }}
hi Operator guibg=None guifg={{ colors.on_surface.dark.hex }}

hi Todo guibg={{ colors.primary_container.dark.hex }} guifg={{ colors.on_primary_container.dark.hex }} gui=bold

hi Identifier guibg=None guifg={{ colors.primary.dark.hex }}
hi Constant guibg=None guifg={{ colors.tertiary.dark.hex }}
hi Type guibg=None guifg={{ colors.secondary.dark.hex }}
hi String guibg=None guifg={{ colors.tertiary.dark.hex }}
hi Special guibg=None guifg={{ colors.secondary.dark.hex }}
hi PreProc guibg=None guifg={{ colors.secondary.dark.hex }}
hi Function guibg=None guifg={{ colors.primary.dark.hex }}
hi Statement guibg=None guifg={{ colors.tertiary.dark.hex }}

hi Error guibg={{ colors.error_container.dark.hex }} guifg={{ colors.on_error_container.dark.hex }}
hi StatusLine guibg={{ colors.primary.dark.hex }} guifg={{ colors.on_primary.dark.hex }}
hi StatusLineNC guibg={{ colors.primary_container.dark.hex }} guifg={{ colors.on_primary_container.dark.hex }}
hi Selection guibg={{ colors.secondary_container.dark.hex }} guifg={{ colors.on_secondary_container.dark.hex }}
hi Visual guibg={{ colors.secondary_container.dark.hex }} guifg={{ colors.on_secondary_container.dark.hex }}
