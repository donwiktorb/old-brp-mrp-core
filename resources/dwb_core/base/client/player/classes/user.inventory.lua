function User:HasItem(item)
  if type(item) == "table" then
    for k, v in pairs(DWB.PlayerData.char.inventory) do
      if Table:InTable(item, v.name) then
        return true
      end
    end
  else
    for k, v in pairs(DWB.PlayerData.char.inventory) do
      if v.name == item then
        return true
      end
    end
  end
end
