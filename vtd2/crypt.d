module crypt;
import std.stdio;
import std.range;
import std.conv;
 
string decrypt(string sifre_s, string bayrak)  
    {
    char[] sifre=to!(char[])(sifre_s);
 
    char[] yenisifre;
        size_t sayi;
        size_t say=bayrak.length;
        
 
 
        for(;!sifre.empty;sifre.popFront()){
            sayi=say%bayrak.length;
            yenisifre~=cast(int)sifre.front-cast(int)bayrak[sayi];
            ++say;
        }
        return to!(string)(yenisifre);
    }
    /++++++++++++++++++++++++++++++++++++++++++++++++++/
string encrypt(string sifre_s, string bayrak) //sifreleme
    {
        char[] yeniSifre;
        char[] sifre=to!(char[])(sifre_s);
        size_t sayi;
        size_t say=bayrak.length;
        for(;!sifre.empty;sifre.popFront()){
            sayi=say%bayrak.length;
            yeniSifre~=cast(int)sifre.front+cast(int)bayrak[sayi];
            ++say;
        }
        return to!(string)(yeniSifre);
    }
