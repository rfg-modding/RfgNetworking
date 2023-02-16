using System.IO;
using System;

namespace RfgNetworking.Misc
{
    public static class Logger
    {
        public static bool AutoFlush = true;

        private static FileStream _fileStream;
        private static StreamWriter _streamWriter = null;

        public static void Init()
        {
            _fileStream = new .();
            _fileStream.Open("_RfgNetworkApiWrapper.log", FileMode.Create, .Write, .Read);
            _streamWriter = new .(_fileStream, .UTF8, 4096, false);
        }

        public static void Shutdown()
        {
            _streamWriter.WriteLine("\n********************");
            _streamWriter.WriteLine("Log closed!");
            _streamWriter.WriteLine("********************");
            delete _streamWriter;
            delete _fileStream;
        }

        public static void WriteLine(StringView fmt, params Object[] args)
        {
            _streamWriter.WriteLine(fmt, args);
            if (AutoFlush)
                _streamWriter.Flush();
        }

        public static void Write(StringView fmt, params Object[] args)
        {
            _streamWriter.Write(fmt, args);
        }

        public static void Flush()
        {
            _streamWriter.Flush();
        }
    }
}