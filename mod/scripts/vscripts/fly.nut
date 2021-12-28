global function FlyCommand
global function Fly

void function FlyCommand()
{
	#if SERVER
	AddClientCommandCallback("fly", FlyCMD);
	#endif
}

bool function FlyCMD(entity player, array<string> args)
{
	#if SERVER
	entity weapon = null;
	string weaponId = ("");
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
		print("Example: fly <playerId> <playerId2> ... / team_imc / team_militia / all");
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
	// if player typed "fly somethinghere"
	switch (args[0]) 
	{
		case ("all"):
			foreach (entity p in GetPlayerArray()) 
			{	
				if (p != null)
					Fly(p)
			}
		break;
		
		case ("team_imc"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_IMC )) 
			{	
				if (p != null)
					Fly(p)
			}
		break;
		
		case ("team_militia"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_MILITIA )) 
			{	
				if (p != null)
					Fly(p)
			}
		break;
			
		default:
			int a = args[0].tointeger();
			try {
				player = players[a];
				if (player != null)
					Fly(player)
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
					Fly(player)
			} catch(ex) {
				print("Unknown ID/Player.");
			}
		}
	}
	#endif
	return true;
}

void function Fly( entity player )
{
	#if SERVER
	if ( player.IsNoclipping() )
		player.SetPhysics( MOVETYPE_WALK )
	else
		player.SetPhysics( MOVETYPE_NOCLIP )
#endif
}
