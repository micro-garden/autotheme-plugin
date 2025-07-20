VERSION = "0.0.2"

local theme_unknown = "simple"
local theme = {
	c = "gruvbox",
	go = "one-dark",
	lua = "darcula",
	markdown = "dukelight-tc",
	python = "monokai",
	shell = "twilight",
	unknown = theme_unknown,
}

local config = import("micro/config")

local function parse_theme_mapping(raw)
	local mapping = {}
	for line in raw:gmatch("[^\n%s]+") do
		local key, value = line:match("^(.-)=(.+)$")
		if key and value then
			mapping[key] = value
		end
	end
	return mapping
end

local function get_theme_mapping()
	local raw = config.GetGlobalOption("autotheme.mapping")
	if raw == nil or raw == "" then
		return nil
	end
	return parse_theme_mapping(raw)
end

local function apply_theme(buf)
	local mapping = get_theme_mapping() or theme
	local scheme = mapping[buf:FileType()] or mapping["unknown"] or theme_unknown
	config.SetGlobalOption("colorscheme", scheme)
end

function onBufferOpen(buf)
	apply_theme(buf)
end

function init()
	--config.RegisterGlobalOption("autotheme", "mapping", "")
	config.AddRuntimeFile("autotheme", config.RTHelp, "help/autotheme.md")
end
