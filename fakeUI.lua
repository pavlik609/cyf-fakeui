--                            ________ ________  ___  __    _______           ___  ___  ___          ___      ___             ________    _____                                --
--                           |\  _____\\   __  \|\  \|\  \ |\  ___ \         |\  \|\  \|\  \        |\  \    /  /|           |\   __  \  / __  \                               --
-- ____________  ____________\ \  \__/\ \  \|\  \ \  \/  /|\ \   __/|        \ \  \\\  \ \  \       \ \  \  /  / /___________\ \  \|\  \|\/_|\  \  ____________  ____________  --
--|\____________\\____________\ \   __\\ \   __  \ \   ___  \ \  \_|/__       \ \  \\\  \ \  \       \ \  \/  / /\____________\ \  \\\  \|/ \ \  \|\____________\\____________\--
--\|____________\|____________|\ \  \_| \ \  \ \  \ \  \\ \  \ \  \_|\ \       \ \  \\\  \ \  \       \ \    / /\|____________|\ \  \\\  \ __\ \  \|____________\|____________|--
--                              \ \__\   \ \__\ \__\ \__\\ \__\ \_______\       \ \_______\ \__\       \ \__/ /                 \ \_______\\__\ \__\                           --
--                               \|__|    \|__|\|__|\|__| \|__|\|_______|        \|_______|\|__|        \|__|/                   \|_______\|__|\|__|                           --
-- RELEASE-0.1 DD/MM/YYYY 25/5/2024
-- cool text site used  https://patorjk.com/software/taag
--BY : https://www.reddit.com/user/Speed_Gun / https://www.youtube.com/@speedg
--do whatever just credit me
SetButtonLayer("Bottom")


sprFgBL = CreateSprite("FakeUI/BLACK_B",   FakeUI_layer,  1)
sprAcBL = CreateSprite("FakeUI/BLACK_B",   FakeUI_layer,  1)
sprItBL = CreateSprite("FakeUI/BLACK_B",   FakeUI_layer,  1)
sprMrBL = CreateSprite("FakeUI/BLACK_B",   FakeUI_layer,  1)
sprFgBL.x = 87
sprFgBL.y = 27
sprAcBL.x = 240
sprAcBL.y = 27
sprItBL.x = 400
sprItBL.y = 27
sprMrBL.x = 555
sprMrBL.y = 27



sprFg = CreateSprite("FakeUI/Ffightbt_0",   FakeUI_layer,  -1)
sprAc = CreateSprite("FakeUI/Factbt_0",   FakeUI_layer,  -1)
sprIt = CreateSprite("FakeUI/Fitembt_0",   FakeUI_layer, -1)
sprMr = CreateSprite("FakeUI/Fmercybt_0",  FakeUI_layer, -1)
sprSoul = CreateSprite("FakeUI/soul", FakeUI_layer, -1)
sprFg.x = 87
sprFg.y = 27
sprAc.x = 240
sprAc.y = 27
sprIt.x = 400
sprIt.y = 27
sprMr.x = 555
sprMr.y = 27

onFight = false
onAct   = false
onItem  = false
onMercy = false

enemySelectIsAttacking = -1 -- -1 = none, 0 = act menu, 1 = fight menu
itemButtonPersist = 0

fightBlocked = false
actBlocked = false
itemBlocked = false
mercyBlocked = false

defFight = 87 --default values
defAct = 240
defItem = 400
defMercy = 555
defY = 27

soulOffsetX = 39
soulOffsetY = 2

sprFg1 = CreateSprite("FakeUI/Ffightbt_1", FakeUI_layer, -1)
sprAc1 = CreateSprite("FakeUI/Factbt_1",   FakeUI_layer, -1)
sprIt1 = CreateSprite("FakeUI/Fitembt_1",  FakeUI_layer, -1)
sprMr1 = CreateSprite("FakeUI/Fmercybt_1", FakeUI_layer, -1)
function setPosRot()
    sprFg1.x = sprFg.x
    sprFg1.y = sprFg.y
    sprFg1.rotation = sprFg.rotation
    sprAc1.x = sprAc.x
    sprAc1.y = sprAc.y
    sprAc1.rotation = sprAc.rotation
    sprIt1.x = sprIt.x
    sprIt1.y = sprIt.y
    sprIt1.rotation = sprIt.rotation
    sprMr1.x = sprMr.x
    sprMr1.y = sprMr.y
    sprMr1.rotation = sprMr.rotation
