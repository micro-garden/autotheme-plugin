VERSION = "0.0.1"

local theme = {
	markdown = "solarized-light",
	lua = "darcula",
	shell = "monokai",
	unknown = "simple",
}

local config = import("micro/config")

function onBufferOpen(buf)
	local scheme = theme[buf:FileType()] or theme.unknown
	config.SetGlobalOption("colorscheme", scheme)
end

function init()
	config.AddRuntimeFile("autotheme", config.RTHelp, "help/autotheme.md")
end
