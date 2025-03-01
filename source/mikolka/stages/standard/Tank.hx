package mikolka.stages.standard;

#if !LEGACY_PSYCH
import cutscenes.CutsceneHandler;
import substates.GameOverSubstate;
import objects.Character;
#end
import mikolka.compatibility.VsliceOptions;

class Tank extends BaseStage
{
	var tankWatchtower:BGSprite;
	var tankGround:BackgroundTank;
	var foregroundSprites:FlxTypedGroup<BGSprite>;

	override function create()
	{
		var sky:BGSprite = new BGSprite('tankSky', -400, -400, 0, 0);
		add(sky);

		if(!VsliceOptions.LOW_QUALITY)
		{
			var clouds:BGSprite = new BGSprite('tankClouds', FlxG.random.int(-700, -100), FlxG.random.int(-20, 20), 0.1, 0.1);
			clouds.active = true;
			clouds.velocity.x = FlxG.random.float(5, 15);
			add(clouds);

			var mountains:BGSprite = new BGSprite('tankMountains', -300, -20, 0.2, 0.2);
			mountains.setGraphicSize(Std.int(1.2 * mountains.width));
			mountains.updateHitbox();
			add(mountains);

			var buildings:BGSprite = new BGSprite('tankBuildings', -200, 0, 0.3, 0.3);
			buildings.setGraphicSize(Std.int(1.1 * buildings.width));
			buildings.updateHitbox();
			add(buildings);
		}

		var ruins:BGSprite = new BGSprite('tankRuins',-200,0,.35,.35);
		ruins.setGraphicSize(Std.int(1.1 * ruins.width));
		ruins.updateHitbox();
		add(ruins);

		if(!VsliceOptions.LOW_QUALITY)
		{
			var smokeLeft:BGSprite = new BGSprite('smokeLeft', -200, -100, 0.4, 0.4, ['SmokeBlurLeft'], true);
			add(smokeLeft);
			var smokeRight:BGSprite = new BGSprite('smokeRight', 1100, -100, 0.4, 0.4, ['SmokeRight'], true);
			add(smokeRight);

			tankWatchtower = new BGSprite('tankWatchtower', 100, 50, 0.5, 0.5, ['watchtower gradient color']);
			add(tankWatchtower);
		}

		tankGround = new BackgroundTank();
		add(tankGround);

		var ground:BGSprite = new BGSprite('tankGround', -420, -150);
		ground.setGraphicSize(Std.int(1.15 * ground.width));
		ground.updateHitbox();
		add(ground);

		foregroundSprites = new FlxTypedGroup<BGSprite>();
		foregroundSprites.add(new BGSprite('tank0', -500, 650, 1.7, 1.5, ['fg']));
		if(!VsliceOptions.LOW_QUALITY) foregroundSprites.add(new BGSprite('tank1', -300, 750, 2, 0.2, ['fg']));
		foregroundSprites.add(new BGSprite('tank2', 450, 940, 1.5, 1.5, ['foreground']));
		if(!VsliceOptions.LOW_QUALITY) foregroundSprites.add(new BGSprite('tank4', 1300, 900, 1.5, 1.5, ['fg']));
		foregroundSprites.add(new BGSprite('tank5', 1620, 700, 1.5, 1.5, ['fg']));
		if(!VsliceOptions.LOW_QUALITY) foregroundSprites.add(new BGSprite('tank3', 1300, 1200, 3.5, 2.5, ['fg']));

		setDefaultGF('gf-tankmen');
		super.create();
	}

	override function countdownTick(count:Countdown, num:Int) if(num % 2 == 0) everyoneDance();
	override function beatHit() {
		everyoneDance();
		super.beatHit();
	}
	function everyoneDance()
	{
		if(!VsliceOptions.LOW_QUALITY) tankWatchtower.dance();
		foregroundSprites.forEach(function(spr:BGSprite)
		{
			spr.dance();
		});
	}
}