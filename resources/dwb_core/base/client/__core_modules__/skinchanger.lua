-- https://github.com/mitlight/skinchanger we got components from here
Skinchanger = class()
Skinchanger.Components = {
    { label = TR('sex'),                   name = 'sex',          value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('face'),                  name = 'face',         value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('skin'),                  name = 'skin',         value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('hair_1'),                name = 'hair_1',       value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('hair_2'),                name = 'hair_2',       value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('hair_color_1'),          name = 'hair_color_1', value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('hair_color_2'),          name = 'hair_color_2', value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('tshirt_1'),              name = 'tshirt_1',     value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('tshirt_2'),              name = 'tshirt_2',     value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15, textureof = 'tshirt_1' },
    { label = TR('torso_1'),               name = 'torso_1',      value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('torso_2'),               name = 'torso_2',      value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15, textureof = 'torso_1' },
    { label = TR('decals_1'),              name = 'decals_1',     value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('decals_2'),              name = 'decals_2',     value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15, textureof = 'decals_1' },
    { label = TR('arms'),                  name = 'arms',         value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('arms_2'),                name = 'arms_2',       value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('pants_1'),               name = 'pants_1',      value = 0,  min = 0,  zoomOffset = 0.8,  camOffset = -0.5 },
    { label = TR('pants_2'),               name = 'pants_2',      value = 0,  min = 0,  zoomOffset = 0.8,  camOffset = -0.5, textureof = 'pants_1' },
    { label = TR('shoes_1'),               name = 'shoes_1',      value = 0,  min = 0,  zoomOffset = 0.8,  camOffset = -0.8 },
    { label = TR('shoes_2'),               name = 'shoes_2',      value = 0,  min = 0,  zoomOffset = 0.8,  camOffset = -0.8, textureof = 'shoes_1' },
    { label = TR('mask_1'),                name = 'mask_1',       value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('mask_2'),                name = 'mask_2',       value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65, textureof = 'mask_1' },
    { label = TR('bproof_1'),              name = 'bproof_1',     value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('bproof_2'),              name = 'bproof_2',     value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15, textureof = 'bproof_1' },
    { label = TR('chain_1'),               name = 'chain_1',      value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('chain_2'),               name = 'chain_2',      value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65, textureof = 'chain_1' },
    { label = TR('helmet_1'),              name = 'helmet_1',     value = -1, min = -1, zoomOffset = 0.6,  camOffset = 0.65, componentId = 0 },
    { label = TR('helmet_2'),              name = 'helmet_2',     value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65, textureof = 'helmet_1' },
    { label = TR('glasses_1'),             name = 'glasses_1',    value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65 },
    { label = TR('glasses_2'),             name = 'glasses_2',    value = 0,  min = 0,  zoomOffset = 0.6,  camOffset = 0.65, textureof = 'glasses_1' },
    { label = TR('watches_1'),             name = 'watches_1',    value = -1, min = -1, zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('watches_2'),             name = 'watches_2',    value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15, textureof = 'watches_1' },
    { label = TR('bracelets_1'),           name = 'bracelets_1',  value = -1, min = -1, zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('bracelets_2'),           name = 'bracelets_2',  value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15, textureof = 'bracelets_1' },
    { label = TR('bag'),                   name = 'bags_1',       value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('bag_color'),             name = 'bags_2',       value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15, textureof = 'bags_1' },
    { label = TR('eye_color'),             name = 'eye_color',    value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('eyebrow_size'),          name = 'eyebrows_2',   value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('eyebrow_type'),          name = 'eyebrows_1',   value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('eyebrow_color_1'),       name = 'eyebrows_3',   value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('eyebrow_color_2'),       name = 'eyebrows_4',   value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('makeup_type'),           name = 'makeup_1',     value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('makeup_thickness'),      name = 'makeup_2',     value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('makeup_color_1'),        name = 'makeup_3',     value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('makeup_color_2'),        name = 'makeup_4',     value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('lipstick_type'),         name = 'lipstick_1',   value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('lipstick_thickness'),    name = 'lipstick_2',   value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('lipstick_color_1'),      name = 'lipstick_3',   value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('lipstick_color_2'),      name = 'lipstick_4',   value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('ear_accessories'),       name = 'ears_1',       value = -1, min = -1, zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('ear_accessories_color'), name = 'ears_2',       value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65, textureof = 'ears_1' },
    { label = TR('chest_hair'),            name = 'chest_1',      value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('chest_hair_1'),          name = 'chest_2',      value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('chest_color'),           name = 'chest_3',      value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('bodyb'),                 name = 'bodyb_1',      value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('bodyb_size'),            name = 'bodyb_2',      value = 0,  min = 0,  zoomOffset = 0.75, camOffset = 0.15 },
    { label = TR('wrinkles'),              name = 'age_1',        value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('wrinkle_thickness'),     name = 'age_2',        value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('blemishes'),             name = 'blemishes_1',  value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('blemishes_size'),        name = 'blemishes_2',  value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('blush'),                 name = 'blush_1',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('blush_1'),               name = 'blush_2',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('blush_color'),           name = 'blush_3',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('complexion'),            name = 'complexion_1', value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('complexion_1'),          name = 'complexion_2', value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('sun'),                   name = 'sun_1',        value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('sun_1'),                 name = 'sun_2',        value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('freckles'),              name = 'moles_1',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('freckles_1'),            name = 'moles_2',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('beard_type'),            name = 'beard_1',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('beard_size'),            name = 'beard_2',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('beard_color_1'),         name = 'beard_3',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 },
    { label = TR('beard_color_2'),         name = 'beard_4',      value = 0,  min = 0,  zoomOffset = 0.4,  camOffset = 0.65 }
}

