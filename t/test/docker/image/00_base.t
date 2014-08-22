use strict;
use warnings;

use Test::More;
use Test::Deep;
use Test::Exception;
use Test::Mock::Guard;

use Test::Docker::Image;

my ($boot, $tag, $container_ports)
    = ('Test::Docker::Image::Boot::Hoge', 'iwata/centos6-mysql51-q4m-hs', [3306, 80]);
my $container_id = '50e6798fa852e8568ca4e2be7890e40271b69bba000cd769c3d56e2a7e254efaa';

subtest "new" => sub {
    my $guard = mock_guard('Test::Docker::Image' => +{
        _run => sub {
            my (@args) = @_;
            if ( scalar(@args) == 3 ) {
                my $exp = ['docker', re('^(:?kill|rm)$'), $container_id];
                cmp_deeply \@args => $exp, 'destroy';
            } else {
                my $exp = [qw/docker run -d -t -p 3306 -p 80/, $tag];
                is_deeply \@args => $exp, 'docker run';
                return $container_id;
            }
        },
    });

    lives_and {
        my $docker_image = Test::Docker::Image->new(
            tag             => $tag,
            sleep_secs      => 0.1,
            container_ports => $container_ports,
        );

        is $docker_image->tag => $tag;
        is_deeply $docker_image->container_ports => $container_ports;
        is $docker_image->container_id => $container_id;
        isa_ok $docker_image->{boot} => 'Test::Docker::Image::Boot';

    };
    is $guard->call_count('Test::Docker::Image' => '_run') => 3;
};

subtest "port" => sub {
    my $container_port = 3306;
    my $host_port      = 49172;

    my $guard = mock_guard('Test::Docker::Image' => +{
        _run => sub {
            my (@args) = @_;
            unless ( scalar(@args) == 4 ) {
                return $container_id;
            }

            my $exp = [qw/docker port/, $container_id, $container_port];
            is_deeply \@args => $exp, 'docker port';
            return "0.0.0.0:$host_port";
        },
    });

    lives_and {
        my $docker_image = Test::Docker::Image->new(
            tag             => $tag,
            container_ports => $container_ports,
        );

        is $docker_image->port( $container_port ) => $host_port;
    };
    is $guard->call_count('Test::Docker::Image' => '_run') => 4;
};

done_testing;
