package Test::Docker::Image::Boot::Boot2docker;

use strict;
use warnings;
use parent 'Test::Docker::Image::Boot';

use Test::Docker::Image::Utility qw(run docker);

sub host {
    return run(qw/boot2docker ip/);
}

1;
