
package CDFG;
use Graph;
use Data::Dumper;
use strict;

sub new {
 my $class = shift;
 my $self = { Graph_list  => Graph->new(),
              Vertex_list => {},
              Edge_list   => {},
            };             # A directed graph.
 bless $self, $class;
 return $self;
}

sub clr_vertex {
    my ($self) = (@_);
    my @arr = keys %{$self->{Vertex_list}};
        $self->{Graph_list}->delete_vertices(@arr); 
        $self->{Vertex_list} = {};
}

sub del_vertex {
   my ($self,$name) = (@_);
   delete $self->{Vertex_list}->{$name};
   $self->{Graph_list}->delete_vertex($name);
}

sub set_vertex {
    my ($self,$name,$time_lvl) = (@_);
        $self->{Vertex_list}->{$name} = $time_lvl;
        $self->{Graph_list}->add_vertex($name);
}

sub clr_edge {
    my ($self) = (@_);
    my @arr = keys %{$self->{Vertex_list}};
        $self->{Graph_list}->delete_edges(@arr);
        $self->{Vertex_list} = {};
}


sub del_edge {
  my ($self,$src,$dst) = (@_);
      $self->{Graph_list}->delete_edge($src.'->'.$dst); 
      delete $self->{Edge_list}->{$src.'->'.$dst};
}

sub set_edge {
    my ($self,$src,$dst,$time_dly) = (@_);
        $self->{Edge_list}->{$src.'->'.$dst} = $time_dly; 
        $self->{Graph_list}->add_edge($src,$dst);
}

sub set_path {
    my ($self,$src,$dst) = (@_);
    $self->{Graph_list}->add_path($src,$dst); 
}


sub dump_CDFG {
    my ($self) = (@_);
   
     if( !%{$self->{Vertex_list}} ||
         !%{$self->{Edge_list}}   ||
         !$self->{Graph_list}       ){ return -1; }


    print "Graph\n";
#    my @arr = split('\,',$self->{Graph_list});
#    foreach (@arr){ print $_."\,\n"; }
    print $self->{Graph_list}."\n";

    print "CDFG->Vertices\n";
    print Dumper($self->{Vertex_list});
    print "CDFG->Edges\n";
    print Dumper($self->{Edge_list});

return 0;
}

1;
