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

import haxe.io.Bytes;
import openfl.Assets;
import openfl.utils.ByteArray;
#if sys
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;
#end

using StringTools;

/**
 * Unified file handler that works with both native and OpenFL assets.
 * @see https://github.com/Psych-Slice/P-Slice/blob/master/source/mikolka/funkin/custom/NativeFileSystem.hx
 */
class PsychFile
{
	static final cwd:String = #if android StorageUtil.getExternalStorageDirectory() #else Sys.getCwd() #end;

	inline static function check(path:String):String
	{
		if (path.startsWith(cwd))
			return path;
		return haxe.io.Path.join([cwd, path]);
	}

	public static function getContent(path:String):String
	{
		#if sys
		final fullPath:String = check(path);
		if (FileSystem.exists(fullPath))
			return File.getContent(fullPath);
		#end

		if (Assets.exists(path, TEXT))
			return Assets.getText(path);

		return '';
	}

	public static function getBytes(path:String):Bytes
	{
		#if sys
		final fullPath:String = check(path);
		if (FileSystem.exists(fullPath))
			return File.getBytes(fullPath);
		#end

		if (Assets.exists(path, FONT))
			return ByteArray.fromFile(path);
		else if (Assets.exists(path))
			return Assets.getBytes(path);

		return Bytes.ofString('');
	}

	public static function saveContent(path:String, content:String):Void
	{
		#if sys
		File.saveContent(check(path), content);
		#end
	}

	public static function saveBytes(path:String, bytes:Bytes):Void
	{
		#if sys
		File.saveBytes(check(path), bytes);
		#end
	}

	public static function read(path:String, binary:Bool = true):Null<FileInput>
	{
		#if sys
		return File.read(check(path), binary);
		#else
		return null;
		#end
	}

	public static function write(path:String, binary:Bool = true):Null<FileOutput>
	{
		#if sys
		return File.write(check(path), binary);
		#else
		return null;
		#end
	}

	public static function append(path:String, binary:Bool = true):Null<FileOutput>
	{
		#if sys
		return File.append(check(path), binary);
		#else
		return null;
		#end
	}

	public static function update(path:String, binary:Bool = true):Null<FileOutput>
	{
		#if sys
		return File.update(check(path), binary);
		#else
		return null;
		#end
	}

	public static function copy(srcPath:String, dstPath:String):Void
	{
		#if sys
		File.copy(check(srcPath), check(dstPath));
		#end
	}
}
