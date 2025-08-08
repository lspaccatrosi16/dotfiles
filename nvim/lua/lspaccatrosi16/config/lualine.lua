local theme = require('lualine.themes.nord')

local function time()
    return os.date("%d/%m %H:%M")
end

local function get_acpi()
    local acpi = io.popen('acpi 2>&1')
    if acpi == nil then
        return "ACPI ERROR"
    end
    local acpi_res = acpi:read("*line")
    acpi:close()
    return acpi_res
end

local function battery_status()
    local ok, res = pcall(get_acpi)
    if ok == false then
        print(res)
        return "error"
    else
        local words = {};
        for word in string.gmatch(res, "[^,]+") do
            table.insert(words, word)
        end

        local percent = "⚡ " .. tostring(words[2]):gsub("%%", "%%%%"):gsub(" ", "")
        return percent
    end
end

require('lualine').setup({
    options = {
        theme = theme,
        icons_enabled = false,
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = ' ', right = ' ' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename', 'diagnostics' },
        lualine_c = { 'location' },
        lualine_x = { 'filetype' },
        lualine_y = { battery_status },
        lualine_z = { time },
    },
})