Skinchanger.Skin = {}
Skinchanger.LastSkin = {}
Skinchanger.SavedSkin = {}
Skinchanger.Changes = {}


for i = 1, #Skinchanger.Components, 1 do
    Skinchanger.Skin[Skinchanger.Components[i].name] = Skinchanger.Components[i].value
end


function Skinchanger:Reset()
    for i = 1, #Skinchanger.Components, 1 do
        Skinchanger.Skin[Skinchanger.Components[i].name] = Skinchanger.Components[i].value
    end
end

function Skinchanger:GetMaxValues()
    local playerPed = PlayerPedId()

    local data = {
        sex          = 1,
        face         = 45,
        skin         = 45,
        age_1        = GetNumHeadOverlayValues(3) - 1,
        age_2        = 10,
        beard_1      = GetNumHeadOverlayValues(1) - 1,
        beard_2      = 10,

        beard_3      = GetNumHairColors() - 1,
        beard_4      = GetNumHairColors() - 1,

        hair_1       = GetNumberOfPedDrawableVariations(playerPed, 2) - 1,
        hair_2       = GetNumberOfPedTextureVariations(playerPed, 2, Skinchanger.Skin['hair_1']) - 1,

        hair_color_1 = GetNumHairColors() - 1,
        hair_color_2 = GetNumHairColors() - 1,

        eye_color    = 31,
        eyebrows_1   = GetNumHeadOverlayValues(2) - 1,
        eyebrows_2   = 10,

        eyebrows_3   = GetNumHairColors() - 1,
        eyebrows_4   = GetNumHairColors() - 1,

        makeup_1     = GetNumHeadOverlayValues(4) - 1,
        makeup_2     = 10,

        makeup_3     = GetNumHairColors() - 1,
        makeup_4     = GetNumHairColors() - 1,

        lipstick_1   = GetNumHeadOverlayValues(8) - 1,
        lipstick_2   = 10,

        lipstick_3   = GetNumHairColors() - 1,
        lipstick_4   = GetNumHairColors() - 1,

        blemishes_1  = GetNumHeadOverlayValues(0) - 1,
        blemishes_2  = 10,
        blush_1      = GetNumHeadOverlayValues(5) - 1,

        blush_2      = 10,
        blush_3      = GetNumHairColors() - 1,

        complexion_1 = GetNumHeadOverlayValues(6) - 1,
        complexion_2 = 10,
        sun_1        = GetNumHeadOverlayValues(7) - 1,
        sun_2        = 10,
        moles_1      = GetNumHeadOverlayValues(9) - 1,
        moles_2      = 10,
        chest_1      = GetNumHeadOverlayValues(10) - 1,
        chest_2      = 10,
        chest_3      = GetNumHairColors() - 1,

        bodyb_1      = GetNumHeadOverlayValues(11) - 1,
        bodyb_2      = 10,

        ears_1       = GetNumberOfPedPropDrawableVariations(playerPed, 1) - 1,

        ears_2       = GetNumberOfPedPropTextureVariations(playerPed, 1,
            Skinchanger.Skin['ears_1'] - 1),
        tshirt_1     = GetNumberOfPedDrawableVariations(playerPed, 8) - 1,

        tshirt_2     = GetNumberOfPedTextureVariations(playerPed, 8, Skinchanger.Skin['tshirt_1']) -
        1,
        torso_1      = GetNumberOfPedDrawableVariations(playerPed, 11) - 1,
        torso_2      = GetNumberOfPedTextureVariations(playerPed, 11, Skinchanger.Skin['torso_1']) -
        1,
        decals_1     = GetNumberOfPedDrawableVariations(playerPed, 10) - 1,
        decals_2     = GetNumberOfPedTextureVariations(playerPed, 10, Skinchanger.Skin['decals_1']) -
        1,

        arms         = GetNumberOfPedDrawableVariations(playerPed, 3) - 1,
        arms_2       = 10,
        pants_1      = GetNumberOfPedDrawableVariations(playerPed, 4) - 1,

        pants_2      = GetNumberOfPedTextureVariations(playerPed, 4, Skinchanger.Skin['pants_1']) - 1,
        shoes_1      = GetNumberOfPedDrawableVariations(playerPed, 6) - 1,
        shoes_2      = GetNumberOfPedTextureVariations(playerPed, 6, Skinchanger.Skin['shoes_1']) - 1,
        mask_1       = GetNumberOfPedDrawableVariations(playerPed, 1) - 1,
        mask_2       = GetNumberOfPedTextureVariations(playerPed, 1, Skinchanger.Skin['mask_1']) - 1,
        bproof_1     = GetNumberOfPedDrawableVariations(playerPed, 9) - 1,
        bproof_2     = GetNumberOfPedTextureVariations(playerPed, 9, Skinchanger.Skin['bproof_1']) -
        1,
        chain_1      = GetNumberOfPedDrawableVariations(playerPed, 7) - 1,
        chain_2      = GetNumberOfPedTextureVariations(playerPed, 7, Skinchanger.Skin['chain_1']) - 1,
        bags_1       = GetNumberOfPedDrawableVariations(playerPed, 5) - 1,
        bags_2       = GetNumberOfPedTextureVariations(playerPed, 5, Skinchanger.Skin['bags_1']) - 1,
        helmet_1     = GetNumberOfPedPropDrawableVariations(playerPed, 0) - 1,

        helmet_2     = GetNumberOfPedPropTextureVariations(playerPed, 0, Skinchanger.Skin
        ['helmet_1']) - 1,
        glasses_1    = GetNumberOfPedPropDrawableVariations(playerPed, 1) - 1,
        glasses_2    = GetNumberOfPedPropTextureVariations(playerPed, 1,
            Skinchanger.Skin['glasses_1'] - 1),
        watches_1    = GetNumberOfPedPropDrawableVariations(playerPed, 6) - 1,
        watches_2    = GetNumberOfPedPropTextureVariations(playerPed, 6,
            Skinchanger.Skin['watches_1']) - 1,
        bracelets_1  = GetNumberOfPedPropDrawableVariations(playerPed, 7) - 1,
        bracelets_2  = GetNumberOfPedPropTextureVariations(playerPed, 7,
            Skinchanger.Skin['bracelets_1'] - 1)
    }

    return data
