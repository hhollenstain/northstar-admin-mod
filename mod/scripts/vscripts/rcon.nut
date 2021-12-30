global function RCONCommand

void function RCONCommand()
{
	#if SERVER
	AddClientCommandCallback("rcon", RCON);
	AddClientCommandCallback("uids", UIDS);
	AddClientCommandCallback("kick2", KICK);
	#endif
}

bool function UIDS(entity player, array<string> args){
	print("UIDS")
	array<entity> players = GetPlayerArray()
	foreach ( player in players){
		print(player.GetPlayerName())
		print(player.GetUID())
	}
	//foreach(player2 in GetPlayerArray().GetUID){
	//	print(player2.GetUID)
	//}
	return true;
}

bool function KICK(entity player, array<string> args){
	print("kick")
	hadGift_Admin = false;
	CheckAdmin(player);
	if (hadGift_Admin == false){
		print("Admin permission not detected.");
		return true;
	}

	if (args.len() == 0){
		print("Give a valid argument.");
		print("Example: kick <nickname>");
		return true;
	}
	
	if (args.len() > 2){
		print("Too many arguments for kick.");
		print("Example: kick <nickname>");
		return true;
	}

	string playername = ""
	foreach (string argument in args){
		playername = argument.tostring()
	}
	
	array<entity> players = GetPlayerArray()
	foreach ( player in players){
		if( (player.GetPlayerName()) == playername ){
			print("kicking"+playername)
			print("UID:"+player.GetUID())
			ServerCommand("kickid "+ player.GetUID());
			return true;
		}
	}
	return true;
}

bool function RCON(entity player, array<string> args)
{
	#if SERVER
	
	hadGift_Admin = false;
	CheckRCONAdmin(player)
	if (hadGift_Admin == false)
	{
		print("Admin permission not detected.");
		return true;
	}
	
	if (args.len() == 0)
	{
		print("Give a valid argument.");
		print("Example: rcon <arguments>");
		return true;
	}
	string newString = "";
	
	foreach (string arguments in args)
	{
		newString += (arguments.tostring() + " ");
	}
	
	print("rcon " + newString);
	
	ServerCommand(newString);
	#endif
	return true;
}