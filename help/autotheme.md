# Auto Theme Plugin

**Auto Theme** is a plugin that automatically sets the colorscheme based on
the filetype (syntax) of the currently opened buffer.

This allows you to use different themes for different languages, improving
visibility and mood depending on what you're working on.

## Features

- Automatically switches colorscheme based on the filetype when a file is
  opened
- Supports flexible per-language theme mappings
- Allows interactive configuration via the `setautotheme` command

## Configuration

### Interactive command

You can use the `setautotheme` command to manage theme mappings directly
within micro.

To assign the current colorscheme to the current buffer's filetype:

```
setautotheme
```

To remove the mapping for the current buffer's filetype:

```
setautotheme false
```

To explicitly set a mapping:

```
setautotheme <filetype> [colorscheme]
```

- If `colorscheme` is omitted, the currently active colorscheme will be used.
- If `colorscheme` is `false`, the mapping for the specified filetype will be
  removed.

Examples:

```
setautotheme lua darcula # Set darcula for Lua
setautotheme markdown # Set current theme for Markdown
setautotheme lua false # Remove Lua mapping
```

All mappings are stored in the `autotheme.mapping` global setting.

### Settings file

Alternatively, you can configure mappings manually in your `settings.json`
file using space-separated `key=value` pairs:

```json
{
    "autotheme.mapping": "lua=darcula python=monokai shell=twilight"
}
```

You can also use newline characters (`\n`) in the string if desired.

Each key should be a filetype (as returned by `Buf:FileType()`), and the value
is the name of the colorscheme to apply.

## Limitations

The theme switch relies on the `onBufferOpen` hook, which is triggered when a
buffer is newly opened.  
As a result, it **may not trigger** when switching between already opened
buffers using `NextSplit` (`Ctrl-w`), `PreviousTab` (`Alt-,`), or `NextTab`
(`Alt-.`).
