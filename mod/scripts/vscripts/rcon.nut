global function RCONCommand

void function RCONCommand()
{
	#if SERVER
	AddClientCommandCallback("rcon", RCON);
	#endif
}

bool function RCON(entity player, array<string> args)
{
	#if SERVER
	
	#endif
	return true;
}