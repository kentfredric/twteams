use strict;
use warnings;

package twteam;
use Moo;

has name    => ( is => ro =>, required => 1 );
has leaders => ( is => ro =>, default  => sub { [] } );
has areas   => ( is => ro =>, default  => sub { [] } );
has members => ( is => ro =>, default  => sub { [] } );

sub from_file {
  my ( $self, $file ) = @_;
  require twteams::teamfile;
  my $stash = twteams::teamfile->parse_file($file);
  $stash->{name} = shift @{ $stash->{name} };
  return $self->new( $stash );

}

sub to_s {
  my $self = shift;
  my @lines;
  push @lines, sprintf '[**]SQUAD %s[||][/**]', uc( $self->name );
  my @leader_ranks = ( 'Commander', 'Captain', 'Co-Captain' );
  push @lines, '[**]Leaders[||][/**]';
  for my $id ( 0 .. $#leader_ranks ) {
    if ( $self->leaders->[$id] ) {
      push @lines, sprintf '[*]%s[|][player]%s[/player][/*]', $leader_ranks[$id], $self->leaders->[$id];
    }
  }
  push @lines, '[**]Areas Of Responsibility[||][/**]';
  for my $area ( @{ $self->areas } ) {
    push @lines, sprintf '[*][|]%s[/*]', $area;
  }
  push @lines, '[**]Members[||][/**]';
  for my $member ( @{ $self->members } ) {
    push @lines, sprintf '[*][|][player]%s[/player][/*]', $member;
  }
  return join qq{\n}, '[table]', @lines, '[/table]', '';
}

1;
