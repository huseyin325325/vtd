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
	Database db = new Database;
	db["tabl1"]= new Subtable;
	Subtable sub= db["tabl1"];
	Data datam =new Data;
	dmy.datam~="12";
	sub["key1"]= datam;
	writeln(db.db);
	writeln(sub.subtables);
	writeln(datam.datas);
	
}
