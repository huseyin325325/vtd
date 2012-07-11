module vt;
import std.path;
import std.datetime;
import std.process;
import std.stream; 
import std.conv;
import std.string;
import std.file;
import std.cstream;
import std.array;
import crypt; 

class Database
{
	Subtable [string] database;
	
}//end of class

class Subtable
{
	Data [string] subtables;
}//end of class

class Data
{
	string[] datas;
}//end of class

class InOut
{
	Database dbopen(string dbname)
	{
		
		Database db = new Database;
		Data data = new Data;
		Subtable subtable = new Subtable;
		scope File myfile = new File(dbname,FileMode.In);
		
		string currenttable;
		string currentkey;
		string[] currentdatas;
		while(myfile.available)
		{
			char[] line_c = myfile.readLine();
			string line_s = to!(string)(line_c);
			if(line_c[0..2]=="|;")
			{
				currenttable=replace(line_s,"|;","");
			}
			else if(line_c[0..2]=="*;")
			{
				currentkey=replace(line_s,"*;","");
			}
			else
			{
				data.datas~=line_s;
				subtable.subtables[currentkey]=data;
				db.database[currenttable]=subtable;
			}
		}
		
		return db;
	}
	
	
	
}//end of class


