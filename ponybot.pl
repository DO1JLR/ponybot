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
    version         => "0.4",
    status			=> "alpha",
    license         => "GPL-3.0"
);
# important global Variables:
our $main_channel = "ponyville"; #    Use '|' for multiple channels
our $keyword = "pony|cyber";
our $signal = "peace|cyder";

# programm
our $user = getpwuid( $< );
our @pony;
our $tmp;
our $lastpony = `/bin/cat /tmp/lastpony`;
our @tmp_2;
Irssi::signal_add 'message public', 'sig_message_public';

sub sig_message_public {
    my ($server, $msg, $nick, $nick_addr, $target) = @_;
    if ($target =~ m/#(?:$main_channel)/) { # only operate in these channels
        # listen to signal to do something:
        if ($msg =~ m/!(?:$signal)/i){ # listening for "!$keyword"
            if ($msg =~ m/(\#)/i){
                print "Y";
                my @ary=split(/ /,$msg);
                my $n = 0;
                my $ne;
                foreach (@ary){ $n++; if ($_ =~ m/(\#)/i){ $ne = $n - 1; } }
                my $destination_channel = $ary[$ne];
                # print $destination_channel;
                $server->command("msg $target Hey $nick, du schickst ein Pony in den Channel $destination_channel");
                get_pony(); # execute 'get_pony' and use a new pony
                $server->command("join -window $destination_channel");
                # print @pony; # uncomment for advanced debugging
                print "[I] Debug-SendPony: $tmp"; 
                # for my $s (@tmp_2){ print "$s\n"; } # uncomment for advanced debugging
                for my $mlp (@pony){
                    $server->command("msg $destination_channel $mlp");
                }
                $server->command("msg $destination_channel Dieses Pony wurde versendet durch $nick aus dem Channel '#ponyville'.");
                $server->command("window close"); 
            }
        }
        # listen to keyword to do something:
        elsif ($msg =~ m/!(?:$keyword)/i){ # listening for "!$keyword"
            $server->command("msg $target Hey $nick, du hast dir ein Pony gewünscht:");
            get_pony(); # execute 'get_pony' and use a new pony
            # print @pony; # uncomment for advanced debugging
            print "[I] Debug: $tmp"; 
            # for my $s (@tmp_2){ print "$s\n"; } # uncomment for advanced debugging
            for my $mlp (@pony){
                $server->command("msg $target $mlp");
            }
        }
    } 
    $server->command("/script load ponybot.pl");
}

sub get_pony {
    my $dirname = "/home/$user/.irssi/ASCII-Pony/rendered/irc/"; # define the directory with the ascii ponys
    my @ascii;
    my $ponyfile;
    opendir(DIR,"$dirname") || die $!; # How many ponys could we use?
        @ascii = readdir(DIR);
    close DIR;
    @ascii = grep {$_ ne '.'} @ascii;
    @ascii = grep {$_ ne '..'} @ascii;
    my $hour = (localtime)[2];
    my $thispony;
    if ( $hour >= 22 or $hour < 5 ) {
        $ponyfile = "luna.irc";
    } else {
      $thispony = int(rand(int($#ascii) ));
      while ($thispony eq $lastpony){  $thispony = int(rand(int($#ascii) )); }
      $ponyfile = $ascii[ $thispony ];
    }
    @tmp_2 = @ascii;
    $tmp = "Ponyanzahl: ";
    $tmp .= int($#ascii)-1;
    $tmp .= " Thispony: $thispony";
    open (DATEI, "/home/$user/.irssi/ASCII-Pony/rendered/irc/$ponyfile") or die $!; # Choose a 'random' pony
    @pony = <DATEI>; # Save pony as global array
    close (DATEI);   
    `/bin/echo "$thispony" > /tmp/lastpony`
}


