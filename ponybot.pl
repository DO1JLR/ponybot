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
    description     => "A pony-irssi bot to draw colored ascii ponys in some channels.",
    version         => "0.2",
    status			=> "alpha",
    license         => "GPL-3.0"
);
# important global Variables:
our $main_channel = "ponyville"; #    Use '|' for multiple channels
our $other_channels = "ccczh|spam"; # Use '|' for multiple channels
our $keyword = "pony";

# programm
our $user = getpwuid( $< );
our @pony;
Irssi::signal_add 'message public', 'sig_message_public';

sub sig_message_public {
    my ($server, $msg, $nick, $nick_addr, $target) = @_;
    if ($target =~ m/#(?:$main_channel)/) { # only operate in these channels
        # listen to keyword to do something:
        if ($msg =~ m/!(?:$keyword)/i){ # listening for "!$keyword"
            $server->command("msg $target Hey $nick, du hast dir ein Pony gewünscht:");
            get_pony(); # execute 'get_pony' and use a new pony
            for my $mlp (@pony){
                $server->command("msg $target $mlp");
            }
        }
    }
    elsif ($target =~ m/#(?:$other_channels)/) { # now only operate in these Channels...
        # Listening for a keyword 2 do sth.
        if ($msg =~ m/!(?:$keyword)/i){ # listening for "!$keyword"
            $server->command("msg $target Hey $nick, du hast dir ein Pony gewünscht:");
            # 2DO: make a few little ponys for big irc channels...
            get_pony(); # execute 'get_pony' and use a new pony
            for my $mlp (@pony){
                $server->command("msg $target $mlp");
            }
            no_spam;
        }
    }
    $server->command("/script load ponybot.pl");
}

sub get_pony {
    my $dirname = "/home/$user/.irssi/ASCII-Pony/rendered/irc/"; # define the directory with the ascii ponys
    my @ascii;
    opendir(DIR,"$dirname") || die $!; # How many ponys could we use?
        @ascii = readdir(DIR);
    close DIR;
    open (DATEI, "/home/$user/.irssi/ASCII-Pony/rendered/irc/$ascii[int(rand($#ascii))-1]") or die $!; # Choose a 'random' pony
    @pony = <DATEI>; # Save pony as global array
    close (DATEI);   
}
sub no_spam {
    $server->command("msg $nick Hey $nick, du hast dir vorhin ein Pony im Channel $target gewünscht.");
    $server->command("msg $nick Das ist voll okay und kommt auch meistens echt gut an");
    $server->command("msg $nick ... ");
    $server->command("msg $nick ABER man muss es ja nicht übertreiben!");
    $server->command("msg $nick Wenn du regelmäßig Ponys haben möchtest, dann besuche doch mal");
    $server->command("msg $nick den Kanal #ponyville auch hackint.org oder chaostreff.ch");
    $server->command("msg $nick :D");
    $server->command("msg $nick Wenn dir der Bot gefällt oder du funktionen vermisst:");
    $server->command("msg $nick Schau doch mal auf https://github.com/L3Dokt0r/ponybot vorbei")
    $server->command("msg $nick Und hier noch ein Pony:")
    get_pony;
    for my $mlp (@pony){
        $server->command("msg $nick $mlp");
    }
}
