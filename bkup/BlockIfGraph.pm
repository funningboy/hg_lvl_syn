package BlockIfGraph;
use CDFG;
use Data::Dumper;
use strict;

sub new {
  my $class = shift;
  my $self  = { If_cond => {},
                If_body => {},}; 
  bless $self, $class;
  return $self;
}

sub error {
    my ($st) = (@_);
    print $st; 
}

sub del_if_cond_graph {
    my ($self) = (@_); 
    $self->{If_cond} = ();
}

sub set_if_cond_graph {
    my ($self,$condhs) = (@_); 
    
    my %cond = %{$condhs};
    
        $self->{If_cond} = CDFG->new(); 

#       if( !@{$cond{Vertex}}){ error("@ BlockGraph $id cond->Vertex not defined\n"); }
#       if( !@{$cond{Edge}}  ){ error("@ BlockGraph $id cond->Edge   not defined\n"); }

        my @arr = @{$cond{Vertex}};
        for(my $i=0; $i<=$#arr; $i++){
            $self->{If_cond}->set_vertex($arr[$i]->{vex},$arr[$i]->{dly});
        }

        my @arr = @{$cond{Edge}};
        for(my $i=0; $i<=$#arr; $i++){
           $self->{If_cond}->set_edge($arr[$i]->{src},$arr[$i]->{dst},$arr[$i]->{dly}); 
        }
}

sub del_if_body_graph {
    my ($self) = (@_); 
    $self->{If_body} = ();
}

sub set_if_body_graph {
   my ($self,$condhs) = (@_); 
    
    my %cond = %{$condhs};
 
        $self->{If_body} = CDFG->new(); 

#       if( !@{$cond{Vertex}}){ error("@ BlockGraph $id body->Vertex not defined\n"); }
#       if( !@{$cond{Edge}}  ){ error("@ BlockGraph $id body->Edge   not defined\n"); }

        my @arr = @{$cond{Vertex}};
        for(my $i=0; $i<=$#arr; $i++){
            $self->{If_body}->set_vertex($arr[$i]->{vex},$arr[$i]->{dly});
        }

        my @arr = @{$cond{Edge}};
        for(my $i=0; $i<=$#arr; $i++){
           $self->{If_body}->set_edge($arr[$i]->{src},$arr[$i]->{dst},$arr[$i]->{dly}); 
        }
}

sub del_if_end_graph {
   my ($self) = (@_); 
       $self->{If_end} = (); 
}

sub set_if_end_graph {
   my ($self,$condhs) = (@_); 
    
    my %cond = %{$condhs};
 
        $self->{If_end} = CDFG->new(); 
}

sub dump_if_graph {
    my ($self) = (@_);

        print '@ if->cond'."\n";
        ( $self->{If_cond} )? $self->{If_cond}->dump_CDFG() : -1; 
        print '@ if->body'."\n";
        ( $self->{If_body} )? $self->{If_body}->dump_CDFG() : -1;
        print '@ if->end'."\n";
        ( $self->{If_end}  )? $self->{If_end}->dump_CDFG()  : -1;
        
}

sub del_else_cond_graph {
   my ($self) = (@_);
       $self->{Else_cond} = ();
}

sub set_else_cond_graph {
   my ($self,$condhs) = (@_); 
    
    my %cond = %{$condhs};
        $self->{Else_cond} = CDFG->new();
}

sub del_else_body_graph {
   my ($self) = (@_);
       $self->{Else_body} = ();
}

sub set_else_body_graph {
   my ($self,$condhs) = (@_); 
    
    my %cond = %{$condhs};
        $self->{Else_body} = CDFG->new(); 

#       if( !@{$cond{Vertex}}){ error("@ BlockGraph $id body->Vertex not defined\n"); }
#       if( !@{$cond{Edge}}  ){ error("@ BlockGraph $id body->Edge   not defined\n"); }

        my @arr = @{$cond{Vertex}};
        for(my $i=0; $i<=$#arr; $i++){
            $self->{Else_body}->set_vertex($arr[$i]->{vex},$arr[$i]->{dly});
        }

        my @arr = @{$cond{Edge}};
        for(my $i=0; $i<=$#arr; $i++){
           $self->{Else_body}->set_edge($arr[$i]->{src},$arr[$i]->{dst},$arr[$i]->{dly}); 
        }
}

sub del_else_end_grpah {
   my ($self) = (@_);
       $self->{Else_end} = ();
}

sub set_else_end_graph {
   my ($self,$condhs) = (@_); 
    
    my %cond = %{$condhs};
        $self->{Else_end} = CDFG->new();
}

sub dump_else_graph {
    my ($self) = (@_);

        print '@ else->cond'."\n";
        ( $self->{Else_cond} )? $self->{Else_cond}->dump_CDFG() : -1; 
        print '@ else->body'."\n";
        ( $self->{Else_body} )? $self->{Else_body}->dump_CDFG() : -1;
        print '@ else->end'."\n";
        ( $self->{Else_end}  )? $self->{Else_end}->dump_CDFG()  : -1;
}

sub set_elsif_cond_graph {

}

sub set_elsif_body_graph {

}

sub set_elsif_end_graph {

}

1;
