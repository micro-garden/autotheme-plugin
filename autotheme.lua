VERSION = "0.0.0"

local theme = {
	markdown = "solarized-light",
	lua = "darcula",
	shell = "monokai",
	unknown = "simple",
}

local config = import("micro/config")

function onBufPaneOpen(bp)
	local scheme = theme[bp.Buf:FileType()] or theme.unknown
	config.SetGlobalOption("colorscheme", scheme)
end

function init()
	config.AddRuntimeFile("autotheme", config.RTHelp, "help/autotheme.md")
end
