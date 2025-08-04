VERSION = "0.0.3"

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

local micro = import("micro")
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

function SetAutoThemeCmd(bp, args)
	local lang, scheme

	if #args == 0 then
		lang = bp.Buf:FileType()
		scheme = config.GetGlobalOption("colorscheme") or theme_unknown
	elseif #args == 1 and args[1] == "false" then
		lang = bp.Buf:FileType()
		scheme = "false"
	elseif #args == 1 then
		lang = args[1]
		scheme = config.GetGlobalOption("colorscheme") or theme_unknown
	else
		lang = args[1]
		scheme = args[2]
	end

	local raw = config.GetGlobalOption("autotheme.mapping") or ""
	local mapping = parse_theme_mapping(raw)

	if scheme == "false" then
		if mapping[lang] ~= nil then
			mapping[lang] = nil
			micro.InfoBar():Message("autotheme: removed mapping for " .. lang)
		else
			micro.InfoBar():Message("autotheme: no mapping to remove for " .. lang)
		end
	else
		mapping[lang] = scheme
		micro.InfoBar():Message("autotheme: set " .. lang .. "=" .. scheme)
	end

	local new_parts = {}
	for k, v in pairs(mapping) do
		table.insert(new_parts, k .. "=" .. v)
	end
	local new_raw = table.concat(new_parts, " ")
	config.SetGlobalOption("autotheme.mapping", new_raw)
end

function preinit()
	config.RegisterCommonOption("autotheme", "mapping", "")
end

function init()
	config.MakeCommand("setautotheme", SetAutoThemeCmd, config.NoComplete)
	config.AddRuntimeFile("autotheme", config.RTHelp, "help/autotheme.md")
end
