-- Assignment commet: Not much information was provided so I am assuming the main goal is to have
-- a spell that have multiple phases with random title activation per phaase. The timing and activation 
-- frequency will was estimated to look similar. Since no damage was shown in the video I will hard code it to 100.

-- Instantiate the combat
local combat = Combat()
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

-- This will be triggered for each tile in the combat area
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onEachTile")

function onEachTile(creature, position)
	doSpellPerTile(creature:getId(), position, 0)
end

function doSpellPerTile(cid, position, count)
	if Creature(cid) then
		if count > 0 or math.random(1, 100) > 60 then
			position:sendMagicEffect(CONST_ME_ICETORNADO)
			doAreaCombat(cid, COMBAT_ICEDAMAGE, position, 0, -100, -100, CONST_ME_ICETORNADO) -- TODO - Add function to calculate damanage
		end

		if count < 4 then
			count = count + 1
			if count == 1 then
				addEvent(doSpellPerTile, math.random(500, 1000), cid, position, count)
			else
				addEvent(doSpellPerTile, math.random(1000, 2000), cid, position, count)
			end
		end
	end
end

-- This is called when I cast the spell
function onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

