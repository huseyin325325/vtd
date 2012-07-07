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
	
	string vt_adi;
	string[] [string][string] Veritabani; //İşte bu bizim tüm veritabanımız kucuk gibi 
	//gorunmesin gayet guclu oldugunu ileride göreceksiniz 
	

	
/+++++++++++++++++++++++++++++++++ ++++++++++++++++++++++++++++++++++++++/ //
	void dbwrite(string vtadi_,string sifre)
	{
		scope File dosya = new File(vtadi_,FileMode.OutNew);
		dosya.writeLine(encrypt("sifre",sifre));
		foreach(tabloadi,anahtares;Veritabani)
		{
			dosya.writeLine(encrypt("|"~tabloadi~"|",sifre));
			foreach(anahtaradi,veriler;anahtares)
			{
				dosya.writeLine(encrypt("*"~anahtaradi~"*",sifre));
				foreach(veri;veriler)
				{
					dosya.writeLine(encrypt(veri,sifre));
				}
			}	
		}
	}
/***********************************************************************/
	void dbopen(string dosya_adi,string sifre)
	{
		vt_adi=dosya_adi;
		scope File dosya = new File(dosya_adi,FileMode.In);
		if(decrypt(to!(string)(dosya.readLine()),sifre)=="sifre")
		{
		
		string tablo_s;
		
		string anahtar_s;
		
		string[] veri_s;
		while(dosya.available)
		{
			string satir_s=decrypt(to!(string)(dosya.readLine()),sifre);
			char[] satir_c=to!(char[])(satir_s);
			
			
			
				if(satir_c[0..1]=="|")
				{
					tablo_s=replace(satir_s,"|","");
				}
				else if(satir_c[0..1]=="*")
				{
					anahtar_s=replace(satir_s,"*","");
				}
				else
				{
					Veritabani[tablo_s][anahtar_s]~=satir_s;
					
				}	
			}
		}
		else
		{
			throw new Exception("Hata: Girdiğiniz Parola Yanlış");
		}
			
	   }
/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/ //
	void tdelete(string ad_tablo)
	{
		Veritabani.remove(ad_tablo);
	}

/***********************************************************************/	
	void kdelete(string ad_tablo,string ad_anahtar)
	{
		Veritabani[ad_tablo].remove(ad_anahtar);
	}
/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/ //
	void add(string ad_tablo,string ilk_anah,string ilkver)
	{
		Veritabani[ad_tablo][ilk_anah]~=ilkver;
	}

/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/ //
	void save(string sifre)
	{
		dbwrite(vt_adi,sifre);
	}
/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/

} //class sonu
