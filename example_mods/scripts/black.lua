

function onSongStart()
	runTimer('creditsappare',1);
		runTimer('fade',0.5);
	end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'creditsappare' then
		doTweenY('creditsTweenY', 'credits', -1, 1.5, 'cubeOut')
  	runTimer('credits',2.5);
	end
		if tag == 'fade' then
			doTweenAlpha('fadeout', 'fade', 0, 3.5, 'linear')
			end
	if tag == 'credits' then
		doTweenY('creditsTweenY', 'credits', 500, 2, 'cubeIn')
			runTimer('credits',3);
	end
	if tag == 'disapare' then
			setProperty('credits.visible', false);
			end
	end
	
	

function onCreatePost()
makeLuaSprite('fade', 'Black', 0, 0)
	   scaleObject('fade', 3, 3)
	addLuaSprite('fade', true)
	setObjectCamera('fade', 'other');
end
