// An include that provides a function to help detect mobile client users.

// Include a_samp or open.mp
#include <a_samp>

// Perform a memory check on the client.
// native SendClientCheck(playerid, type, arg, offset, size);

// This callback is called when a SendClientCheck request completes.
// forward OnClientCheckResponse(playerid, type, arg, response);

// A boolean player variable (0 for false and 1 for true, as you know).
new bool:isAndroid[MAX_PLAYERS];

// IsPlayerAndroid/IsPlayerUsingAndroid returns a value i.e. true (using android) or false (not using android).
// IMPORTANT: If a function returns a tagged value like this one here, it must be declared (created) before it is used.
IsPlayerAndroid(playerid) return isAndroid[playerid];
IsPlayerUsingAndroid(playerid) return isAndroid[playerid];


public OnFilterScriptInit()
{
    print("======================");
    print("Android check loaded.");
    print("======================");

    return 1;
}

public OnFilterScriptExit()
{
    print("======================");
    print("Android check unloaded.");
    print("======================");
    
    return 1;
}

public OnPlayerConnect(playerid)
{
    // Set to false upon connect
    isAndroid[playerid] = false;

    SendClientCheck(playerid, 0x48, 0, 0, 2);

    return 1;
}

// NOTE: If you are using open.mp then the function parameters might be different
// See here: https://www.open.mp/docs/scripting/functions/SendClientCheck
public OnClientCheckResponse(playerid, type, arg, response)
{
    switch(type)
    {       
        case 0x48: // The player is not using a computer.
        {
            // Player is using Android. Set to true
            isAndroid[playerid] = true;
        }
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
    // Check if the player is using android client
    if(IsPlayerAndroid(playerid))
    {
        SendClientMessage(playerid, -1, "Mobile client is NOT allowed. Please use a PC to connect.");
        Kick(playerid);

        return 1;
    }

    return 1;
}