
### Funkcionális programozás gyakorlat

#### Elérhetőségek

- Gyakorlatvezető: Kovács András, email: kovacsandras @ inf.elte.hu (szóközök nélkül @ körül). 
- Konzultáció: péntek 12-14, 00.803 nyelvi labor
- Házi feladatok beadásának helye: https://bead.inf.elte.hu/
  + Ide regisztrálni kell ugyanazzal a névvel/jelszóval, mint amivel labor gépekbe lehet belépni. 
  + Fel kell venni a csoportot, és a heti házikat itt kell leadni. 
  + Akárhányszor be lehet adni egy házit a határidőig, minden beadás után kb. fél perc múlva jelez a felület,
    hogy átment-e a megoldás a testzteken.
  + Megoldás csak formailag helyes és típushelyes lehet.
- Tárgyi honlap: http://lambda.inf.elte.hu/. Itt találhattok interaktív jegyzetet a korábbi tananyaghoz, de jelentős az átfedés a mostanival. A követelmények és vizsgaidőpontok a jelenlegi félévre még nincsenek itt jelenítve.

#### Követelmények

- Gyakorlat:
  + Nincs jegy. Aláírás van, azaz a gyakorlati követelmények teljesítése a feltétele a vizsgára jelentkezésnek.
  + Követelmény: 
    1. Maximum három hiányzás
    2. Heti házi feladatok beadása
  + Szorgalmi időszak utolsó hetében gyakorló zárthelyi. Ez nem számít be sehova, célja a vizsga formátumával és tartalmával való megismerkedés, a részvétel viszont kötelező.
- Vizsga:
  + Vizsgaidőszakban. A tárgy jegyét a vizsga adja. Két részből áll: írásbeli (feleletválasztás), aztán gépes feladatmegoldás. Összesen három óra szokott rendelkezésre állni.
 
#### Eszközök

- GHC interpreter. Ajánlott installáció: https://www.haskell.org/platform/ 
- Bármilyen, kód szerketésére alkalmas szövegszerkesztő. 
  + Egyszerű szerkesztők (ajánlott):
    - Windows: notepad++
    - linux: gedit, medit, geany.
  + (Fejlettebb szerkesztők: Emacs, Visual Studio Code, Sublime Text, Atom)
  + Munkafolyamat: nyissunk parancssort egy könyvtárban, ahol .hs fájlok vannak, majd a parancssorban `ghci`-t indítsunk, és a `ghci`-ben `:l fájl.hs` paranccsal betölthetünk egy fájlt. Továbbá, lehet `ghci fájl.hs`-el rögtön úgy indítani `ghci`-t, hogy egy fájl be legyen töltve.

