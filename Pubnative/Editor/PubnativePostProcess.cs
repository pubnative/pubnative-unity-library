using UnityEngine;
using UnityEditor;
using UnityEditor.Callbacks;
using Pubnative.Utils;
using System.IO;

public static class PubnativePostProcess
{
	[PostProcessBuild]
	public static void OnPostProcessBuild( BuildTarget target, string path )
	{
		if (target == BuildTarget.iPhone) 
		{
			string projModPath = System.IO.Path.Combine(Application.dataPath, "Pubnative/Editor/iOS/");
			string[] files = Directory.GetFiles(projModPath, "*.projmods", SearchOption.AllDirectories);
			Pubnative.Utils.XCProject project = new Pubnative.Utils.XCProject(path);
			foreach(string file in files)
			{
				project.ApplyMod(file);
			}
			project.Save();
		}
	}
}