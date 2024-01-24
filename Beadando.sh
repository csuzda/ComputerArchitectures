#!/bin/bash

#telepített csomagokat lekérdezése
installed_packages=$(dpkg --get-selections | grep -E '\<install$' | cut -f1)
#dpkg=Debian Package Manager segítségével kiíratjuk azokat a csomagokat amik
#fel vannak telepítve. A listában megtalálhatóak a feltelepített és törölt
#csomagok is, így a grep -E paranccsal csak azokat listázzuk amik telepítva vannak.
#Mivel nekünk ebből a listából csak a csomag neve kell, ezért a cut -f1 paranccsal
#csak az első mező értékeit fogjuk használni.
#Az installed_packages változóban pedig elmentjük ezt a listát.

#Csomagok függőségeinek lekérdezése és kiíratása
for package in $installed_packages; do
	depedencies=$(apt-cache depends $package | grep "Depends" | awk '{print $2}' | tr '\n' ', ')
	echo "$package : $depedencies"
done

#Minden egyes csomagra ami fel van telepítve az alábbi utasítást hatjsa végre:
#A depedencies (függőségek) változóban mentse el az alábbi értéket:
#az apt-cache depends parancs információt szolgáltat egy bizonyos csomag függőségeiről
#Közben ez a csomagot  a package változóban mentse el.
#Ebből a listából nekünk csak azokat listázzuk amik függnek valamitől (grep "depends").
#Az awk paranccsal a sor 2. értékét írjuk ki.
#A jobb láthatóság érdekében a tr paranccsal beszúrunk új sort és vesszőt. 
#Végül az echo paranccsal kiíratjuk, hogy melyik csomagnak milyen függőségei vannak.
