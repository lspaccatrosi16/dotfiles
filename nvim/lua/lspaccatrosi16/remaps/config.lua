local popup = require("plenary.popup")
local S = {}

local function keycombo(startchar, combo)
    return "<leader>" .. startchar .. combo
end

function S:add(startchar, description)
    if type(startchar) ~= "string" then
        error("startchar must be a string")
    end

    self[startchar] = {
        ch = startchar,
        desc = description,
        actions = {},
    }

    return {
        ---@param mode string
        ---@param combo string
        ---@param action string | function
        ---@param desc string
        add = function(mode, combo, action, desc)
            self[startchar].actions[mode .. "__" .. combo] = {
                desc = desc,
                mode = mode,
                combo = combo
            }
            vim.keymap.set(mode, keycombo(startchar, combo), action)
        end
    }
end

local isSetup = false

local function generate_win_contents(buf)
    local sections = {}
    for _, v in pairs(S) do
        if type(v) == "function" then
            goto continue
        end
        local header = string.format("%s: %s", v.ch, v.desc)
        local entries = {}
        local curL = 1
        local curMax = #header
        for _, v1 in pairs(v.actions) do
            curL = curL + 1
            local ent = v1.mode .. ": " .. keycombo(v.ch, v1.combo) .. " - " .. v1.desc
            local l = #ent
            if l > curMax then
                curMax = l
            end
            table.insert(entries, ent)
        end
        table.sort(entries)
        table.insert(entries, 1, header)
        table.insert(sections, {
            key = v.ch,
            entries = entries,
            width = curMax,
        })
        ::continue::
    end

    table.sort(sections, function(a, b) return a.key < b.key end)

    local lines = {}
    local maxW = 0

    for _, sec in pairs(sections) do
        for _, line in pairs(sec.entries) do
            table.insert(lines, line)
            if #line > maxW then
                maxW = #line
            end
        end
        table.insert(lines, "")
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
    vim.api.nvim_buf_set_lines(buf, 0, #lines, false, lines)

    return {
        width = maxW + 1,
        height = #lines,
    }
end

Win_Id = nil
Buf_Id = nil

local function setup()
    if isSetup then
        return
    end
    -- isSetup = true

    vim.api.nvim_create_user_command("Shortcuts", function()
        if Win_Id ~= nil or Buf_Id ~= nil then
            vim.api.nvim_win_close(Win_Id, true)

            Win_Id = nil
            Buf_Id = nil
        else
            local buf = vim.api.nvim_create_buf(false, true)
            local info = generate_win_contents(buf)
            local win_id, _ = popup.create(buf, {
                title = "Shortcuts",
                line = math.floor(((vim.o.lines - info.height) / 2) - 1),
                col = math.floor((vim.o.columns - info.width) / 2),
                width = info.width,
                height = info.height,
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            })

            Win_Id = win_id
            Buf_Id = buf

            vim.api.nvim_buf_set_option(Buf_Id, "readonly", true)
            vim.api.nvim_buf_set_option(Buf_Id, "modified", false)

            vim.api.nvim_buf_set_keymap(Buf_Id, "n", "q", ":Shortcuts<CR>", { silent = true })
            vim.api.nvim_buf_set_keymap(Buf_Id, "n", "<Esc>", ":Shortcuts<CR>", { silent = true })
        end
    end, {})
end

return {
    setup = setup,
    sections = S,
}
