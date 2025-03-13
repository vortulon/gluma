#!/usr/bin/env lua

-- gluma simple and easy lua based nvmin/vim like editor
-- gluma = joke in romanian, it had the "lu" from lua so i thought it was funny
-- i made this because i was bored and i wanted to make a simple text editor
-- i also wanted to make a text editor that wasnt vim or emacs (i do love nano tho)
-- so i made this
-- it's not perfect but it works
-- made out of spite
-- by vortulon          
-- do whatever you want with the code i dont care lol


-- actual code starts here

local filename = arg[1]
local buffer = {}
local modified = false

-- load file if specified
if filename then
    local file = io.open(filename, "r")
    if file then
        for line in file:lines() do
            table.insert(buffer, line)
        end
        file:close()
        print("Loaded file: " .. filename)
    else
        print("New file: " .. filename)
    end
else
    print("No filename specified. Creating new file.")
end

-- if buffer is empty, add an empty line
if #buffer == 0 then
    buffer = {""}
end

-- help screen
local function show_help()
    print("\nGluma simple text editor commands:")
    print("  :q        Quit")
    print("  :w        Save")
    print("  :w file   Save as")
    print("  :l        List all lines")
    print("  :l N      List line N")
    print("  :l N-M    List lines N to M")
    print("  :e N text Edit line N")
    print("  :i N text Insert text at line N")
    print("  :d N      Delete line N")
    print("  :d N-M    Delete lines N to M")
    print("  :h        Show this help screen")
    print()
end

-- save the buffer to a file
local function save_file(fname)
    local name = fname or filename
    if not name then
        print("Error: No filename specified")
        return false
    end
    
    local file = io.open(name, "w")
    if file then
        for _, line in ipairs(buffer) do
            file:write(line .. "\n")
        end
        file:close()
        filename = name
        modified = false
        print("Saved to " .. name)
        return true
    else
        print("Error: Could not save to " .. name)
        return false
    end
end

-- list lines
local function list_lines(start, finish)
    start = start or 1
    finish = finish or #buffer
    
    for i = start, finish do
        if buffer[i] then
            print(string.format("%4d: %s", i, buffer[i]))
        end
    end
end

-- edit a line
local function edit_line(line_num, text)
    if not buffer[line_num] then
        print("Error: Line " .. line_num .. " does not exist")
        return
    end
    
    buffer[line_num] = text
    modified = true
    print("Line " .. line_num .. " edited")
end

-- insert a line
local function insert_line(line_num, text)
    if line_num < 1 or line_num > #buffer + 1 then
        print("Error: Invalid line number")
        return
    end
    
    table.insert(buffer, line_num, text)
    modified = true
    print("Line inserted at position " .. line_num)
end

-- delete
local function delete_lines(start, finish)
    start = start or 1
    finish = finish or start
    
    if start < 1 or finish > #buffer or start > finish then
        print("Error: Invalid line range")
        return
    end
    
    local count = finish - start + 1
    for i = 1, count do
        table.remove(buffer, start)
    end
    
    modified = true
    print("Deleted " .. count .. " line(s)")
    
    -- dont remove this or everything fucking breaks
    if #buffer == 0 then
        buffer = {""}
    end
end

-- loopty loop
show_help()
while true do
    io.write("> ")
    local cmd = io.read()
    
    if cmd == ":q" then
        if modified then
            io.write("File modified. Save before quitting? (y/n) ")
            local answer = io.read()
            if answer:lower() == "y" then
                if save_file() then
                    break
                end
            else
                break
            end
        else
            break
        end
    elseif cmd == ":w" then
        save_file()
    elseif cmd:match("^:w%s+(.+)$") then
        local new_name = cmd:match("^:w%s+(.+)$")
        save_file(new_name)
    elseif cmd == ":l" then
        list_lines()
    elseif cmd:match("^:l%s+(%d+)$") then
        local line_num = tonumber(cmd:match("^:l%s+(%d+)$"))
        list_lines(line_num, line_num)
    elseif cmd:match("^:l%s+(%d+)%-(%d+)$") then
        local start, finish = cmd:match("^:l%s+(%d+)%-(%d+)$")
        list_lines(tonumber(start), tonumber(finish))
    elseif cmd:match("^:e%s+(%d+)%s+(.*)$") then
        local line_num, text = cmd:match("^:e%s+(%d+)%s+(.*)$")
        edit_line(tonumber(line_num), text)
    elseif cmd:match("^:i%s+(%d+)%s+(.*)$") then
        local line_num, text = cmd:match("^:i%s+(%d+)%s+(.*)$")
        insert_line(tonumber(line_num), text)
    elseif cmd:match("^:d%s+(%d+)$") then
        local line_num = tonumber(cmd:match("^:d%s+(%d+)$"))
        delete_lines(line_num, line_num)
    elseif cmd:match("^:d%s+(%d+)%-(%d+)$") then
        local start, finish = cmd:match("^:d%s+(%d+)%-(%d+)$")
        delete_lines(tonumber(start), tonumber(finish))
    elseif cmd == ":h" then
        show_help()
    else
        print("Unknown command. Type :h for help.")
    end
end

print("see you next time :3")
