package BlockForGraph;
use CDFG;
use Data::Dumper;
use strict;

sub new {
  my $class = shift;
  my $self  = {}; 
  bless $self, $class;
  return $self;
}

sub error {
    my ($st) = (@_);
    print $st; 
}

sub del_for_init_graph {
    my ($self) = (@_);
    $self->{For_init} = ();
}

sub set_for_init_graph {
    my ($self,$condhs) = (@_);

    my %cond = %{$condhs};

    $self->{For_init} = CDFG->new();

    my @arr = @{$cond{Vertex}};
    for(my $i=0; $i<=$#arr; $i++){
        $self->{For_init}->set_vertex($arr[$i]->{vex},$arr[$i]->{dly});
    }

    my @arr = @{$cond{Edge}};
    for(my $i=0; $i<=$#arr; $i++){
       $self->{For_init}->set_edge($arr[$i]->{src},$arr[$i]->{dst},$arr[$i]->{dly}); 
    }
}

sub del_for_cond_graph {
    my ($self) = (@_); 
    $self->{For_cond} = ();
}



sub set_for_cond_graph {

}

sub set_for_body_graph {

}

sub set_for_update_graph {

}

sub set_for_end_graph {

}

sub set_switch_cond_graph {

}

1;

