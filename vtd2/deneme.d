import std.stdio;
import vt;



void main()
{
	Database dbase=Database("db");
	Subtable subt;
	dbase.open();
	dbase.db.writeln();
	subt=dbase["tablo1"];
	subt["anahtar1"].add("hello");
	dbase.db.writeln();
	dbase.close(); //save() işlemini de içerir
	
}
