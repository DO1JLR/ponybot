# ponybot
Ein irssi-bot, der Ponys anzeigt!

##Und wofür?
Die Idee ist, auf bestimmte Schlüsselwörter im IRC Channel (derzeit ``!pony``) ein ASCII-Pony zu malen.
Irgendwann könnte das natürlich mal auf mehrere Bots aufgeteilt werden, da sich der IRC oft sehr schwer tut bewliebig viele Zeilen direkt hintereinander ohne Zeitlichen abstand zu schreiben...

##Und wie setze ich das wo ein?
Das aussehen der Ponys ist in dem JSON File gespeichert. 
Welche Channel belauscht werden ist über die globalen Varianten am Anfang des Perl Scripts geregelt.
Am besten diese Dateien anpassen und dann ausprobieren.

##Hä?
Dieser "bot" ist ein Perl Script, das für das Programm irssi ist... 

##Abhängigkeiten
Als Abhängigkeiten muss noch das GitHub Repository [ASCII-Pony](https://github.com/L3Dokt0r/ASCII-Pony) geklont werden.

##Installation:

```bash

cd ~/.irssi/
git clone https://github.com/L3Dokt0r/ponybot.git
git clone https://github.com/L3Dokt0r/ASCII-Pony.git
mkdir scripts
ln -s ~/.irssi/ponybot/ponybot.pl ~/.irssi/scripts/ponybot.pl
mkdir script/autojoin
ln -s ~/.irssi/ponybot/ponybot.pl ~/.irssi/scripts/autojoin/ponybot.pl

```

Und in irssi:
```
/script load ponybot.pl
```
