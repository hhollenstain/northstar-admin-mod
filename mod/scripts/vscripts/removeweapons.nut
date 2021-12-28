global function RemoveWeaponsCommand
global function RemoveWeapon

void function RemoveWeaponsCommand()
{
	#if SERVER
	AddClientCommandCallback("removeweapon", RemoveWeaponsCMD);
	AddClientCommandCallback("rw", RemoveWeaponsCMD);
	#endif
}

bool function RemoveWeaponsCMD(entity player, array<string> args)
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
		print("Example: removeweapon/rw <playerId> <playerId2> ... / team_imc / team_militia / all");
		print("This removes main weapons only lol");
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
	// if player typed "rw somethinghere"
	switch (args[0]) 
	{
		case ("all"):
			foreach (entity p in GetPlayerArray()) 
			{	
				if (p != null)
					RemoveWeapon(p)
			}
		break;
		
		case ("team_imc"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_IMC )) 
			{	
				if (p != null)
					RemoveWeapon(p)
			}
		break;
		
		case ("team_militia"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_MILITIA )) 
			{	
				if (p != null)
					RemoveWeapon(p)
			}
		break;
			
		default:
			int a = args[0].tointeger();
			try {
				player = players[a];
				if (player != null)
					RemoveWeapon(player)
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
					RemoveWeapon(player)
			} catch(ex) {
				print("Unknown ID/Player.");
			}
		}
	}
	#endif
	return true;
}

void function RemoveWeapon( entity player )
{
	#if SERVER
	array<entity> weapons = player.GetMainWeapons()
	foreach (entity weapon in weapons) 
	{
		if (weapon == null)
			break;
		string weaponId = weapon.GetWeaponClassName()
		print(weaponId)
		if (weapon != player.GetOffhandWeapon( OFFHAND_MELEE) ) {
		try
		{
			player.TakeWeaponNow(weaponId)
		} catch(exception)
		{
			print("Can't take " + player.GetPlayerName() + "'s " + weaponId + "!")
		}
		}
	}
	
	/*weapons = player.GetOffhandWeapons()
	foreach (entity weapon in weapons) 
	{
		if (weapon == null)
			break;
		string weaponId = weapon.GetWeaponClassName()
		try
		{
			player.TakeWeaponNow(weaponId)
		} catch(exception)
		{
			print("Can't take " + player.GetPlayerName() + "'s " + weaponId + "!")
		}
	}*/
#endif
}
