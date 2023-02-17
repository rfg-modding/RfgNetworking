# RfgNetworking
Replacement for the networking API used by Red Faction Guerrilla Re-Mars-Tered. The community made it for long term preservation purposes and to stop official server outages from interfering with mod testing and game nights. It consists of two parts:
- A DLL which replaces the copy of `sw_api.dll` that comes with the game. 
- A master server which interfaces with `sw_api.dll`. This tracks all active games and players looking to start/join matches.
