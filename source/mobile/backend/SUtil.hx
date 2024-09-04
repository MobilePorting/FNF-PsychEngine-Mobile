package mobile.backend;

#if android
import lime.app.Application;
import android.content.Context as AndroidContext;
import android.os.Environment as AndroidEnvironment;
import android.Permissions as AndroidPermissions;
import android.Settings as AndroidSettings;
#end
import haxe.Exception;
import haxe.io.Path;
import lime.system.System as LimeSystem;
import lime.utils.Log as LimeLogger;
#if sys
import sys.io.File;
import sys.FileSystem;
#end

/**
 * A storage class for mobile.
 * @author Mihai Alexandru (M.A. Jigsaw) and Lily (mcagabe19)
 */
class SUtil
{
	#if sys
	public static function getStorageDirectory(type:StorageType = #if EXTERNAL EXTERNAL #elseif OBB EXTERNAL_OBB #elseif MEDIA MEDIA #else EXTERNAL_DATA #end):String
	{
		var daPath:String = '';

		#if android
		#if !MODS_ALLOWED
		daPath =  AndroidContext.getExternalFilesDir(null);
		#else
		switch (type)
		{
			case EXTERNAL_DATA:
				daPath = AndroidContext.getExternalFilesDir(null);
			case EXTERNAL_OBB:
				daPath = AndroidContext.getObbDir();
			case EXTERNAL:
				daPath = AndroidEnvironment.getExternalStorageDirectory() + '/.' + Application.current.meta.get('file');
			case MEDIA:
				daPath = AndroidEnvironment.getExternalStorageDirectory() + '/Android/media/' + Application.current.meta.get('packageName');
		}
		#end
		#elseif ios
		daPath = LimeSystem.documentsDirectory;
		#end

		return daPath;
	}

	public static function mkDirs(directory:String):Void
	{
		var total:String = '';
		if (directory.substr(0, 1) == '/')
			total = '/';

		var parts:Array<String> = directory.split('/');
		if (parts.length > 0 && parts[0].indexOf(':') > -1)
			parts.shift();

		for (part in parts)
		{
			if (part != '.' && part != '')
			{
				if (total != '' && total != '/')
					total += '/';

				total += part;

				try {
				if (!FileSystem.exists(total))
					FileSystem.createDirectory(total);
				}
				catch (e:Exception)
					throw "Error while creating folder. (${e.message})" + "\nMaybe you needed restart the game" + "\nPress OK to close the game";
			}
		}
	}

	public static function saveContent(fileName:String = 'file', fileExtension:String = '.json',
			fileData:String = 'You forgot to add something in your code :3'):Void
	{
		try
		{
			if (!FileSystem.exists('saves'))
				FileSystem.createDirectory('saves');

			File.saveContent('saves/' + fileName + fileExtension, fileData);
			showPopUp(fileName + " file has been saved.", "Success!");
		}
		catch (e:Exception)
			LimeLogger.println("File couldn't be saved.\n(${e.message})");
	}
	#end

	#if android
	public static function doPermissionsShit():Void
	{
		if (!AndroidPermissions.getGrantedPermissions().contains('READ_EXTERNAL_STORAGE')
			&& !AndroidPermissions.getGrantedPermissions().contains('WRITE_EXTERNAL_STORAGE'))
		{
			AndroidPermissions.requestPermission('READ_EXTERNAL_STORAGE');
			AndroidPermissions.requestPermission('WRITE_EXTERNAL_STORAGE');
			showPopUp('If you accepted the permissions you are all good!' + '\nIf you didn\'t then expect a crash' + '\nPress Ok to see what happens',
				'Notice!');
			if (!AndroidEnvironment.isExternalStorageManager())
				AndroidSettings.requestSetting("AndroidSettings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
		} else {
                try {
                if (!FileSystem.exists(SUtil.getStorageDirectory()))
                    FileSystem.createDirectory(SUtil.getStorageDirectory());
                }
                catch(e:Dynamic) {
			    showPopUp("Please create folder to\n" + #if EXTERNAL "/storage/emulated/0/." + lime.app.Application.current.meta.get('file') #elseif MEDIA "/storage/emulated/0/Android/media/" + lime.app.Application.current.meta.get('packageName') #else SUtil.getStorageDirectory() #end + "\nPress OK to close the game", "Error!");
                LimeSystem.exit(1);
                }}
	}
	#end

	public static function showPopUp(message:String, title:String):Void
	{
		#if (windows || web || android)
		openfl.Lib.application.window.alert(message, title);
		#else
		LimeLogger.println('$title - $message');
		#end
	}
}

enum StorageType
{
	EXTERNAL;
	EXTERNAL_DATA;
	EXTERNAL_OBB;
	MEDIA;
}

