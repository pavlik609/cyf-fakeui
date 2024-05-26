-- A basic encounter script skeleton you can copy and modify for your own creations.
-- music = "shine_on_you_crazy_diamond" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "Poseur strikes a pose!" --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"bullettest_chaserorb"}
wavetimer = 4.0
arenasize = {155, 130}

enemies = {
"poseur"
}

enemypositions = {
{0, 0}
}
Inventory.AddCustomItems({"Anoying dog"}, {0})
timer = 0
-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"bullettest_bouncy", "bullettest_chaserorb", "bullettest_touhou"}

function EncounterStarting()
    -- If you want to change the game state immediately, this is the place.
    FakeUI_layer = "Top"
    FakeUI_soulColor = {255,0,0}
    require "fakeUI"
    Inventory.AddItem("Anoying dog",  1)
    local seed = os.time()
    math.randomseed(seed)
end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
end

function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    nextwaves = { possible_attacks[math.random(#possible_attacks)] }
end

function DefenseEnding() --This built-in function fires after the defense round ends.
    encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

beginFrm = 0
function HandleItem(ItemID)
    BattleDialog({"Selected item " .. ItemID .. "."})
end
function posCirc()
    if onFight == true then
        sprFg.x = sprFg.x+math.sin(timer)*5
        sprFg.y = sprFg.y+math.cos(timer)*5
        remberX = sprFg.x
        remberY = sprFg.y
        timer = timer + 0.1
    else
        sprFg.x = defFight
        sprFg.y = defY
    end
    if onAct == true then
        sprAc.x = sprAc.x+math.sin(timer)*5
        sprAc.y = sprAc.y+math.cos(timer)*5
        remberX = sprAc.x
        remberY = sprAc.y
        timer = timer + 0.1
    else
        sprAc.x = defAct
        sprAc.y = defY
    end
    if onItem == true then
        sprIt.x = sprIt.x+math.sin(timer)*5
        sprIt.y = sprIt.y+math.cos(timer)*5
        remberX = sprIt.x
        remberY = sprIt.y
        timer = timer + 0.1
    else
        sprIt.x = defItem
        sprIt.y = defY
    end
    if onMercy == true then
        sprMr.x = sprMr.x+math.sin(timer)*5
        sprMr.y = sprMr.y+math.cos(timer)*5
        remberX = sprMr.x
        remberY = sprMr.y
        timer = timer + 0.1
    else
        sprMr.x = defMercy
        sprMr.y = defY
    end
end
function rembPosCirc() --not done
    if onFight == true then
        if beginFrm == 1 then
            sprFg.x = remberX
            sprFg.y = remberY
            beginFrm = 0
        end
        sprFg.x = sprFg.x+math.sin(timer)*5
        sprFg.y = sprFg.y+math.cos(timer)*5
        remberX = sprFg.x
        remberY = sprFg.y
        timer = timer + 0.1
    else
        sprFg.x = defFight
        sprFg.y = defY
        beginFrm = 1
    end
end
function rotateToCursorFixed()
    if onFight == true then
        sprFg.rotation = math.atan2(sprFg.y - Input.MousePosY, sprFg.x - Input.MousePosX)*(180/math.pi)+180
        sprSoul.rotation = sprFg.rotation
        sprSoul.SetParent(sprFg)
        sprSoul.x = -soulOffsetX
        sprSoul.y = soulOffsetY-3
    else
        sprFg.rotation = 0
        sprSoul.rotation = 0
    end

    if onAct == true then
        sprAc.rotation = math.atan2(sprAc.y - Input.MousePosY, sprAc.x - Input.MousePosX)*(180/math.pi)+180
        sprSoul.rotation = sprAc.rotation
        sprSoul.SetParent(sprAc)
        sprSoul.x = -soulOffsetX
        sprSoul.y = soulOffsetY-3
    else
        sprAc.rotation = 0
    end

    if onItem == true then
        sprIt.rotation = math.atan2(sprIt.y - Input.MousePosY, sprIt.x - Input.MousePosX)*(180/math.pi)+180
        sprSoul.rotation = sprIt.rotation
        sprSoul.SetParent(sprIt)
        sprSoul.x = -soulOffsetX
        sprSoul.y = soulOffsetY-3
    else
        sprIt.rotation = 0
    end

    if onMercy == true then
        sprMr.rotation = math.atan2(sprMr.y - Input.MousePosY, sprMr.x - Input.MousePosX)*(180/math.pi)+180
        sprSoul.rotation = sprMr.rotation
        sprSoul.SetParent(sprMr)
        sprSoul.x = -soulOffsetX
        sprSoul.y = soulOffsetY-3
    else
        sprMr.rotation = 0
    end
    if sprFg.rotation > 90 and sprFg.rotation < 270 then
        sprFg.rotation = sprFg.rotation - 180
        sprSoul.rotation = sprSoul.rotation - 180
    end
    if sprAc.rotation > 90 and sprAc.rotation < 270 then
        sprAc.rotation = sprAc.rotation - 180
    end
    if sprIt.rotation > 90 and sprIt.rotation < 270 then
        sprIt.rotation = sprIt.rotation - 180
    end
    if sprMr.rotation > 90 and sprMr.rotation < 270 then
        sprMr.rotation = sprMr.rotation - 180
    end
    if GetCurrentState() ~= "ACTIONSELECT" then
        sprSoul.x = 777
        sprSoul.y = 777
    end
end
function tenseShake(shakyiness)
    sprFg.x = math.random(defFight-shakyiness,defFight+shakyiness)
    sprFg.y = math.random(defY-shakyiness,defY+shakyiness)
    sprAc.x = math.random(defAct-shakyiness,defAct+shakyiness)
    sprAc.y = math.random(defY-shakyiness,defY+shakyiness)
    sprIt.x = math.random(defItem-shakyiness,defItem+shakyiness)
    sprIt.y = math.random(defY-shakyiness,defY+shakyiness)
    sprMr.x = math.random(defMercy-shakyiness,defMercy+shakyiness)
    sprMr.y = math.random(defY-shakyiness,defY+shakyiness)
end
function Update()
    updateFakeUI()
    tenseShake(1)
    posCirc()
    rotateToCursorFixed()
    --rembPosCirc()
    --BlockItem()
    --BlockAct()
    --BlockFight()
    --BlockMercy()
    --posCirc()
    --rotateToCursorFixed()
    --sprFg.rotation = (timer*10)*5
    --sprAc.rotation = (timer*10)*2
    --sprIt.rotation = (timer*10)*9
    --sprMr.rotation = (timer*10)*1
end