end
--\\\\\  -CHEAT SHEET, PLAYER POSITION-  /////
--ATTACKING -272
--ACT -118
--ITEM 41
--MERCYMENU 195
function updateFakeUI()
    setPosRot()

    state = GetCurrentState()

    sprSoul.color32 = FakeUI_soulColor
    if Player.x == -272 and Player.y == -135 then
        sprFg.alpha32  = 0
        sprFg1.alpha32 = 255
        onFight = true
        sprSoul.x = sprFg.x-soulOffsetX
        sprSoul.y = sprFg.y-soulOffsetY
        if Input.Confirm == 1 then 
            enemySelectIsAttacking = 1
        end
    else 
        sprFg.alpha32  = 255
        sprFg1.alpha32 = 0
        onFight = false
    end

    if Player.x == -118 and Player.y == -135 then
        sprAc.alpha32  = 0
        sprAc1.alpha32 = 255
        onAct = true
        sprSoul.x = sprAc.x-soulOffsetX
        sprSoul.y = sprAc.y-soulOffsetY
        if Input.Confirm == 1 then 
            enemySelectIsAttacking = 0
        end
    else 
        sprAc.alpha32  = 255
        sprAc1.alpha32 = 0
        onAct = false
    end

    if state == "ENEMYSELECT" then
        if Input.Cancel == 1 then
            if enemySelectIsAttacking == 0 then
                sprAc.alpha32  = 0
                sprAc1.alpha32 = 255
                sprSoul.x = sprAc.x-soulOffsetX
                sprSoul.y = sprAc.y-soulOffsetY
                onAct = true
            end
            enemySelectIsAttacking = -1
            if enemySelectIsAttacking == 1 then
                sprFg.alpha32  = 0
                sprFg1.alpha32 = 255
                onFight = true
                sprSoul.x = sprFg.x-soulOffsetX
                sprSoul.y = sprFg.y-soulOffsetY
            end
        else
            if enemySelectIsAttacking == 0 then
                sprAc.alpha32  = 0
                sprAc1.alpha32 = 255
                sprSoul.x = 777
                sprSoul.y = 777
                onAct = true
            end

            if enemySelectIsAttacking == 1 then
                sprFg.alpha32  = 0
                sprFg1.alpha32 = 255
                onFight = true
                sprSoul.x = 777
                sprSoul.y = 777
            end
        end
    end
    if state == "ATTACKING" then 
        sprFg.alpha32  = 0
        sprFg1.alpha32 = 255
        onFight = true
        sprSoul.x = 777
        sprSoul.y = 777
    end
    if state == "ACTMENU" then 
        sprAc.alpha32  = 0
        sprAc1.alpha32 = 255
        onAct = true
        sprSoul.x = 777
        sprSoul.y = 777
    end

    if Player.x == 41 and Player.y == -135 then
        sprIt.alpha32  = 0
        sprIt1.alpha32 = 255
        onItem = true
        sprSoul.x = sprIt.x-soulOffsetX
        sprSoul.y = sprIt.y-soulOffsetY
    else 
        sprIt.alpha32  = 255
        sprIt1.alpha32 = 0
        onItem = false
    end
    if state == "DIALOGRESULT" then
        if enemySelectIsAttacking == 0 then
            sprAc.alpha32  = 0
            sprAc1.alpha32 = 255
            sprSoul.x = 777
            sprSoul.y = 777
            onAct = true
        end
        if itemButtonPersist == 1 then
            sprIt.alpha32  = 0
            sprIt1.alpha32 = 255
            sprSoul.x = 777
            sprSoul.y = 777
        end
    end
    if state == "ITEMMENU" then 
        onItem = true
        sprIt.alpha32  = 0
        sprIt1.alpha32 = 255
        sprSoul.x = 777
        sprSoul.y = 777
        if Input.Confirm == 1 then 
            itemButtonPersist = 1
        end
    end
    if Player.x == 195 and Player.y == -135 then
        sprMr.alpha32  = 0
        sprMr1.alpha32 = 255
        onMercy = true
        sprSoul.x = sprMr.x-soulOffsetX
        sprSoul.y = sprMr.y-soulOffsetY
    else 
        sprMr.alpha32  = 255
        sprMr1.alpha32 = 0
        onMercy = false
    end
    if state == "MERCYMENU" then 
        onMercy = true
        sprMr.alpha32  = 0
        sprMr1.alpha32 = 255
        sprSoul.x = 777
        sprSoul.y = 777
    end
    if itemButtonPersist == 1 then
        onItem = true
    end
end
function EnteringState(newstate, oldstate)
    if newstate == "ENEMYDIALOGUE" then
        itemButtonPersist = 0
    end
end
--CHEAT CHEET, PLAYER POSITION
--FIGHT -272
--ACT -118
--ITEM 41
--MERCYMENU 195

