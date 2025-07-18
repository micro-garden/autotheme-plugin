# Auto Theme Plugin

**Auto Theme** is a plugin for the micro text editor that automatically sets
the colorscheme based on the filetype (syntax) of the currently opened buffer.

This allows you to use different themes for different languages, improving
visibility and mood depending on what you're working on.

## Features

- Automatically switches colorscheme when a file is opened in a pane

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

The theme switch relies on the `onBufPaneOpen` hook, which is triggered when a
buffer is newly displayed in a pane.  
As a result:

- It **does not trigger** when opening a file via the `open` command, since
  this reuses the current pane without creating a new one.
- It **may not trigger** when switching between already opened buffers using
  `NextSplit` (`Ctrl-w`) or `PreviousTab` (`Alt-,`) / `NextTab` (`Alt-.`),
  unless the buffer is reopened in a new pane (e.g. via `tab`, `hsplit`, or
  `vsplit`).

In short, theme switching works best when a file is opened in a **new pane** or
at **editor startup**.
