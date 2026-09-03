using System;
using UndertaleModLib;

EnsureDataLoaded();

foreach (var font in Data.Fonts)
{
    ScriptMessage($"Font: {font.Name.Content}");
}
