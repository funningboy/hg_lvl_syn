package Queue;
use strict;
use Data::Dumper;

sub new { 
    my $class = shift;
    my $self = {_gb_par_queue => [],
               };

    bless $self, $class;
    return $self;
}

sub clr_par_queue {
    my ($self) = (@_);
    $self->{_gb_par_queue} = [];
}

sub get_all_par_queue_table {
    my ($self) = (@_);
    return $self->{_gb_par_queue};
}

sub is_par_queue_empty {
    my ($self) = (@_);
   
    if( !@{$self->{_gb_par_queue}} ){ return 0; }

return -1;
}

sub push_par_queue {
    my ($self,$name) = (@_);
    push( @{$self->{_gb_par_queue}},$name);
}

sub pop_all_par_queue {
    my ($self,$name) = (@_);
    my $st=();

    my @arr = @{$self->{_gb_par_queue}};
    my $i = $#arr;

    $st = join(',',@{$self->{_gb_par_queue}});
  return $st;
}

sub shift_all_par_queue {
    my ($self,$name) = (@_);
    my $st=();

    my @arr = @{$self->{_gb_par_queue}};
    my $i = $#arr;

       $st = join(',', @{$self->{_gb_par_queue}});
  return $st;
}


1;
