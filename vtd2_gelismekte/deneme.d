import std.path;
import std.datetime;
import std.process;
import std.stdio;
import std.conv;
import std.string;
import std.file;
import std.array;
import vt;



void main()
{
	Database dbase=Database("db.vt");
	Subtable subt;
	Data dd;
	dbase.open();
	dbase.db.writeln();
	subt=dbase["tablo1"];
	dd=subt["anahtar1"];
	dd.add("merhaba");
	subt["anahtar1"]=dd;
	dbase["tablo1"]=subt;
	dbase.db.writeln();
	dbase.dbwrite("aa.vt");
	
}
