using System.IO;
using System;

namespace RfgNetworking.Misc
{
    public static class Logger
    {
        public static bool AutoFlush = true;

		private static Windows.FileHandle handle;

        public static void Init()
        {
			var name = "_RfgNetworkApiWrapper.log";
			
			handle = Windows.SafeCreateFile(name, Windows.GENERIC_WRITE, FileShare.ReadWrite, null, FileMode.OpenOrCreate, 128, Windows.Handle.NullHandle);
        }

        public static void Shutdown()
        {
			WriteLine("********************");
			WriteLine("Log closed");
			WriteLine("********************");
            
        }

		private static void DumbFormat(String s, RfgNetworking.Win32.SystemTime* t){
			var sMonth = scope String();
			t.Month.ToString(sMonth);
			if(sMonth.Length == 1){
				sMonth.Insert(0, "0");
			}
			var sDay= scope String();
			t.Day.ToString(sDay);
			if(sDay.Length == 1){
				sDay.Insert(0, "0");
			}
			var sHour= scope String();
			t.Hour.ToString(sHour);
			if(sHour.Length == 1){
				sHour.Insert(0, "0");
			}
			var sMinute= scope String();
			t.Minute.ToString(sMinute);
			if(sMinute.Length == 1){
				sMinute.Insert(0, "0");
			}
			var sSecond= scope String();
			t.Second.ToString(sSecond);
			if(sSecond.Length == 1){
				sSecond.Insert(0, "0");
			}

			s.AppendF("{}-{}-{}-{}:{}:{}", t.Year, sMonth, sDay, sHour, sMinute, sSecond);
			return;
		}

        public static void WriteLine(StringView fmt, params Object[] args)
        {
			//var d = scope String();
			//var c = new System.Globalization.CultureInfo("en-US");
			//System.Globalization.CultureInfo.mDefaultCultureInfo = c;
			//System.Globalization.CultureInfo.CurrentCulture = c;
			//System.Globalization.CultureInfo.[Friend]sUserDefaultCulture = c;

			
			var t  = new RfgNetworking.Win32.SystemTime();
			RfgNetworking.Win32.Win32.GetLocalTime(t);
			var str = scope String();
			var time = scope String();
			DumbFormat(time, t);
			str.AppendF("[{}][sw_api] ", time);
			str.AppendF(fmt, args);
			str.Append("\n");
			var strPtr = (char8*)str;
			var ptr = (uint8*)strPtr;

			int32 x = 0;
			Windows.SetFilePointer(handle, 0, null, Windows.FILE_END);
			Windows.WriteFile(handle, ptr, str.Length, out x, null);
        }

        public static void Flush()
        {
        }
    }
}