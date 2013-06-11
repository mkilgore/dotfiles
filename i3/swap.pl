#!/usr/bin/env perl

use warnings;
use strict;
use Pod::Usage;

unless (@ARGV == 0) {
    pod2usage({ -verbose => 2 }) if $ARGV[0] eq "--help"
                                 or $ARGV[0] eq "-h";
}

use lib "$ENV{HOME}/.i3";
use i3;

die if not defined $ARGV[0];

my $i3 = new i3;

my $target = shift;

my $focused = $i3->current_workspace->{name};
die if not defined $focused;

exec("i3-msg 'rename workspace $target to VIFON_TEMP;
rename workspace $focused to $target;
rename workspace VIFON_TEMP to $focused'");

=head1 NAME

i3-swap-ws - swap workspace

=head1 SYNOPSIS

B<i3-swap-ws> I<workspace_name>

=head1 DESCRIPTION

Swap the current workspace with I<workspace_name>.

=head1 SEE ALSO

B<i3>(1)

=head1 COPYRIGHT

Copyright (C) 2012 Wojciech Siewierski

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