--                            ________  ___       ________  ________  ___  __            ________  _______   ________ _________  ___  ________  ________                                 
--                          |\   __  \|\  \     |\   __  \|\   ____\|\  \|\  \         |\   ____\|\  ___ \ |\   ____\\___   ___\\  \|\   __  \|\   ___  \                                --
-- ____________  ____________\ \  \|\ /\ \  \    \ \  \|\  \ \  \___|\ \  \/  /|_       \ \  \___|\ \   __/|\ \  \___\|___ \  \_\ \  \ \  \|\  \ \  \\ \  \  ____________  ____________  --
--|\____________\\____________\ \   __  \ \  \    \ \  \\\  \ \  \    \ \   ___  \       \ \_____  \ \  \_|/_\ \  \       \ \  \ \ \  \ \  \\\  \ \  \\ \  \|\____________\\____________\--
--\|____________\|____________|\ \  \|\  \ \  \____\ \  \\\  \ \  \____\ \  \\ \  \       \|____|\  \ \  \_|\ \ \  \____   \ \  \ \ \  \ \  \\\  \ \  \\ \  \|____________\|____________|--
--                              \ \_______\ \_______\ \_______\ \_______\ \__\\ \__\        ____\_\  \ \_______\ \_______\  \ \__\ \ \__\ \_______\ \__\\ \__\                           --
--                               \|_______|\|_______|\|_______|\|_______|\|__| \|__|       |\_________\|_______|\|_______|   \|__|  \|__|\|_______|\|__| \|__|                           --
stop = 0
function BlockFight()
    fightBlocked = true
    if actBlocked == true and itemBlocked == true and mercyBlocked == true and GetCurrentState() == "ACTIONSELECT" then State("ENEMYDIALOGUE") sprSoul.x = 999 end
    if(Player.x == -118) then
        if(Input.Left == 1) then
            SetAction("FIGHT")
            if mercyBlocked == true then SetAction("MERCY") end
            if mercyBlocked == true and itemBlocked == true then SetAction("ITEM") end
            encountertext = "[instant]" .. encountertext
        end
    end
    if(Player.x == 195) then
        if(Input.Right == 1) then
            SetAction("FIGHT")
            if actBlocked == true then SetAction("ACT") end
            if actBlocked == true and itemBlocked == true then SetAction("ITEM") end
            encountertext = "[instant]" .. encountertext
        end
    end
end
function BlockAct()
    actBlocked = true
    if actBlocked == true and itemBlocked == true and mercyBlocked == true and GetCurrentState() == "ACTIONSELECT" then State("ENEMYDIALOGUE") sprSoul.x = 999 end
    if(Player.x == 41) then
        if(Input.Left == 1) then
            SetAction("ACT")
            if fightBlocked == true then SetAction("FIGHT") end
            if fightBlocked == true and mercyBlocked == true then SetAction("MERCY") end
        end
    end
    if(Player.x == -272) then
        if(Input.Right == 1) then
            SetAction("ACT")
            if itemBlocked == true then SetAction("ITEM") end
            if itemBlocked == true and mercyBlocked == true then SetAction("MERCY") end
        end
    end
end
function BlockItem()
    itemBlocked = true
    if actBlocked == true and fightBlocked == true and mercyBlocked == true and GetCurrentState() == "ACTIONSELECT" then State("ENEMYDIALOGUE") sprSoul.x = 999 end
    if(Player.x == 195) then
        if(Input.Left == 1) then
            SetAction("ITEM")
            if actBlocked == true then SetAction("ACT") end
            if actBlocked == true and fightBlocked == true then SetAction("FIGHT") end
        end
    end
    if(Player.x == -118) then
        if(Input.Right == 1) then
            SetAction("ITEM")
            if mercyBlocked == true then SetAction("MERCY") end
            if mercyBlocked == true and fightBlocked == true then SetAction("FIGHT") end
        end
    end
end
function BlockMercy()
    mercyBlocked = true
    if actBlocked == true and itemBlocked == true and mercyBlocked == true and GetCurrentState() == "ACTIONSELECT" then State("ENEMYDIALOGUE") sprSoul.x = 999 end
    if(Player.x == -272) then
        if(Input.Left == 1) then
            SetAction("MERCY")
            if itemBlocked == true then SetAction("ITEM") end
            if itemBlocked == true and actBlocked == true then SetAction("ACT") end
        end
    end
    if(Player.x == 41) then
        if(Input.Right == 1) then
            SetAction("MERCY")
            if fightBlocked == true then SetAction("FIGHT") end
            if fightBlocked == true and actBlocked == true then SetAction("ACT") end
        end
    end
end