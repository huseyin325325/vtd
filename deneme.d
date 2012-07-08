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
	auto mydata= new  Vt;
	mydata.dbopen("file.vt","123");
	mydata.add("example","keyone","data");
	writeln(mydata.Database);
}







