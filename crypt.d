module crypt;
import std.stdio;
import std.range;
import std.conv;
 
string decrypt(string sifre_s, string bayrak)
    {
    char[] sifre=to!(char[])(sifre_s);
 
    char[] yenisifre;
        int sayi;
        int say=bayrak.length;
        
 
 
        for(;!sifre.empty;sifre.popFront()){
            sayi=say%bayrak.length;
            yenisifre~=cast(int)sifre.front-cast(int)bayrak[sayi];
            ++say;
        }
        return to!(string)(yenisifre);
    }
string encrypt(string sifre_s, string bayrak)
    {
        char[] yeniSifre;
        char[] sifre=to!(char[])(sifre_s);
        int sayi;
        int say=bayrak.length;
        for(;!sifre.empty;sifre.popFront()){
            sayi=say%bayrak.length;
            yeniSifre~=cast(int)sifre.front+cast(int)bayrak[sayi];
            ++say;
        }
        return to!(string)(yeniSifre);
    }