end

function Skinchanger:LoadDefault(sex, cb, ...)
    Skinchanger.LastSkin = {}
    Skinchanger.SavedSkin = {}
    local args = { ... }

    local model = GetHashKey('mp_f_freemode_01')

    if not sex or sex == 'm' then
        model = GetHashKey('mp_m_freemode_01')
    end

    RequestModel(model)

    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(0)
    end

    if IsModelInCdimage(model) and IsModelValid(model) then
        SetPlayerModel(PlayerId(), model)
        SetPedDefaultComponentVariation(PlayerPedId())
    end

    SetModelAsNoLongerNeeded(model)

    ClearPedProp(PlayerPedId(), 0)

    DWB.PlayerData.Ped = PlayerPedId()

    Event:Trigger('dwb:skinchanger:load:default')

    if cb ~= nil then
        cb(table.unpack(args or {}))
    end
end

function Skinchanger:Refresh(cb)
    local playerPed = PlayerPedId()
    SetPedHeadBlendData(playerPed, Skinchanger.Skin['face'], self.Skin['face'], self.Skin['face'],
        self.Skin['skin'], self.Skin['skin'], self.Skin['skin'], 1.0, 1.0, 1.0, true)

    SetPedHairColor(playerPed, Skinchanger.Skin['hair_color_1'], self.Skin['hair_color_2'])                     -- Hair Color
    SetPedHeadOverlay(playerPed, 3, Skinchanger.Skin['age_1'], (self.Skin['age_2'] / 10) + 0.0)                 -- Age + opacity
    SetPedHeadOverlay(playerPed, 1, Skinchanger.Skin['beard_1'], (self.Skin['beard_2'] / 10) + 0.0)             -- Beard + opacity
    SetPedEyeColor(playerPed, Skinchanger.Skin['eye_color'], 0, 1)                                              -- Eyes color
    SetPedHeadOverlay(playerPed, 2, Skinchanger.Skin['eyebrows_1'],
        (self.Skin['eyebrows_2'] / 10) + 0.0)                                                                   -- Eyebrows + opacity
    SetPedHeadOverlay(playerPed, 4, Skinchanger.Skin['makeup_1'], (self.Skin['makeup_2'] / 10) + 0.0)           -- Makeup + opacity
    SetPedHeadOverlay(playerPed, 8, Skinchanger.Skin['lipstick_1'],
        (self.Skin['lipstick_2'] / 10) + 0.0)                                                                   -- Lipstick + opacity
    SetPedComponentVariation(playerPed, 2, Skinchanger.Skin['hair_1'], self.Skin['hair_2'], 2)                  -- Hair
    SetPedHeadOverlayColor(playerPed, 1, 1, Skinchanger.Skin['beard_3'], self.Skin['beard_4'])                  -- Beard Color
    SetPedHeadOverlayColor(playerPed, 2, 1, Skinchanger.Skin['eyebrows_3'], self.Skin['eyebrows_4'])            -- Eyebrows Color
    SetPedHeadOverlayColor(playerPed, 4, 1, Skinchanger.Skin['makeup_3'], self.Skin['makeup_4'])                -- Makeup Color
    SetPedHeadOverlayColor(playerPed, 8, 1, Skinchanger.Skin['lipstick_3'], self.Skin['lipstick_4'])            -- Lipstick Color
    SetPedHeadOverlay(playerPed, 5, Skinchanger.Skin['blush_1'], (self.Skin['blush_2'] / 10) + 0.0)             -- Blush + opacity
    SetPedHeadOverlayColor(playerPed, 5, 2, Skinchanger.Skin['blush_3'])                                        -- Blush Color
    SetPedHeadOverlay(playerPed, 6, Skinchanger.Skin['complexion_1'],
        (self.Skin['complexion_2'] / 10) + 0.0)                                                                 -- Complexion + opacity
    SetPedHeadOverlay(playerPed, 7, Skinchanger.Skin['sun_1'], (self.Skin['sun_2'] / 10) + 0.0)                 -- Sun Damage + opacity
    SetPedHeadOverlay(playerPed, 9, Skinchanger.Skin['moles_1'], (self.Skin['moles_2'] / 10) + 0.0)             -- Moles/Freckles + opacity
    SetPedHeadOverlay(playerPed, 10, Skinchanger.Skin['chest_1'], (self.Skin['chest_2'] / 10) + 0.0)            -- Chest Hair + opacity
    SetPedHeadOverlayColor(playerPed, 10, 1, Skinchanger.Skin['chest_3'])                                       -- Torso Color
    SetPedHeadOverlay(playerPed, 11, Skinchanger.Skin['bodyb_1'], (self.Skin['bodyb_2'] / 10) + 0.0)            -- Body Blemishes + opacity

    if Skinchanger.Skin['ears_1'] == -1 then
        ClearPedProp(playerPed, 2)
    else
        SetPedPropIndex(playerPed, 2, Skinchanger.Skin['ears_1'], self.Skin['ears_2'], 2) -- Ears Accessories
    end

    SetPedComponentVariation(playerPed, 8, Skinchanger.Skin['tshirt_1'], self.Skin['tshirt_2'], 2)   -- Tshirt
    SetPedComponentVariation(playerPed, 11, Skinchanger.Skin['torso_1'], self.Skin['torso_2'], 2)    -- torso parts
    SetPedComponentVariation(playerPed, 3, Skinchanger.Skin['arms'], self.Skin['arms_2'], 2)         -- Amrs
    SetPedComponentVariation(playerPed, 10, Skinchanger.Skin['decals_1'], self.Skin['decals_2'], 2)  -- decals
    SetPedComponentVariation(playerPed, 4, Skinchanger.Skin['pants_1'], self.Skin['pants_2'], 2)     -- pants
    SetPedComponentVariation(playerPed, 6, Skinchanger.Skin['shoes_1'], self.Skin['shoes_2'], 2)     -- shoes
    SetPedComponentVariation(playerPed, 1, Skinchanger.Skin['mask_1'], self.Skin['mask_2'], 2)       -- mask
    SetPedComponentVariation(playerPed, 9, Skinchanger.Skin['bproof_1'], self.Skin['bproof_2'], 2)   -- bulletproof
    SetPedComponentVariation(playerPed, 7, Skinchanger.Skin['chain_1'], self.Skin['chain_2'], 2)     -- chain
    SetPedComponentVariation(playerPed, 5, Skinchanger.Skin['bags_1'], self.Skin['bags_2'], 2)       -- Bag

    if Skinchanger.Skin['helmet_1'] == -1 then
        ClearPedProp(playerPed, 0)
    else
        SetPedPropIndex(playerPed, 0, Skinchanger.Skin['helmet_1'], self.Skin['helmet_2'], 2) -- Helmet
    end

    if Skinchanger.Skin['glasses_1'] == -1 then
        ClearPedProp(playerPed, 1)
    else
        SetPedPropIndex(playerPed, 1, Skinchanger.Skin['glasses_1'], self.Skin['glasses_2'], 2) -- Glasses
    end

    if Skinchanger.Skin['watches_1'] == -1 then
        ClearPedProp(playerPed, 6)
    else
        SetPedPropIndex(playerPed, 6, Skinchanger.Skin['watches_1'], self.Skin['watches_2'], 2) -- Watches
    end

    if Skinchanger.Skin['bracelets_1'] == -1 then
        ClearPedProp(playerPed, 7)
    else
        SetPedPropIndex(playerPed, 7, Skinchanger.Skin['bracelets_1'], self.Skin['bracelets_2'], 2) -- Bracelets
    end

    if cb then cb() end
