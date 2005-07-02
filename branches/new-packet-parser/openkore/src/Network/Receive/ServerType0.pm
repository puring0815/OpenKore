package Network::Receive::ServerType0;

use strict;
use base qw(Network::Receive);

use Globals;
use Actor;
use Actor::You;
use Time::HiRes qw(time usleep);
use Settings;
use Log qw(message warning error debug);
use FileParsers;
use Interface;
use Network;
use Network::Send;
use Misc;
use Plugins;
use Utils;
use Skills;

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new;
	return $self;
}

sub map_loaded {
	$conState = 5;
	undef $conState_tries;
	$char = $chars[$config{'char'}];

	if ($xkore) {
		$conState = 4;
		message("Waiting for map to load...\n", "connection");
		ai_clientSuspend(0, 10);
		initMapChangeVars();
	} else {
		message("You are now in the game\n", "connection");
		sendMapLoaded(\$remote_socket);
		$timeout{'ai'}{'time'} = time;
	}

	$char->{pos} = {};
	makeCoords($char->{pos}, substr($msg, 6, 3));
	$char->{pos_to} = {%{$char->{pos}}};
	message("Your Coordinates: $char->{pos}{x}, $char->{pos}{y}\n", undef, 1);

	sendIgnoreAll(\$remote_socket, "all") if ($config{'ignoreAll'});
}

1;
