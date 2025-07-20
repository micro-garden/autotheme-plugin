# Auto Theme Plugin

**Auto Theme** is a plugin for the micro text editor that automatically sets
the colorscheme based on the filetype (syntax) of the currently opened buffer.

This allows you to use different themes for different languages, improving
visibility and mood depending on what you're working on.

## Features

- Automatically switches colorscheme when a file is opened

## Configuration

In your `settings.json`, set the following option using space-separated
`key=value` pairs:

```json
{
    "autotheme.mapping": "lua=darcula python=monokai shell=twilight"
}
```

The key is the filetype (as reported by `Buf:FileType()`), and the value is
the colorscheme name.

## Limitations

The theme switch relies on the `onBufferOpen` hook, which is triggered when a
buffer is newly opened.  
As a result, it **may not trigger** when switching between already opened
buffers using `NextSplit` (`Ctrl-w`), `PreviousTab` (`Alt-,`), or `NextTab`
(`Alt-.`).
