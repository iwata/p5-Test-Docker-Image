package Test::Docker::Image::Boot;

use strict;
use warnings;

use Test::Docker::Image::Utility qw(docker);

sub new {
    my $class = shift;
    return bless{}, $class;
}

sub host {
    return '127.0.0.1'; # localhost
}

sub docker_run {
    my ($self, $ports, $image_tag) = @_;
    my $container_id = docker(qw/run -d -t/, @$ports, $image_tag);
    return $container_id;
}

sub docker_port {
    my ($self, $container_id, $container_port) = @_;
    my $port_info = docker('port', $container_id, $container_port);
    my (undef, $port) = split ':', $port_info;
    return $port;
}

sub on_destroy {
    my ($self, $container_id) = @_;
    for my $subcommand ( qw/kill rm/ ) {
        docker($subcommand, $container_id);
    }
}

1;
