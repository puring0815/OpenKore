# pRO Thor as of December 1 2006
package Network::Receive::ServerType14;

use strict;
use base qw(Network::Receive);

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new;
	return $self;
}

1;
