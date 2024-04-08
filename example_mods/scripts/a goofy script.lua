local campointx = 0
local campointy = 0
local bfturn = false
local camMovement = 30
local velocity = 2

--a cameraarrow script--



    -- edit these 2 last values up here so you dont have to manually do every single one
    
function onMoveCamera(focus)
    if focus == 'boyfriend' then
    campointx = getProperty('camFollow.x')
    campointy = getProperty('camFollow.y')
    bfturn = true
    
    elseif focus == 'dad' then
    campointx = getProperty('camFollow.x')
    campointy = getProperty('camFollow.y')
    bfturn = false
    setProperty('cameraSpeed', 1.23)
    
    end
end


function goodNoteHit(id, direction, noteType, isSustainNote)
    if bfturn then
        if direction == 0 then
            setProperty('camFollow.x', campointx - camMovement)
        elseif direction == 1 then
            setProperty('camFollow.y', campointy + camMovement)
        elseif direction == 2 then
            setProperty('camFollow.y', campointy - camMovement)
        elseif direction == 3 then
            setProperty('camFollow.x', campointx + camMovement)
        end
        setProperty('cameraSpeed', velocity)
        end
end

        -- delete this if you dont want the oponent to move the camera
function opponentNoteHit(id, direction, noteType, isSustainNote)
       health = getProperty('health')
    if not bfturn then
        if direction == 0 then
            setProperty('camFollow.x', campointx - camMovement)
        elseif direction == 1 then
            setProperty('camFollow.y', campointy + camMovement)
        elseif direction == 2 then
            setProperty('camFollow.y', campointy - camMovement)
        elseif direction == 3 then
            setProperty('camFollow.x', campointx + camMovement)
        end
        setProperty('cameraSpeed', velocity)
	end
end



--custom countdown script--
function onCountdownTick(counter)
	if counter == 0 then
	elseif counter == 1 then
	doTweenX('scaleX', 'CountTwo.scale', 1.2, 0.35, 'cubeOut')
		doTweenY('scaleY', 'CountTwo.scale', 1.2, 0.35, 'cubeOut')
		setProperty('CountTwo.visible', true)
		doTweenAlpha('TwoFade', 'CountTwo', 0, FadeTime, FadeEase)
		setProperty('countdownReady.visible', false)
			    runTimer('count', 0.07);
	elseif counter == 2 then
			doTweenY('scaleY', 'CountOne.scale', 1.2, 0.35, 'cubeOut')
		doTweenX('scaleX', 'CountOne.scale', 1.2, 0.35, 'cubeOut')
                                        setProperty('CountOne.visible', true)
		doTweenAlpha('OneFade', 'CountOne', 0, FadeTime, FadeEase)
		setProperty('countdownSet.visible', false)
			    runTimer('count2', 0.07);
	elseif counter == 3 then
			doTweenY('scaleY', 'CountGO.scale', 1.2, 0.35, 'cubeOut')
		doTweenX('scaleX', 'CountGO.scale', 1.2, 0.35, 'cubeOut')
		setProperty('CountGO.visible', true)
		doTweenAlpha('GoFade', 'CountGO', 0, FadeTime, FadeEase)
		setProperty('countdownGo.visible', false)
		    runTimer('count3', 0.07);
	end
end

function onCreate()  
--Two
                    makeLuaSprite('CountTwo', 'ready', 0, 0)
	screenCenter('CountTwo', 'xy')
	setObjectCamera('CountTwo', 'other')
	setProperty('CountTwo.visible', false)
--One
	makeLuaSprite('CountOne', 'set', 0, 0)
	screenCenter('CountOne', 'xy')
	setObjectCamera('CountOne', 'other')
	setProperty('CountOne.visible', false)
--Go	
	makeLuaSprite('CountGO', 'go', 0, 0)
	screenCenter('CountGO', 'xy')
	setObjectCamera('CountGO', 'other')
	setProperty('CountGO.visible', false)
--Add Lua Sprites
	addLuaSprite('CountTwo', true)
	addLuaSprite('CountOne', true)
	addLuaSprite('CountGO', true)
end

   function onTimerCompleted(tag, loops, loopsleft)
       	if tag == 'count' then
       			doTweenAlpha('fadeout5', 'CountTwo', 0, 0.3, 'linear')
       end
       	if tag == 'count2' then
           		doTweenAlpha('fadeout6', 'CountOne', 0, 0.3, 'linear')
       end
              	if tag == 'count3' then
           		doTweenAlpha('fadeout7', 'CountGO', 0, 0.3, 'linear')
       end
       end
       
       function onUpdate()      
    setTextFont('timeTxt', 'DK-Black-Bamboo.ttf');
    setTextFont('botplayTxt', 'DK-Black-Bamboo.ttf');
    setTextFont('scoreTxt', 'DK-Black-Bamboo.ttf');
        end
       
       