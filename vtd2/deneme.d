import std.stdio;
import std.conv;
import vt;



void main()
{
	Database dbase=Database("db");
	Subtable subt;
	dbase.open();
	dbase.db.writeln();
	subt=dbase["tablo1"];
	
    foreach (i; 0 .. 10) {
        subt["anahtar1"].add(to!string(i));
    }
    auto cont = subt["anahtar1"].search(&notequal!"5"); 
	cont.writeln();
	dbase.db.writeln();
	dbase.close(); //save() işlemini de içerir
	
}
