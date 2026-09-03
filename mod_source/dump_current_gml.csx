using System;
using System.IO;
using UndertaleModLib;
using UndertaleModLib.Models;
using UndertaleModLib.Decompiler;

EnsureDataLoaded();

var stepCode = Data.Code.ByName("gml_Object_oFutaMatingPress_Step_0");
var drawCode = Data.Code.ByName("gml_Object_oFutaMatingPress_Draw_0");
var createCode = Data.Code.ByName("gml_Object_oFutaMatingPress_Create_0");
var draw64Code = Data.Code.ByName("gml_Object_oFutaMatingPress_Draw_64");

GlobalDecompileContext context = new(Data);
Underanalyzer.Decompiler.IDecompileSettings settings = Data.ToolInfo.DecompilerSettings;

string outDir = @"C:\Users\nuuta\Desktop\gmr\_modding_workspace\tools\current_decompiled";
Directory.CreateDirectory(outDir);

File.WriteAllText(Path.Combine(outDir, "Step_0.gml"), new Underanalyzer.Decompiler.DecompileContext(context, stepCode, settings).DecompileToString());
File.WriteAllText(Path.Combine(outDir, "Draw_0.gml"), new Underanalyzer.Decompiler.DecompileContext(context, drawCode, settings).DecompileToString());
File.WriteAllText(Path.Combine(outDir, "Create_0.gml"), new Underanalyzer.Decompiler.DecompileContext(context, createCode, settings).DecompileToString());
File.WriteAllText(Path.Combine(outDir, "Draw_64.gml"), new Underanalyzer.Decompiler.DecompileContext(context, draw64Code, settings).DecompileToString());

ScriptMessage("Exported current decompiled code to: " + outDir);
