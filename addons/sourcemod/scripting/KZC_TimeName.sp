#pragma semicolon 1

#define PLUGIN_NAME "KZC_TimeName"
#define PLUGIN_AUTHOR "AzaZPPL"
#define PLUGIN_DESCRIPTION "Shows how long there is left in the server title for next mapchange"
#define PLUGIN_VERSION "1.0"
#define PLUGIN_URL "http://kz-climb.com"

#include <sourcemod>

public Plugin myinfo = 
{
	name = PLUGIN_NAME,
	author = PLUGIN_AUTHOR,
	description = PLUGIN_DESCRIPTION,
	version = PLUGIN_VERSION,
	url = PLUGIN_URL
};

Handle h_convHostname;
char c_oldHostname[250];
char c_newHostname[250];
int i_timeleft;

public void OnPluginStart()
{
	h_convHostname = FindConVar("hostname");
}

public void OnMapStart()
{
	GetConVarString(h_convHostname, c_oldHostname, 250);
	CreateTimer(5.0, setTimeInHostname, INVALID_HANDLE, TIMER_REPEAT);
}

public Action setTimeInHostname(Handle h_timer)
{
	GetMapTimeLeft(i_timeleft);
	
	if(i_timeleft <= -1) {
		return Plugin_Handled;
	}
	
	Format(c_newHostname, 250, "%s || %i:%i", c_oldHostname, i_timeleft / 60, i_timeleft % 60);
	
	SetConVarString(h_convHostname, c_newHostname);
	
	return Plugin_Continue;
}

public void OnMapEnd()
{
	SetConVarString(h_convHostname, c_oldHostname);
	h_convHostname.Close();
}

public void OnPluginEnd()
{
	SetConVarString(h_convHostname, c_oldHostname);
	h_convHostname.Close();
}