
function onCreate()
	-- background shit
	makeLuaSprite('w', 'idkStage', -450, -250);
		scaleObject('w', 1.1, 1.1);
		
		makeLuaSprite('frame', 'blackframe', 0, 0);
		setObjectCamera('frame', 'hud')
		
	makeLuaSprite('roof', 'roofshadow', -450, -250);
	scaleObject('roof', 1.1, 1.1);
	
	makeAnimatedLuaSprite('stage2', 'yessir', -450, -250); 
addAnimationByPrefix('stage2', 'stage2', 'bgstage', 15, true);
scaleObject('stage2', 1.1, 1.1);

makeAnimatedLuaSprite('grain', 'grain', 0, 0); 
addAnimationByPrefix('grain', 'grain', 'grain', 24, true);
scaleObject('grain', 1.25, 1.25);
setObjectCamera('grain', 'other')


	addLuaSprite('w', false);
	addLuaSprite('grain', false);
	addLuaSprite('roof', true);
	addLuaSprite('frame', false);
	addLuaSprite('stage2', false);
	
	doTweenAlpha('hud', 'camHUD', 0, 0.001, 'linear')
	doTweenAlpha('stage2', 'stage2', 0, 0.001, 'linear')
end


function onStepHit()
if curStep == 32 then
doTweenAlpha('hud', 'camHUD', 1, 1.35, 'linear')
end
if curStep == 1840 then
doTweenAlpha('fadeout', 'fade', 1, 0.001, 'linear')
end
if curStep == 1840 then
doTweenAlpha('roof', 'roof', 0, 0.001, 'linear')
doTweenAlpha('w', 'w', 0, 0.001, 'linear')
doTweenAlpha('fadeout', 'fade', 1, 0.001, 'linear')
doTweenAlpha('hud', 'camHUD', 0, 0.001, 'linear')
doTweenAlpha('stage2', 'stage2', 1, 0.001, 'linear')
end
if curStep == 1872 then
doTweenAlpha('fadeout', 'fade', 0, 10, 'linear')
end
if curStep == 1920 then
doTweenAlpha('hud', 'camHUD', 1, 3.5, 'linear')
end
if curStep == 3260 then
doTweenAlpha('fadeout', 'fade', 1, 4, 'linear')
end
if curStep == 3312 then
doTweenAlpha('fadeout', 'fade', 0, 0.001, 'linear')
cameraFlash('other','ffffff',2)
doTweenAlpha('hud', 'camHUD', 0, 0.001, 'linear')
end
if curStep == 3593 then
doTweenAlpha('fadeout', 'fade', 1, 0.001, 'linear')
end
end

function opponentNoteHit()
	if dadName == 'inkdemon' then
triggerEvent('Screen Shake','0.1, 0.005','0.1, 0.005')
	health = getProperty('health')
	if getProperty('health') > 0.2 then
	setProperty('health', health- 0.0135);
	end
end
end