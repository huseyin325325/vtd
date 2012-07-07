module crypt;



dchar[] decrypt(dchar[] sifre, dchar[] bayrak)
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



dchar[] encrypt(dchar[] sifre, dchar[] bayrak)
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
