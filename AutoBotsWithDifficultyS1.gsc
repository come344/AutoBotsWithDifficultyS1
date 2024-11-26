#include maps\mp\bots\_bots;
/*
    Mod: Autobots
    Developed by DoktorSAS
	Difficulty Addition By Kalitos
	Tested by BoxOfMysteriez
*/

init()
{
    level thread onPlayerConnect();
    level thread serverBotFill();
	level thread setDiffBots();
}
onPlayerConnect()
{
	level endon("game_ended");
	for (;;)
	{
		level waittill("connected", player);
		if(!player isentityabot())
		{
			  player thread kickBotOnJoin();
		}
	}
}

isentityabot()
{
	return isSubStr(self getguid(), "bot");
}
serverBotFill()
{
    level endon("game_ended");
	  level waittill("connected", player);
    for(;;)
    {
        while(level.players.size < 18 && !level.gameended)
        {
			self spawnBots(11);
            wait 1;
        }
        if(level.players.size >= 18 && contBots() > 0)
            kickbot();

        wait 0.05;
    }
}

contBots()
{
    bots = 0;
    foreach (player in level.players) 
    {
        if (player isentityabot()) 
        {
            bots++;
        }
    }
    return bots;
}

spawnBots(a)
{
    spawn_bots(a, "autoassign"); // spawnbots(n, team); 
}

kickbot()
{
    level endon("game_ended");
    foreach (player in level.players) 
    {
        if (player isentityabot()) 
        {
            player bot_drop(); //  bot_drop();
            break;
        }
    }
}

kickBotOnJoin()
{
    level endon("game_ended");
    foreach (player in level.players) 
    {
        if (player isentityabot()) 
        {
	          player bot_drop(); //  bot_drop();
            break;
        }
    }
}

/*
	Set Bot difficulty below with the setDiffBots function
	Level 1 - 2 "recruit"
	Level 17 - 25 "regular"
	Level 37 - 44 "hardened"
	Level 47 - 50 with Prestige - "Veteran"
	
	Add aditional slots for mixed difficulty. Example: [ "hardened, "veteran" ] 
*/

setDiffBots()
{
    for(;;)
    {
        level waittill("connected", player);
        if(isBot(player))
        {
			player maps\mp\bots\_bots_util::_id_16EB( common_scripts\utility::random( [ "regular", "hardened" ] ), undefined );
        }
    }
}