global function Titanfall
global function TitanfallCommand

void function TitanfallCommand()
{
	#if SERVER
	AddClientCommandCallback("titanfall", TitanfallCMD);
	AddClientCommandCallback("tf", TitanfallCMD);
	#endif
}

bool function TitanfallCMD(entity player, array<string> args)
{
	#if SERVER
	array<entity> players = GetPlayerArray();
	hadGift_Admin = false;
	CheckAdmin(player);
	if (hadGift_Admin != true)
	{
		print("Admin permission not detected.");
		return true;
	}
	
	// if player only typed "gift"
	if (args.len() == 0)
	{
		print("Give a valid argument.");
		print("Example: titanfall/tf <playerID> <playerID2> <playerID3> ... / all");
		// print every single player's name and their id
		int i = 0;
		foreach (entity p in GetPlayerArray())
		{	
			string playername = p.GetPlayerName();
			print("[" + i.tostring() + "] " + playername);
			i++
		}
		return true;
	}
	
	switch (args[0]) 
	{
		case ("all"):
			foreach (entity p in GetPlayerArray()) 
			{	
				if (p != null)
					Titanfall(p)
			}
		break;
		
		case ("team_imc"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_IMC )) 
			{	
				if (p != null)
					Titanfall(p)
			}
		break;
		
		case ("team_militia"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_MILITIA )) 
			{	
				if (p != null)
					Titanfall(p)
			}
		break;
		
		default:
			int a = args[0].tointeger();
			try {
				player = players[a];
				if (player != null)
					Titanfall(player)
			} catch(ex) {
				print("Unknown ID/Player.");
			}
		break;
	}
	if (args.len() > 1) {
		array<string> playersname = args.slice(1);
		foreach (string playerId in playersname)
		{
			int a = playerId.tointeger();
			try {
				player = players[a];
				if (player != null)
					Titanfall(player)
			} catch(ex) {
				print("Unknown ID/Player.");
			}
		}
	}
	
	#endif
	return true;
}

void function Titanfall(entity player)
{
#if SERVER
	try {
		if (!player.IsTitan()) {
			if ( SpawnPoints_GetTitan().len() > 0 )
				thread CreateTitanForPlayerAndHotdrop( player, GetTitanReplacementPoint( player, false ) )
		}
	} catch(e) 
	{	
		print("Unable to drop " + player.GetPlayerName() + "'s titan. Could be already has a Titan lol.")
	}
#endif
}	