end

function Skinchanger:UpdateImage()
    local ped = PlayerPedId()
    local handle = RegisterPedheadshot(ped)
    local timeout = 10

    while (not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle)) and timeout > 0 do
        timeout = timeout - 1
        Citizen.Wait(1000)
    end

    local txd = GetPedheadshotTxdString(handle)

    if IsPedheadshotValid(handle) then
        SendNuiMessage(json.encode({
            show = true,
            txd = txd,
            log = true,
            action = 'getImage'
        }))
    end

    UnregisterPedheadshot(handle)
end

function Skinchanger:Apply(skin, clothes)
    if skin then
        for k, v in pairs(skin) do
            Skinchanger.Skin[k] = v
        end
    end
    if clothes then
        if clothes.male then
            local sex = Skinchanger.Skin['sex']
            if sex == 1 and clothes.female then
                clothes = clothes.female
            else
                clothes = clothes.male
            end
        end
        for k, v in pairs(clothes) do
            if not Config.Clothes.Ignore[k] then
                Skinchanger.Skin[k] = v
            end
        end
    end
    self:Refresh(function ()
        Wait(1000)
        self:UpdateImage()
    end)
end

function Skinchanger:Change(skin)
    for k, v in pairs(skin) do
        local last = Skinchanger.Skin[k]
        if last ~= v then
            Skinchanger.Changes[k] = last
            Skinchanger.Skin[k] = v
        else
            Skinchanger.Skin[k] = Skinchanger.Changes[k]
            Skinchanger.Changes[k] = nil
        end
    end
    self:Refresh()
