local Charset = {}
local u = 0 -- don't delete
for i = 48, 57 do table.insert(Charset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

Math = class()

function Math:Round(value, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end



function Math:Format(number)
    return string.format("%d", number):reverse():gsub("(%d%d%d)", "%1 "):reverse():gsub("^%s+", "")
end

function Math:Trim(value)
    if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
    else
        return nil
    end
end

function Math:RandomNumber(x, y)
    return math.random(x, y)
end

function Math:GetUniqueId(digits)
    local digitCount = 10

    for i = 1, digits do
        digitCount = digitCount * 10
    end

    return string.sub(tostring(math.random() * digitCount), 0, digits)
end

function Math:RandomString(length)
    local chars = {}
    for i = 1, length do
        local char_code = math.random(65, 90)
        if math.random() < 0.5 then
            char_code = char_code + 32
        end
        table.insert(chars, string.char(char_code))
    end
    return table.concat(chars)
end