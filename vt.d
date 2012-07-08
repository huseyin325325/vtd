module vt;  //Her zamanki gibi bir modul tanımladık ve başkalarının hazır kutuphanesinin 
//uzerine konduk hadi hayırlısı baslayalım
import std.path;
import std.datetime;
import std.process;
import std.stream; /* Dikkat Edelim std.stdio mevcut değil stream kullanıyorum*/
import std.conv;
import std.string;
import std.file;
import std.cstream;
import std.array;
import crypt; // sifreleme modulumuz :)



class Vt
{
	string db_pass;
	string db_name;
	string[] [string][string] Database; //İşte bu bizim tüm veritabanımız kucuk gibi 
	//gorunmesin gayet guclu oldugunu ileride göreceksiniz 
	

	
/+++++++++++++++++++++++++++++++++ ++++++++++++++++++++++++++++++++++++++/ //
	void dbwrite(string vtadi_,string sifre) // veritabanını yazmak için kulllanılan fonk
	{
		scope File dosya = new File(vtadi_,FileMode.OutNew);
		dosya.writeLine(encrypt("sifre",sifre));
		foreach(tabloadi,anahtares;Database)
		{
			dosya.writeLine(encrypt("|;"~tabloadi~"|;",sifre));
			foreach(anahtaradi,veriler;anahtares)
			{
				dosya.writeLine(encrypt("*;"~anahtaradi~"*;",sifre));
				foreach(veri;veriler)
				{
					dosya.writeLine(encrypt(veri,sifre));
				}
			}	
		}
	}
/***********************************************************************/
	void dbopen(string dosya_adi,string sifre)//veritabanını açıp Database adlı değişkene veriyi
	// okur
	{
		
		scope File dosya = new File(dosya_adi,FileMode.In);
		if(decrypt(to!(string)(dosya.readLine()),sifre)=="sifre")
		{
			db_name=dosya_adi;
			db_pass=sifre;
		
		string tablo_s;
		
		string anahtar_s;
		
		string[] veri_s;
		while(dosya.available)
		{
			string satir_s=decrypt(to!(string)(dosya.readLine()),sifre);
			char[] satir_c=to!(char[])(satir_s);
			
			
			
				if(satir_c[0..2]=="|;")
				{
					tablo_s=replace(satir_s,"|;","");
				}
				else if(satir_c[0..2]=="*;")
				{
					anahtar_s=replace(satir_s,"*;","");
				}
				else
				{
					Database[tablo_s][anahtar_s]~=satir_s;
					
				}	
			}
		}
		else
		{
			throw new Exception("Hata: Girdiğiniz Parola Yanlış");
		}
			
	   }
/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/ //
		
		void deltable(string ad_tablo)
		{
			Database.remove(ad_tablo);
		}
		
		void delkey(string ad_tablo,string ad_anahtar)
		{
			Database[ad_tablo].remove(ad_anahtar);
		}

/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/ //
	void add(string ad_tablo,string ilk_anah,string ilkver)
	{ //veri ekler
		Database[ad_tablo][ilk_anah]~=ilkver;
	}

/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/ //
	void dbsave()
	{ //veritabanını kaydeder
		dbwrite(db_name,db_pass);
	}
/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/
	void dbclose() //veritabanı ile işiniz bittiğinde kapatırsınız
	//ÖNEMLİ: kendisi kayıt yapma bunun için <veritabanı>.dbsave(); kullanmak zorundasınız.
	{
		db_name="";
		db_pass="";
		Database=Database.init;
		if(db_name != "" || db_pass !="")
		{
			throw new Exception("Hata: Veritabanı Kapatılamadı.");
		}
		
	}
/++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/
} //class sonu
