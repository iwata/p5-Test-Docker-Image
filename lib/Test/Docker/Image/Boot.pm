package Test::Docker::Image::Boot;

use strict;
use warnings;

sub new {
    my $class = shift;
    return bless{}, $class;
}

sub host {
    return '127.0.0.1'; # local
}

1;
