global function Slay
global function SlayCommand

void function SlayCommand()
{
	#if SERVER
	AddClientCommandCallback("slay", SlayCMD);
	#endif
}

bool function SlayCMD(entity player, array<string> args)
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
		print("Example: slay <playerID> <playerID2> <playerID3> ... / team_imc / team_militia / all");
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
					Slay(p)
			}
		break;
		
		case ("team_imc"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_IMC )) 
			{	
				if (p != null)
					Slay(p)
			}
		break;
		
		case ("team_militia"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_MILITIA )) 
			{	
				if (p != null)
					Slay(p)
			}
		break;
		
		default:
			int a = args[0].tointeger();
			try {
				player = players[a];
				if (player != null)
					Slay(player)
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
					Slay(player)
			} catch(ex) {
				print("Unknown ID/Player.");
			}
		}
	}
	
	#endif
	return true;
}

void function Slay(entity player)
{
#if SERVER
	try {
		if ( IsAlive( player ) )
			player.Die()
	} catch(e) 
	{	
		print("Unable to slay " + player.GetPlayerName() + ". Could be unalive lol.")
	}
#endif
}	