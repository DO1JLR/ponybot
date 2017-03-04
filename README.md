# ponybot
Ein irssi-bot, der Ponys anzeigt!

##Und wofür?
Die Idee ist, auf bestimmte keywörter im IRC Channel moeglichst performat ein Pony zu malen.
Das sollte natürlich auf mehrere Bots aufgeteilt sein, da es ein Raid limit von mehreren Zeilen gibt, die man in einer bestimmten Zeit pasten kann...

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
