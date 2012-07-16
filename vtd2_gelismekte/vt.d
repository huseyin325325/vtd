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


struct Data
{
	

	
	string[] datas;
	
	void del(string name)
	{
		string[] dizi2;
		int sayac = datas.length;
		for (int i=0;i<sayac;++i)
		{
			if(datas[i] != name)
			{
				dizi2~=datas[i];
			}
		}
		datas=dizi2;
	}
	void add(string dat)
	{
		datas~=dat;
	}
}//end of class

struct Subtable
{
	
	 
	Data [string] subtables;
	Data opIndex(string key)
	{
		return subtables[key];
	}
	Data opIndexAssign(Data dat,string name)
	{
		return subtables[name]=dat;
	}
	void del(string key)
	{
		subtables.remove(key);
	}
	
	void add(string key,Data firstdata)
	{
		subtables[key]=firstdata;
	}
}//end of class

struct Database
{
	
	Subtable [string] db;
	string dbname;
	
	this(string db)
	{
		this.dbname=db~".vt";
	}
	
	
	Subtable opIndex(string table)
	{
		return db[table];
	}
	
	Subtable opIndexAssign(Subtable table,string name)
	{
		return db[name]=table;
	}
	void del(string table)
	{
		db.remove(table);
	}
	void add(string table,Subtable firstkey)
	{
		db[table]=firstkey;
	}
	void open()
	{
		Data data;
		Subtable subtable;
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
				subtable=subtable.init;
			}
			else if(line_c[0..2]=="*;")
			{
				currentkey=replace(line_s,"*;","");
				currentdatas=currentdatas.init;
				data=data.init;
			}
			else
			{
				currentdatas~=line_s;
				data.datas=currentdatas;
				subtable.subtables[currentkey]=data;
				this.db[currenttable]=subtable;
				//temizlik
			
			
			}
		}
		
		
	}
	
	void close()
	{
		scope File myfile = new File(dbname,FileMode.OutNew);
		foreach(table,subtab;db)
		{
			myfile.writeLine("|;"~table~"|;");
			foreach(key,val;subtab.subtables)
			{
				myfile.writeLine("*;"~key~"*;");
				foreach(dat;val.datas)
				{
					myfile.writeLine(dat);
					
				}
			}
		}
		
	}
	
	
}//end of class


