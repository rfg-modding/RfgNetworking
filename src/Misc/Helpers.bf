using System;
using System.Reflection;

//Toggles whether DebugLogAttribute does anything or not
#define ENABLE_DEBUG_LOG

namespace RfgNetworking.Misc
{
    //Adding this attribute to a method will log method entry and returned Result<T> errors
    [AttributeUsage(.Method)]
    struct LogAttribute : Attribute, IOnMethodInit
    {
        [Comptime]
        public void OnMethodInit(MethodInfo method, Self* prev)
        {
            String declaringTypeName = method.DeclaringType.GetName(.. scope .());
            String emit = scope $"Logger.WriteLine(scope $\"{declaringTypeName}.{method.Name}(";
            String args = scope .();
            for (var fieldIdx < method.ParamCount)
            {
                String paramTypeName = method.GetParamType(fieldIdx).GetFullName(.. scope .());
                StringView paramTypeNameShortened = paramTypeName.Substring(paramTypeName.LastIndexOf('.') + 1)..Trim();

                if (method.GetParamType(fieldIdx).IsPointer && method.GetParamType(fieldIdx) != typeof(char8*))
                {
                    emit.AppendF($"{paramTypeNameShortened} {method.GetParamName(fieldIdx)}: 0x{{(int)(void*){method.GetParamName(fieldIdx)}:X}}");
                }
                else if (method.GetParamType(fieldIdx) == typeof(char8*))
                {
                    emit += scope $"{paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {method.GetParamName(fieldIdx)}: \"\"{{scope String()..Append({method.GetParamName(fieldIdx)})}}\"\"";
                }
                else if (method.GetParamType(fieldIdx).BaseType == typeof(Enum))
                {
                    emit += scope $"{paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {method.GetParamName(fieldIdx)}: \"\"{{{method.GetParamName(fieldIdx)}.ToString(.. scope .())}}\"\"";
                }
                else
                {
                    emit.AppendF($"{paramTypeNameShortened} {method.GetParamName(fieldIdx)}: {{{method.GetParamName(fieldIdx)}}}");
                }
                if (fieldIdx < method.ParamCount - 1)
                    emit.Append(", ");
            }
            emit.Append(")");

            //return type
            Type returnType = method.ReturnType;
            if (returnType != typeof(void))
            {
                String returnTypeName = returnType.GetFullName(.. scope .());
                StringView returnTypeNameShortened = returnTypeName.Substring(returnTypeName.LastIndexOf('.') + 1)..Trim();
                if (returnType.IsPointer && returnType != typeof(char8*))
                {
                    emit += scope $" -> {returnTypeNameShortened}(0x{{(int)(void*)@return:X}})";
                }
                else if (returnType == typeof(char8*))
                {
                    args += scope $"char8* val = @return == null ? \"null\" : @return;\n";
                    emit += scope $" -> {returnTypeNameShortened}(\"{{scope String()..Append(val)}}\")";
                }
                else if (returnType.BaseType == typeof(Enum))
                {
                    emit += scope $" -> {returnTypeNameShortened}({{@return.ToString(.. scope .())}})";
                }
                else
                {
                    emit += scope $" -> {returnTypeNameShortened}({{@return}})";
                }
            }

            emit.Append("\");");
            Compiler.EmitMethodExit(method, args);
            Compiler.EmitMethodExit(method, emit);

            /*if (var genericType = method.ReturnType as SpecializedGenericType)
            {
                if ((genericType.UnspecializedType == typeof(Result<>)) || (genericType.UnspecializedType == typeof(Result<,>)))
                {
                    Compiler.EmitMethodExit(method, """
                        if (@return case .Err)
                        Logger.Log($"Error: {@return}");
                        """);
                }
            }*/
        }
    }

    //Same as LogAttribute but can be toggled with ENABLE_DEBUG_LOG attribute
    [AttributeUsage(.Method)]
    struct DebugLogAttribute : Attribute, IOnMethodInit
    {
        [Comptime]
        public void OnMethodInit(MethodInfo method, Self* prev)
        {
#if ENABLE_DEBUG_LOG
            String declaringTypeName = method.DeclaringType.GetName(.. scope .());
            String emit = scope $"Logger.WriteLine(scope $\"{declaringTypeName}.{method.Name}(";
            String args = scope .();
            for (var fieldIdx < method.ParamCount)
            {
                String paramTypeName = method.GetParamType(fieldIdx).GetFullName(.. scope .());
                StringView paramTypeNameShortened = paramTypeName.Substring(paramTypeName.LastIndexOf('.') + 1)..Trim();

                if (method.GetParamType(fieldIdx).IsPointer && method.GetParamType(fieldIdx) != typeof(char8*))
                {
                    emit.AppendF($"{paramTypeNameShortened} {method.GetParamName(fieldIdx)}: 0x{{(int)(void*){method.GetParamName(fieldIdx)}:X}}");
                }
                else if (method.GetParamType(fieldIdx) == typeof(char8*))
                {
                    emit += scope $"{paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {method.GetParamName(fieldIdx)}: \"\"{{scope String()..Append({method.GetParamName(fieldIdx)})}}\"\"";
                }
                else if (method.GetParamType(fieldIdx).BaseType == typeof(Enum))
                {
                    emit += scope $"{paramTypeNameShortened.Length > 0 ? paramTypeNameShortened : paramTypeName} {method.GetParamName(fieldIdx)}: \"\"{{{method.GetParamName(fieldIdx)}.ToString(.. scope .())}}\"\"";
                }
                else
                {
                    emit.AppendF($"{paramTypeNameShortened} {method.GetParamName(fieldIdx)}: {{{method.GetParamName(fieldIdx)}}}");
                }
                if (fieldIdx < method.ParamCount - 1)
                    emit.Append(", ");
            }
            emit.Append(")");

            //return type
            Type returnType = method.ReturnType;
            if (returnType != typeof(void))
            {
                String returnTypeName = returnType.GetFullName(.. scope .());
                StringView returnTypeNameShortened = returnTypeName.Substring(returnTypeName.LastIndexOf('.') + 1)..Trim();
                if (returnType.IsPointer && returnType != typeof(char8*))
                {
                    emit += scope $" -> {returnTypeNameShortened}(0x{{(int)(void*)@return:X}})";
                }
                else if (returnType == typeof(char8*))
                {
                    args += scope $"char8* val = @return == null ? \"null\" : @return;\n";
                    emit += scope $" -> {returnTypeNameShortened}(\"\"{{scope String()..Append(val)}}\"\")";
                }
                else if (returnType.BaseType == typeof(Enum))
                {
                    emit += scope $" -> {returnTypeNameShortened}({{@return.ToString(.. scope .())}})";
                }
                else
                {
                    emit += scope $" -> {returnTypeNameShortened}({{@return}})";
                }
            }

            emit.Append("\");");
            Compiler.EmitMethodExit(method, args);
            Compiler.EmitMethodExit(method, emit);

            /*if (var genericType = method.ReturnType as SpecializedGenericType)
            {
                if ((genericType.UnspecializedType == typeof(Result<>)) || (genericType.UnspecializedType == typeof(Result<,>)))
                {
                    Compiler.EmitMethodExit(method, """
                        if (@return case .Err)
                        Logger.Log($"Error: {@return}");
                        """);
                }
            }*/
#endif
        }
    }

    [AttributeUsage(.Class | .Struct | .Interface | .Enum, .AlwaysIncludeTarget | .ReflectAttribute, ReflectUser = .All, AlwaysIncludeUser = .IncludeAllMethods | .AssumeInstantiated)]
    public struct ReflectAllAttribute : Attribute
    {

    }
}