# Auto Theme Plugin

**Auto Theme** is a plugin for the micro text editor that automatically sets
the colorscheme based on the filetype (syntax) of the currently opened buffer.

This allows you to use different themes for different languages, improving
visibility and mood depending on what you're working on.

## Features

- Automatically switches colorscheme when a file is opened

## Configuration

Edit the `autotheme.lua` file to customize your theme mapping:

```lua
local theme = {
    markdown = "solarized-light",
    lua = "darcula",
    shell = "monokai",
    unknown = "simple",
}
```

You can add or change the mappings as needed.
The key should match the result of `Buf:FileType()`.

## Limitations

The theme switch relies on the `onBufferOpen` hook, which is triggered when a
buffer is newly opened.  
As a result, it **may not trigger** when switching between already opened
buffers using `NextSplit` (`Ctrl-w`), `PreviousTab` (`Alt-,`), or `NextTab`
(`Alt-.`).
