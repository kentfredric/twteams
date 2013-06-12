
use strict;
use warnings;

package twteams::teamfile;

use Path::Tiny qw( path );

sub parse_handle {
    my $self = shift;
    my $fh = shift;
    my $stash;
    my $current = "";

    while ( my $line = <$fh> ) {
        chomp $line;
        if ( $line =~ /^__\[([^]]+)\]__$/ ){
            $current = $1;
            next;
        }
        if ( not exists $stash->{$current} ) {
            $stash->{$current} = [];
        }
        push @{ $stash->{$current} }, $line;
    }
    return $stash;
}

sub parse_file {
    my ( $self, $file ) = @_;
    return $self->parse_handle( path($file)->openr );
}
1;
