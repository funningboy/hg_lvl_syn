package TopGraph;
use strict;
use Data::Dumper;
use BlockIfGraph;
use BlockForGraph;


sub new {
    my $class = shift;
    #print "Class $class\n";
    my $self = { if_cond  => {},
                 if_body  => {},
                 if_end   => {},
                 gl_if_id => 0,
                 gl_if_list => {},
                 gl_for_id=> 0,
                 }; 
    bless $self, $class;
    return $self;
}

sub set_BlockIf_cond_hstable {
    my ($self,$condhs) = (@_);

    my @cond = @{$condhs};
    my @queue = {}; 

     push (@queue, $cond[0]);
     push (@{$self->{if_cond}->{Vertex}}, { vex => $cond[0],
                                            dly => 0, }); 
     
    for(my $i=1; $i<=$#cond; $i++){

     push (@{$if_cond{Vertex}}, { vex => $cond[$i],
                                  dly => 0, }); 
 
     push (@{$if_body{Edge}}, { src => pop(@queue),
                                dst => $cond[$i], 
                                dly => '0', });
     
     push(@queue, $cond[$i]);  
    }
}



sub clr_BlockIf_cond_hstable {
#    $if_body = 
}

sub set_BlockIf_Graph {
    $gl_if_list->{$gl_if_id} = BlockIfGraph->new(); $gl_if_id++;
}

sub set_BlockIf_cond_Graph {
    my ($if_condhs) = (@_);
    $gl_if_list->{$gl_if_id}->set_if_cond_graph($if_condhs);
}

sub set_BlockIf_body_Graph {
   my ($if_bodyhs) = (@_);
   $gl_if_list->{$gl_if_id}->set_if_body_graph($if_bodyhs); 
}
