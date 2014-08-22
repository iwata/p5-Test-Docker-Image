package Test::Docker::Image::Boot::Boot2docker;

use strict;
use warnings;
use parent 'Test::Docker::Image::Boot';
use URI::Split 'uri_split';

sub host {
    my (undef, $auth) = uri_split $ENV{DOCKER_HOST};
    my ($host, $port) = split ':', $auth;
    return $host;
}

1;
