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
	
	InOut io = new InOut;
	Database dbase = io.dbopen("db.vt");
	Subtable sub = dbase.database["tablo1"];
	Data data = sub.subtables ["anahtar1"];
	writeln(dbase.database);
	writeln(sub.subtables);
	writeln(data.datas);
	
}
