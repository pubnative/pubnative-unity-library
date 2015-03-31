using UnityEngine;
using UnityEditor;
using UnityEditor.Callbacks;
using System.IO;
using Pubnative.Utils;

public static class PostProcessImports
{
	[PostProcessBuild]
	public static void OnPostProcessBuild( BuildTarget target, string path )
	{
		if (target == BuildTarget.iOS) 
		{
			XCProject project = new XCProject( path );

			string projModPath = System.IO.Path.Combine(Application.dataPath, "Pubnative/Editor/iOS");
			string[] files = Directory.GetFiles( projModPath, "*.projmods", SearchOption.AllDirectories );
			foreach( string file in files )
			{
				project.ApplyMod(file);
			}

			project.Save();
		}
	}
}