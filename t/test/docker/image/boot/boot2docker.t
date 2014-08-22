use strict;
use warnings;

use Test::More;

use Test::Docker::Image::Boot::Boot2docker;

my $boot = Test::Docker::Image::Boot::Boot2docker->new;

subtest "host" => sub {
    local $ENV{DOCKER_HOST} = 'tcp://192.168.59.103:2375';
    my $exp = '192.168.59.103';
    my $got = $boot->host;
    is $got => $exp, 'see $DOCKER_HOST';
};

done_testing;
