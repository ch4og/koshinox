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

hi Comment guibg=None guifg={{ base16.base03.dark.hex }}

hi Delimiter guibg=None guifg={{ base16.base05.dark.hex }}
hi Operator guibg=None guifg={{ base16.base05.dark.hex }}

hi Todo guibg=None guifg={{ base16.base06.dark.hex }}

hi Identifier guibg=None guifg={{ base16.base08.dark.hex }}
hi Constant guibg=None guifg={{ base16.base09.dark.hex }}
hi Type guibg=None guifg={{ base16.base0a.dark.hex }}
hi String guibg=None guifg={{ base16.base0b.dark.hex }}
hi Special guibg=None guifg={{ base16.base0c.dark.hex }}
hi PreProc guibg=None guifg={{ base16.base0c.dark.hex }}
hi Function guibg=None guifg={{ base16.base0d.dark.hex }}
hi Statement guibg=None guifg={{ base16.base0e.dark.hex }}

hi Error guibg={{ colors.error_container.dark.hex }} guifg={{ colors.on_error_container.dark.hex }}
hi StatusLine guibg={{ colors.primary.dark.hex }} guifg={{ colors.on_primary.dark.hex }}
hi StatusLineNC guibg={{ colors.primary_container.dark.hex }} guifg={{ colors.on_primary_container.dark.hex }}
hi Selection guibg={{ base16.base02.dark.hex }}
