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
	auto tabanim= new  Vt;
	tabanim.dbopen("abc.vt","123");
	writeln(tabanim.Veritabani);
	

}







