/*
 * Copyright (C) 2025 Mobile Porting Team
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package backend.io;

import openfl.Assets;
import mobile.backend.StorageUtil;
#if sys
import sys.FileSystem;
import sys.FileStat;
#end

using StringTools;

/**
 * Unified file system class that works with both native file access and OpenFL assets.
 * @see https://github.com/Psych-Slice/P-Slice/blob/master/source/mikolka/funkin/custom/NativeFileSystem.hx
 */
class PsychFileSystem
{
	static final cwd:String = #if android StorageUtil.getExternalStorageDirectory() #else Sys.getCwd() #end;

	inline static function check(path:String):String
	{
		if (path.startsWith(cwd))
			return path;
		return haxe.io.Path.join([cwd, path]);
	}

	public static function exists(path:String):Bool
	{
		#if sys
		if (FileSystem.exists(check(path)))
			return true;
		#end
		return Assets.exists(path);
	}

	public static function rename(path:String, newPath:String):Void
	{
		#if sys
		FileSystem.rename(check(path), check(newPath));
		#end
	}

	public static function stat(path:String):Null<FileStat>
	{
		#if sys
		return FileSystem.stat(check(path));
		#else
		return null;
		#end
	}

	public static function fullPath(path:String):String
	{
		#if sys
		return FileSystem.fullPath(path);
		#else
		return path;
		#end
	}

	public static function absolutePath(path:String):String
	{
		#if sys
		return FileSystem.absolutePath(path);
		#else
		return path;
		#end
	}

	public static function isDirectory(path:String):Bool
	{
		#if sys
		if (FileSystem.isDirectory(check(path)))
			return true;
		#end
		return Assets.list().filter(folder -> folder.startsWith(path) && folder != path).length > 0;
	}

	public static function createDirectory(path:String):Void
	{
		#if sys
		FileSystem.createDirectory(check(path));
		#end
	}

	public static function deleteFile(path:String):Void
	{
		#if sys
		FileSystem.deleteFile(check(path));
		#end
	}

	public static function deleteDirectory(path:String):Void
	{
		#if sys
		FileSystem.deleteDirectory(check(path));
		#end
	}

	public static function readDirectory(path:String):Array<String>
	{
		#if sys
		if (FileSystem.exists(check(path)) && FileSystem.isDirectory(check(path)))
			return FileSystem.readDirectory(check(path));
		#end

		final dirs:Array<String> = [];
		for (item in Assets.list().filter(f -> f.startsWith(path)))
		{
			@:privateAccess
			for (library in lime.utils.Assets.libraries.keys())
			{
				final libPath:String = '$library:$item';
				if (library != 'default' && Assets.exists(libPath) && !dirs.contains(libPath))
					dirs.push(libPath);
				else if (Assets.exists(item) && !dirs.contains(item))
					dirs.push(item);
			}
		}
		return dirs.map(f -> f.substr(f.lastIndexOf("/") + 1));
	}
}