end

function Skinchanger:Set(k, v)
    self.Skin[k] = v
    if k == 'sex' then
        self:LoadDefault(v == 1 and 'f' or 'm', function ()
            self:Refresh()
        end)
    else
        self:Refresh()
    end
end

function Skinchanger:LoadSkin(skin)
    if skin['sex'] and skin['sex'] ~= self.Skin['sex'] then
        local skin = skin
        self:LoadDefault(skin['sex'] == 1 and 'f' or 'm', function ()
            self:Apply(skin)
            -- -- Event:TriggerNet('dwb:skin:save', self:GetSkin())
        end)
    else
        self:Apply(skin)
        -- -- Event:TriggerNet('dwb:skin:save', self:GetSkin())
    end
end

function Skinchanger:LoadClothes(skin, clothes)
    if skin['sex'] and skin['sex'] ~= self.Skin['sex'] then
        local skin = skin
        self:LoadDefault(skin['sex'] == 1 and 'f' or 'm', function ()
            self:Apply(skin, clothes)
        end)
    else
        self:Apply(skin, clothes)
    end
end

function Skinchanger:GetSkin(cb)
    return self.Skin
end

function Skinchanger:SaveSkin()
    self.RecentSaved = true
    for k, v in pairs(self.Skin) do
        self.LastSkin[k] = v
    end
