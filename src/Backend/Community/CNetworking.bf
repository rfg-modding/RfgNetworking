using RfgNetworking.API;

namespace RfgNetworking.Backend.Community
{
    public struct CNetworking : ISteamNetworking
    {
        public void ModuleInit() mut
        {
            Vtable = new ISteamNetworking.VTable();
            Vtable.SendP2PPacket = => SendP2PPacket;
            Vtable.IsP2PPacketAvailable = => IsP2PPacketAvailable;
            Vtable.ReadP2PPacket = => ReadP2PPacket;
            Vtable.AcceptP2PSessionWithUser = => AcceptP2PSessionWithUser;
            Vtable.CloseP2PSessionWithUser = => CloseP2PSessionWithUser;
            Vtable.CloseP2PChannelWithUser = => CloseP2PChannelWithUser;
            Vtable.GetP2PSessionState = => GetP2PSessionState;
            Vtable.AllowP2PPacketRelay = => AllowP2PPacketRelay;
            Vtable.CreateListenSocket = => CreateListenSocket;
            Vtable.CreateP2PConnectionSocket = => CreateP2PConnectionSocket;
            Vtable.CreateConnectionSocket = => CreateConnectionSocket;
            Vtable.DestroySocket = => DestroySocket;
            Vtable.DestroyListenSocket = => DestroyListenSocket;
            Vtable.SendDataOnSocket = => SendDataOnSocket;
            Vtable.IsDataAvailableOnSocket = => IsDataAvailableOnSocket;
            Vtable.RetrieveDataFromSocket = => RetrieveDataFromSocket;
            Vtable.IsDataAvailable = => IsDataAvailable;
            Vtable.RetrieveData = => RetrieveData;
            Vtable.GetSocketInfo = => GetSocketInfo;
            Vtable.GetListenSocketInfo = => GetListenSocketInfo;
            Vtable.GetSocketConnectionType = => GetSocketConnectionType;
            Vtable.GetMaxPacketSize = => GetMaxPacketSize;
        }

        public void ModuleShutdown()
        {
            delete Vtable;
        }

        public bool SendP2PPacket(CSteamID steamIDRemote, void* pubData, uint32 cubData, P2PSend eP2PSendType, int32 nChannel)
        {
            return false;
        }

        public bool IsP2PPacketAvailable(uint32* pcubMsgSize, int32 nChannel)
        {
            return false;
        }

        public bool ReadP2PPacket(void* pubDest, uint32 cubDest, uint32* pcubMsgSize, CSteamID* psteamIDRemote, int32 nChannel)
        {
            return false;
        }

        public bool AcceptP2PSessionWithUser(CSteamID steamIDRemote)
        {
            return false;
        }

        public bool CloseP2PSessionWithUser(CSteamID steamIDRemote)
        {
            return false;
        }

        public bool CloseP2PChannelWithUser(CSteamID steamIDRemote, int32 nChannel)
        {
            return false;
        }

        public bool GetP2PSessionState(CSteamID steamIDRemote, P2PSessionState* pConnectionState)
        {
            return false;
        }

        public bool AllowP2PPacketRelay(bool bAllow)
        {
            return false;
        }

        public SNetListenSocket CreateListenSocket(int nVirtualP2PPort, uint32 nIP, uint16 nPort, bool bAllowUseOfPacketRelay)
        {
            return 0;
        }

        public SNetSocket CreateP2PConnectionSocket(CSteamID steamIDTarget, int nVirtualPort, int nTimeoutSec, bool bAllowUseOfPacketRelay)
        {
            return 0;
        }

        public SNetSocket CreateConnectionSocket(uint32 nIP, uint16 nPort, int nTimeoutSec)
        {
            return 0;
        }

        public bool DestroySocket(SNetSocket hSocket, bool bNotifyRemoteEnd)
        {
            return false;
        }

        public bool DestroyListenSocket(SNetListenSocket hSocket, bool bNotifyRemoteEnd)
        {
            return false;
        }

        public bool SendDataOnSocket(SNetSocket hSocket, void* pubData, uint32 cubData, bool bReliable)
        {
            return false;
        }

        public bool IsDataAvailableOnSocket(SNetSocket hSocket, uint32* pcubMsgSize)
        {
            return false;
        }

        public bool RetrieveDataFromSocket(SNetSocket hSocket, void* pubDest, uint32 cubDest, uint32* pcubMsgSize)
        {
            return false;
        }

        public bool IsDataAvailable(SNetListenSocket hListenSocket, uint32* pcubMsgSize, SNetSocket* phSocket)
        {
            return false;
        }

        public bool RetrieveData(SNetListenSocket hListenSocket, void* pubDest, uint32 cubDest, uint32* pcubMsgSize, SNetSocket* phSocket)
        {
            return false;
        }

        public bool GetSocketInfo(SNetSocket hSocket, CSteamID* pSteamIDRemote, int* peSocketStatus, uint32* punIPRemote, uint16* punPortRemote)
        {
            return false;
        }

        public bool GetListenSocketInfo(SNetListenSocket hListenSocket, uint32* pnIP, uint16* pnPort)
        {
            return false;
        }

        public SNetSocketConnectionType GetSocketConnectionType(SNetSocket hSocket)
        {
            return .NotConnected;
        }

        public int GetMaxPacketSize(SNetSocket hSocket)
        {
            return 0;
        }
    }    
}