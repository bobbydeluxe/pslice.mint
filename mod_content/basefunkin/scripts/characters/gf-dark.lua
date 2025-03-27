--[[
    This is the script for the characters when they're in the 'spookyErect' stage.
    Just set the character's name, and this script will handle the rest on its own,
    so you can use it on other characters.

    WARNING!: This script is meant to be used on the dark varient of the character's sprite.
    If you don't have them, just use your normal character, 
    since the 'spookyErect' stage has a way to deal with those.
    Also, make sure that the normal and dark varients of your character have the same frames and offsets in their animation,
    or else the script won't be able to sync them up.
]]
local characterName = 'gf-dark' -- Set your character's name here
local characterPos = {}
local isPlayer = false
local propertyTracker = {
    {'x', nil},
    {'y', nil},
    {'color', nil},
    {'scrollFactor.x', nil},
    {'scrollFactor.y', nil},
    {'angle', nil},
    {'antialiasing', nil},
    {'visible', nil}
}
function onCreatePost()
    characterType = getCharacterType(characterName)
    characterPos = {x = getProperty(characterType..'.x'), y = getProperty(characterType..'.y')}
    if characterType == 'boyfriend' then
        isPlayer = true
    end
    createInstance(characterType..'Light', 'objects.Character', {characterPos.x, characterPos.y, characterName:gsub('-dark', ''), isPlayer})
    setObjectOrder(characterType..'Light', getObjectOrder(characterType..'Group'))
    addInstance(characterType..'Light')

    addLuaScript('scripts/characters/props/speaker')
    callScript('scripts/characters/props/speaker', 'createSpeaker', {'gf-dark', 0, 304}) -- {characterName, offsetX, offsetY}
end

function onUpdatePost(elapsed)
    for property = 1, #propertyTracker do
        local propName = propertyTracker[property][1]
        local currentValue = getProperty(characterType..'.'..propName)

        if propertyTracker[property][2] ~= currentValue then
            propertyTracker[property][2] = currentValue

            -- Add +225 if x
            if propName == 'x' then
                setProperty(characterType..'Light.x', currentValue + 225)

            -- Skip alpha if stage is spookyErect
            elseif propName == 'alpha' and curStage == 'spookyErect' then
                -- Do nothing (skip syncing alpha)

            -- Sync everything else
            else
                setProperty(characterType..'Light.'..propName, currentValue)
            end
        end
    end

    if getObjectOrder(characterType..'Light') ~= getObjectOrder(characterType..'Group') - 1 then
        setObjectOrder(characterType..'Light', getObjectOrder(characterType..'Group'))
    end

    playAnim(characterType..'Light',
        getProperty(characterType..'.animation.name'),
        true,
        getProperty(characterType..'.animation.curAnim.reversed'),
        getProperty(characterType..'.animation.curAnim.curFrame')
    )
end


function getCharacterType(characterName)
    if boyfriendName == characterName then
        return 'boyfriend'
    elseif dadName == characterName then
        return 'dad'
    elseif gfName == characterName then
        return 'gf'
    end
end