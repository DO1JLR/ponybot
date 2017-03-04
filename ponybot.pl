#!/usr/bin/perl
############################################
#                                          #
#   Anleiten zum Benutzen des Ponybots:    #
#                                          #
#   Änder die globale Variablen            #
#                        und habe Spaß!    #
#                                          #
#   Für Mehr Details:                      #
#             Lies die README.md           #
#   https://github.com/L3Dokt0r/ponybot/   #
#                                          # 
############################################
use JSON;                       # Zum einlesen der Ponys
use LWP::Simple;                # Zum testen, wie das JSON aussieht, wird aber gerade nicht benötigt...
use Data::Dumper;				# Ausgabe der json zum testen (produktiv nicht benoetigt)
use strict;                     # Good practice
use warnings;                   # Good practice
use Irssi;                      # Für den Bot
use vars qw($VERSION %IRSSI);
$VERSION = "1.0";
%IRSSI = (
    authors         => "L3D",
    contact         => 'l3d@see-base.de',
    name            => "Ponybot",
    description     => "Ein Pony-IRC-Bot, der bei aktivierung ponys.",
    version         => "0.1",
    status			=> "alpha",
    license         => "GPL-3.0"
);
# important Variables:


Irssi::signal_add 'message public', 'sig_message_public';


sub sig_message_public {
    my ($server, $msg, $nick, $nick_addr, $target) = @_;
    if ($target =~ m/#(?:channelName)/) { # only operate in these channels
        # different messages to do something:
        if ($msg =~ m/!help/i){ #Reagiert auf "!help"
            $server->command("msg $nick Hey $nick, auf folgende Nachrichten reagiere ich:");
            $server->command("msg $nick !help - ruft diese Hilfe auf!");
            $server->command("msg $nick !node - Sagt, wie viele Nodes gerade online sind!");
            $server->command("msg $nick !name - Sagt die namen, der Nodes, die gerade online sind!");
			$server->command("msg $nick !top  - Zeigt die Top 5 Nodes mit den meisten Clients");
		}
}


sub nodes{
	my $name;
	my $json_text;
	open(DATEI, "/var/www/nodes.json") or die "Datei wurde nicht gefunden\n";
	my $daten;
   	while(<DATEI>){
	     	$daten = $daten.$_;
   	}
	close (DATEI);
#	print $daten;
	$json_text = $daten;
		
#	print $json_text;

	my $json        = JSON->new->utf8; #force UTF8 Encoding
	my $perl_scalar = $json->decode( $json_text ); #decode nodes.json
	$anzahl = 0; #Resette Anzahl auf 0
}
