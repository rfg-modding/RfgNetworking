using System.Reflection;
using RfgNetworking.Misc;
using System;

namespace RfgNetworking.API
{
    [DebugWrapper<ISteamClient.VTable>, CRepr]
    public struct SteamClientDebugWrapper : ISteamClient
    {

    }

    [DebugWrapper<ISteamUser.VTable>, CRepr]
    public struct SteamUserDebugWrapper : ISteamUser
    {

    }

    [DebugWrapper<ISteamFriends.VTable>, CRepr]
    public struct SteamFriendsDebugWrapper : ISteamFriends
    {

    }

    [DebugWrapper<ISteamUtils.VTable>, CRepr]
    public struct SteamUtilsDebugWrapper : ISteamUtils
    {

    }

    [DebugWrapper<ISteamMatchmaking.VTable>, CRepr]
    public struct SteamMatchmakingDebugWrapper : ISteamMatchmaking
    {

    }

    [DebugWrapper<ISteamUserStats.VTable>, CRepr]
    public struct SteamUserStatsDebugWrapper : ISteamUserStats
    {

    }

    [DebugWrapper<ISteamApps.VTable>, CRepr]
    public struct SteamAppsDebugWrapper : ISteamApps
    {

    }

    [DebugWrapper<ISteamNetworking.VTable>, CRepr]
    public struct SteamNetworkingDebugWrapper : ISteamNetworking
    {

    }

    [DebugWrapper<ISteamRemoteStorage.VTable>, CRepr]
    public struct SteamRemoteStorageDebugWrapper : ISteamRemoteStorage
    {

    }

    [DebugWrapper<ISteamController.VTable>, CRepr]
    public struct SteamControllerDebugWrapper : ISteamController
    {

    }

