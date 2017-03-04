#!/usr/bin/perl
############################################
#                                          #
#   Anleiten zum Benutzen des Ponybots:    #
#                                          #
#   Änder die globale Variablen            #
#                        und habe Spaß!    #
#                                          #
#   Für Mehr Details und Abhängigkeiten:   #
#             Lies die README.md           #
#   https://github.com/L3Dokt0r/ponybot/   #
#                                          # 
############################################
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
our $channels = "ccczh|see-base"; # Benutze '|' zum trennen der Channels

Irssi::signal_add 'message public', 'sig_message_public';


sub sig_message_public {
    my ($server, $msg, $nick, $nick_addr, $target) = @_;
    if ($target =~ m/#(?:$channels)/) { # only operate in these channels
        # different messages to do something:
        if ($msg =~ m/!pony/i){ #Reagiert auf "!pony"
            $server->command("msg $target Hey $nick, du hast dir ein Pony gewünscht:");
            $server->command("msg $target Bitte warte...");
		}
}

