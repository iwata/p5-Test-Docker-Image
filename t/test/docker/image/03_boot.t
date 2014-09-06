use strict;
use warnings;

use Test::More;

use Test::Docker::Image::Boot;

my $boot = Test::Docker::Image::Boot->new;

subtest "host" => sub {
    my $exp = '127.0.0.1';
    my $got = $boot->host;
    is $got => $exp, "localhost";
};

done_testing;
