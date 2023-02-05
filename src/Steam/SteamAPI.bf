using System;

namespace RfgNetworkAPI.Steam
{
    typealias HSteamPipe = i32;
    typealias HSteamUser = i32;

    [CRepr]
    public struct CSteamAPIContext
    {
        public ISteamClient* Client;
        public ISteamUser* User;
        public ISteamFriends* Friends;
        public ISteamUtils* Utils;
        public ISteamMatchmaking* Matchmaking;
        public ISteamUserStats* UserStats;
        public ISteamApps* Apps;
        public ISteamMatchmakingServers* MatchmakingServers;
        public ISteamNetworking* Networking;
        public ISteamRemoteStorage* RemoteStorage;
        public ISteamScreenshots* Screenshots;
        public ISteamHTTP* HTTP;
        public ISteamController* Controller;
        public ISteamUGC* UGC;
        public ISteamAppList* AppList;
        public ISteamMusic* Music;
        public ISteamMusicRemote* MusicRemote;
        public ISteamHTMLSurface* HTMLSurface;
        public ISteamInventory* Inventory;
        public ISteamVideo* Video;
        public ISteamParentalSettings* ParentalSettings;
    }

    //Meant to imitate the real ISteamClient interface that the real sw_api.dll provides. The GOG version of sw_api.dll seems to something similar.
    [CRepr]
    public struct ISteamClient
    {
        public ISteamClient.VTable* Vtable;

        public static HSteamPipe CreateSteamPipe(ISteamClient* self)
        {
            return 0;
        }

        public static bool BReleaseSteamPipe(ISteamClient* self, HSteamPipe hSteamPipe)
        {
            return false;
        }

        //TODO: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //TODO: See if we can get away with using cdecl. These really are _thiscall.
			//      In RSL hooking I've gotten around this by using fastcall where the arguments go (T* this, void* extra, ...), where ... are the other variables and extra does nothing
            //      Can probably test these easier in a Beef exe project by making a function ptr to a __thiscall function and seeing how the arguments look in the debugger
            public function [CallingConvention(.Fastcall)] HSteamPipe(ISteamClient* self) CreateSteamPipe = => ISteamClient.CreateSteamPipe;
            public function [CallingConvention(.Fastcall)] bool(ISteamClient* self, HSteamPipe hSteamPipe) BReleaseSteamPipe = => ISteamClient.BReleaseSteamPipe;

            //TODO: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamUser
    {
        public ISteamUser.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamFriends
    {
        public ISteamFriends.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamUtils
    {
        public ISteamUtils.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamMatchmaking
    {
        public ISteamMatchmaking.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamUserStats
    {
        public ISteamUserStats.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamApps
    {
        public ISteamApps.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamMatchmakingServers
    {
        public ISteamMatchmakingServers.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamNetworking
    {
        public ISteamNetworking.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamRemoteStorage
    {
        public ISteamRemoteStorage.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamScreenshots
    {
        public ISteamScreenshots.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamHTTP
    {
        public ISteamHTTP.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamController
    {
        public ISteamController.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamUGC
    {
        public ISteamUGC.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamAppList
    {
        public ISteamAppList.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamMusic
    {
        public ISteamMusic.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamMusicRemote
    {
        public ISteamMusicRemote.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamHTMLSurface
    {
        public ISteamHTMLSurface.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamInventory
    {
        public ISteamInventory.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamVideo
    {
        public ISteamVideo.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamParentalSettings
    {
        public ISteamParentalSettings.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }


    [CRepr]
    struct CCallbackBase
    {
    	void* vfptr;
    	char8 m_nCallbackFlags;
    	int m_iCallback;
    }

    [CRepr]
    struct CCallResult<T, U> : CCallbackBase
    {

    }
}