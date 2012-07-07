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



class Vt
{
	
	string vt_adi;
	string[] [string][string] Veritabani; //İşte bu bizim tüm veritabanımız kucuk gibi 
	//gorunmesin gayet guclu oldugunu ileride göreceksiniz 
	

	
/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/ //
	void dbwrite(string vtadi_)
	{
		scope File dosya = new File(vtadi_,FileMode.OutNew);
		foreach(tabloadi,anahtares;Veritabani)
		{
			dosya.writeLine("|"~tabloadi~"|");
			foreach(anahtaradi,veriler;anahtares)
			{
				dosya.writeLine("*"~anahtaradi~"*");
				foreach(veri;veriler)
				{
					dosya.writeLine(veri);
				}
			}	
		}
	}
/***********************************************************************/
	void dbopen(string dosya_adi)
	{
		vt_adi=dosya_adi;
		scope File dosya = new File(dosya_adi,FileMode.In);
		
		
		string tablo_s;
		
		string anahtar_s;
		
		string[] veri_s;
		while(dosya.available)
		{
			char[] satir_c=dosya.readLine();
			string satir_s=to!(string)(satir_c);
			
			
			
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
	void save()
	{
		vtyaz(vt_adi);
	}
/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/
/*	dchar[] coz(dchar[] sifre, dchar[] bayrak)
    {
	dchar[] yenisifre;
        int sayi;
        int say=bayrak.length;
        foreach(ref karakter; sifre){
            sayi=say%bayrak.length;
            yenisifre~=cast(int)karakter-cast(int)bayrak[sayi];
            ++say;
        }
        return yenisifre;
    }
*/
/********************************************************************/
/*	 dchar[] gizle(dchar[] sifre, dchar[] bayrak)
    {
        dchar[] yeniSifre;
        int sayi;
        int say=bayrak.length;
        foreach(ref karakter; sifre){
            sayi=say%bayrak.length;
            yeniSifre~=cast(int)karakter+cast(int)bayrak[sayi];
            ++say;
        }
        return yeniSifre;
    }
*/
/+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/
} //class sonu
