-- So lazy.nvim is configured to load all lua/plugins/*.lua files. This means
-- that every file within this directory should return a list pointing to the
-- repo of the plugin, its dependencies, and a config function that will be
-- also be picked up by lazy.nvim.
--
-- This init file could then be used to "quickload" plugins that require
-- minimal or no configuration at all.
return {
}
