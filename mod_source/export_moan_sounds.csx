using System;
using System.IO;
using UndertaleModLib;
using UndertaleModLib.Models;

EnsureDataLoaded();

ScriptMessage("=== EXPORTING MOAN SOUNDS FROM DATA.WIN ===");

string baseDir = @"C:\Users\nuuta\Desktop\gmr\wifes_bedroom_play\custom\_TEMPLATE_LOVER";
string pBaseDir = @"C:\Users\nuuta\Desktop\gmr\wifes_bedroom_play\custom\_TEMPLATE_PARTNER";

string slowDir = Path.Combine(baseDir, "moan_slow");
string fastDir = Path.Combine(baseDir, "moan_fast");
string orgasmDir = Path.Combine(baseDir, "orgasm");

string pSlowDir = Path.Combine(pBaseDir, "moan_slow");
string pFastDir = Path.Combine(pBaseDir, "moan_fast");
string pOrgasmDir = Path.Combine(pBaseDir, "orgasm");

Directory.CreateDirectory(slowDir);
Directory.CreateDirectory(fastDir);
Directory.CreateDirectory(orgasmDir);
Directory.CreateDirectory(pSlowDir);
Directory.CreateDirectory(pFastDir);
Directory.CreateDirectory(pOrgasmDir);

foreach (var sound in Data.Sounds)
{
    if (sound == null || sound.Name == null) continue;
    string name = sound.Name.Content;
    
    if (name.StartsWith("sndMoan", StringComparison.OrdinalIgnoreCase))
    {
        if (sound.AudioFile == null || sound.AudioFile.Data == null)
        {
            ScriptMessage($"Skipping {name} (no embedded audio file)");
            continue;
        }

        string targetDir = slowDir;
        string pTargetDir = pSlowDir;
        
        if (name.Contains("Fast", StringComparison.OrdinalIgnoreCase))
        {
            targetDir = fastDir;
            pTargetDir = pFastDir;
        }
        else if (name.Contains("Orgasm", StringComparison.OrdinalIgnoreCase))
        {
            targetDir = orgasmDir;
            pTargetDir = pOrgasmDir;
        }
        
        byte[] data = sound.AudioFile.Data;
        string ext = (data.Length > 4 && data[0] == 'O' && data[1] == 'g' && data[2] == 'g') ? ".ogg" : ".wav";
        string outPath = Path.Combine(targetDir, name + ext);
        string pOutPath = Path.Combine(pTargetDir, name + ext);
        
        File.WriteAllBytes(outPath, data);
        File.WriteAllBytes(pOutPath, data);
        ScriptMessage($"Exported sound: {name} -> {ext}");
    }
}

ScriptMessage("=== SOUND EXPORT COMPLETED! ===");