end

function Skinchanger:SaveClothes(clothes)
    for k, v in pairs(clothes or self.Skin) do
        self.SavedSkin[k] = self.Skin[k]
    end
end

function Skinchanger:LoadSavedClothes()
    if self.SavedSkin['sex'] and (self.SavedSkin['sex'] ~= self.Skin['sex']) then
        self:LoadDefault(self.SavedSkin['sex'] == 1 and 'f' or 'm')
    end

    for k, v in pairs(self.SavedSkin) do
        self.Skin[k] = v
    end
    self:Refresh()
end

function Skinchanger:RestoreSkin()
    self.RecentSaved = false
    if self.LastSkin['sex'] and (self.LastSkin['sex'] ~= self.Skin['sex']) then
        self:LoadDefault(self.LastSkin['sex'] == 1 and 'f' or 'm')
    end

    for k, v in pairs(self.LastSkin) do
        self.Skin[k] = v
    end
    self.LastSkin = {}
    self:Refresh()
end

function Skinchanger:RestoreSkinOnly(clothes)
    if self.LastSkin['sex'] and (self.LastSkin['sex'] ~= self.Skin['sex']) then
        self:LoadDefault(self.LastSkin['sex'] == 1 and 'f' or 'm')
    end

    for k, v in pairs(self.LastSkin) do
        if clothes[k] then
            self.Skin[k] = v
        end
    end
    self:Refresh()
end

function Skinchanger:GetLast()
    return self.LastSkin
end

function Skinchanger:GetData()
    local comps = {}
    for k, v in pairs(Skinchanger.Components) do
        table.insert(comps, v)
    end
    for k, v in pairs(Skinchanger.Components) do
        for k2, v2 in pairs(comps) do
            if k == v2.name then
                comps[k2].value = v
            end
        end
    end
    return comps, self:GetMaxValues()
end

function Skinchanger:LoadEmpty()
    local clothe = Config.Clothes.Default
    if self.Skin['sex'] == 1 then
        self:LoadClothes(clothe.female)
    else
        self:LoadClothes(clothe.male)
    end
end

function Skinchanger:LoadSexClothes(clothes)
    if self.Skin['sex'] == 1 then
        self:LoadClothes(clothes.female)
    else
        self:LoadClothes(clothes.male)
    end
end
