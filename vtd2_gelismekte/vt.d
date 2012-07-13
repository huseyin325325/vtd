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


class Data
{
	string[] datas;
}//end of class

class Subtable
{
	Data [string] subtables;
	Data opIndexAssign(Data dat,string name)
	{
		return subtables[name]=dat;
	}
}//end of class

class Database
{
	Subtable [string] db;
	string dbname;
	
	Subtable opIndex(string table)
	{
		return db[table];
	}
	
	Subtable opIndexAssign(Subtable table,string name)
	{
		return db[name]=table;
	}
	
	
	
	
	
	
	
	void open()
	{
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
				this.db[currenttable]=subtable;
			}
		}
		
		
}//end of class





	

	
}//end of class