    //Generates wrapper functions for a steam interface. These log every time the interface is used and any data passed to or from it.
    [AttributeUsage(.Struct)]
    public struct DebugWrapperAttribute<TInterface> : Attribute, IOnTypeInit
    {
        [Comptime]
        void IOnTypeInit.OnTypeInit(Type type, Self* prev)
        {
            String initFunc = scope .(); //Initializes vtable
            String wrappers = scope .(); //Wrapper functions that log interface inputs + outputs
            String logStateFunc = scope .(); //Print state such as call count and functions which always return the same value

            Compiler.EmitTypeBody(type, "private void* _originalInterface = null;\n");
            Compiler.EmitTypeBody(type, scope $"private {typeof(TInterface).GetFullName(.. scope .())}* _originalVtable = null;\n\n");

            //Get steam interface name. Assuming structs using this attribute inherit the steam interface
            Type steamInterfaceType = type.BaseType;
            String steamInterfaceTypeName = steamInterfaceType != null ? steamInterfaceType.GetFullName(.. scope .()) : "";
            StringView steamInterfaceNameShortened = steamInterfaceTypeName.Substring(steamInterfaceTypeName.LastIndexOf('.') + 1)..Trim();
            StringView vtableTypeName = typeof(TInterface).GetFullName(.. scope .());

            logStateFunc += "public void LogState()\n";
            logStateFunc += "{\n";
            logStateFunc += scope $"    Logger.WriteLine(\"\\n{steamInterfaceNameShortened} State:\");\n";
            logStateFunc += scope $"    Logger.WriteLine(\"    Call counts:\");\n";

            initFunc += scope $"public void Init({steamInterfaceNameShortened}* originalInterface, {vtableTypeName}* originalVtable) mut\n";
            initFunc += "{\n";
            initFunc += "    _originalInterface = originalInterface;\n";
            initFunc += "    _originalVtable = originalVtable;\n";
            initFunc += scope $"    Vtable = new {vtableTypeName}();\n";
            for (var vtfunc in typeof(TInterface).GetFields())
            {
                if (vtfunc.FieldType.BaseType != typeof(Function))
                    continue;

                if (vtfunc.FieldType.GetMethod("Invoke") case .Ok(MethodInfo vtfuncSignature))
                {
                    initFunc += scope $"    Vtable.{vtfunc.Name} = => {vtfunc.Name}_Log;\n";

                    //Emit log wrapper + related state
                    bool hasReturnValue = vtfuncSignature.ReturnType != typeof(void);
                    String returnTypeName = vtfuncSignature.ReturnType.GetFullName(.. scope .());
                    String args = GetMethodArgsString(vtfuncSignature, .. scope .());
                    String callCounterName = scope $"_{vtfunc.Name}_CallCounter";
                    wrappers += "\n";
                    wrappers += scope $"public static u64 {callCounterName} = 0;\n";
                    wrappers += scope $"public {returnTypeName} {vtfunc.Name}_Log{args}\n";
                    wrappers += "{\n";

                    //LogState() code
                    {
                        logStateFunc += scope $"    Logger.WriteLine(scope $\"        {vtfunc.Name}: {{{callCounterName}}}\");\n";
                    }

                    //Call original function
                    wrappers += "    ";
                    if (hasReturnValue)
                    {
                        wrappers += scope $"{returnTypeName} result = ";
                    }
                    wrappers += scope $"_originalVtable.{vtfunc.Name}(";
                    for (int i = 0; i < vtfuncSignature.ParamCount; i++)
                    {
                        StringView paramName = vtfuncSignature.GetParamName(i);
                        if (i == 0)
                            wrappers += scope $"({vtfuncSignature.GetParamType(i).GetFullName(.. scope .())})_originalInterface";
                        else
                            wrappers +=  scope $"{paramName}";

                        if (i != vtfuncSignature.ParamCount - 1)
                            wrappers += ", ";
                    }
                    wrappers += ");\n";

                    //Log arguments & return value
                    wrappers += scope $"    Logger.WriteLine(scope $""{steamInterfaceNameShortened}::{vtfunc.Name}(";
                    for (int i = 0; i < vtfuncSignature.ParamCount; i++)
                    {
                        StringView paramName = vtfuncSignature.GetParamName(i);
                        Type paramType = vtfuncSignature.GetParamType(i);
                        String paramTypeName = paramType.GetFullName(.. scope .());
                        StringView paramTypeNameShortened = paramTypeName.Substring(paramTypeName.LastIndexOf('.') + 1)..Trim();
                        if (paramType.IsPointer && paramType != typeof(char8*))
                        {
                            if (paramName == "this")
                            {
                                wrappers += scope $"{paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {paramName}: 0x{{(int)(void*)_originalInterface}}";
                            }
                            else
                            {
                                wrappers += scope $"{paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {paramName}: 0x{{(int)(void*){paramName:X}}}";
                            }
                        }
                        else if (paramType == typeof(char8*))
                        {
                            wrappers += scope $"{paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {paramName}: \"\"{{scope String()..Append({paramName})}}\"\"";
                        }
                        else if (paramType.BaseType == typeof(Enum))
                        {
                            wrappers += scope $"enum {paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {paramName}: .{{{paramName}.ToString(.. scope .())}}";
                        }
                        else
                        {
                            wrappers += scope $"{paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {paramName}: {{{paramName}}}";
                        }
                        if (i != vtfuncSignature.ParamCount - 1)
                            wrappers += ", ";
                    }
                    wrappers += ")";
                    if (hasReturnValue)
                    {
                        StringView returnTypeNameShortened = returnTypeName.Substring(returnTypeName.LastIndexOf('.') + 1)..Trim();
                        if (vtfuncSignature.ReturnType.IsPointer && vtfuncSignature.ReturnType != typeof(char8*))
                    	{
                            wrappers += scope $" -> {returnTypeNameShortened}(0x{{(int)(void*)result:X}})";
                    	}
                        else if (vtfuncSignature.ReturnType == typeof(char8*))
                        {
                            wrappers += scope $" -> {returnTypeNameShortened}(\"\"{{scope String()..Append(result)}}\"\")";
                        }
                        else if (vtfuncSignature.ReturnType.BaseType == typeof(Enum))
                        {
                            wrappers += scope $" -> enum {returnTypeNameShortened}(.{{result.ToString(.. scope .())}})";
                        }
                        else
                        {
                            wrappers += scope $" -> {returnTypeNameShortened}({{result}})";
                        }
                    }
                    wrappers += "\");\n";

                    //Increment call counter
                    wrappers += scope $"    {callCounterName}++;\n";

                    //Return original functions result
                    if (hasReturnValue)
                        wrappers += "    return result;\n";

                    wrappers += "}\n"; //End up XXXX_Log()
                }
                else
                {
                    Runtime.FatalError("Failed to reflect .Invoke() from vtable function pointer. Needed for wrapper generation.");
                }
            }
            initFunc += "}\n\n";
            logStateFunc += "}\n";

            Compiler.EmitTypeBody(type, initFunc);
            Compiler.EmitTypeBody(type, logStateFunc);
            Compiler.EmitTypeBody(type, wrappers);
        }

        //Get function args. e.g. function void(i32 a, u32 b) -> "(i32 a, u32 b)"
        private static void GetMethodArgsString(MethodInfo method, String signature)
        {
            signature += "(";
            for (int i = 0; i < method.ParamCount; i++)
            {
                StringView paramName = method.GetParamName(i);
                if (paramName == "this")
                    continue;

                Type paramType = method.GetParamType(i);
                String paramTypeName = paramType.GetFullName(.. scope .());
                if (paramType.BaseType == typeof(Function))
                {
                    if (paramType.GetMethod("Invoke") case .Ok(MethodInfo invoke))
                    {
                        String returnTypeName = invoke.ReturnType.GetFullName(.. scope .());
                        String callingConvention = scope .();
                        signature += scope $"function {callingConvention} {returnTypeName}{GetMethodArgsString(invoke, .. scope .())} {paramName}";
                    }
                    else
                    {
                        Runtime.FatalError("Failed to get Invoke() for method function pointer argument");
                    }
                }
                else
                {
                    signature += scope $"{paramTypeName} {method.GetParamName(i)}";
                }
                if (i != method.ParamCount - 1)
                    signature += ", ";
            }
            signature += ")";
        }
    }
}