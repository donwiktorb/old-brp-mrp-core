


-- -- -- -- Thread:Create(function()
-- -- -- --     while true do
-- -- -- --         Wait(0)
-- -- -- --         for k,v in pairs(Text.DrawThese3d) do
-- -- -- --             local dist = #(DWB.PlayerData.Coords - v.coords)
-- -- -- --             if dist <= v.maxDist then
-- -- -- --                 Text:Draw3D(v.coords, v.text, v.data)
-- -- -- --             end


-- -- -- --         end
-- -- -- --     end
-- -- -- -- end)