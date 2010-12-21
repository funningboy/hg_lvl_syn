package MyParser;
use Verilog::Parser;
use BlockIfGraph;
use PortGraph;
use Queue;
use Data::Dumper;
use Switch;
#use strict;

@ISA = qw(Verilog::Parser);

$gl_queue;
%gl_if_list;
$gl_id_id;
%gl_for_list;
$gl_for_id;

 

sub new {
    my $class = shift;
    #print "Class $class\n";
#    my $self = $class->SUPER::new();
    my $self = { Parse => $class->SUPER::new(),
                 Graph => {
                            mdl_gph_id  => 0,
                            blk_gph_id  => 0,
                          },
               };

#    $gl_queue   = Queue->new(); 
#    $gl_if_list = {};
#    $gl_if_id   = 0;
#    $gl_for_list= {};
#    $gl_for_id  = 0;

    bless $self, $class;
    return $self;
}

sub sysfunc {
    my $self = shift;
    my $token = shift;

    $self->{sysfuncs}{$token}++;
}

sub attribute {
    my $self = shift;
    my $token = shift;

    $self->{attributes}{$token}++;
}


sub operator {
    my $self = shift;
    my $token = shift;
     
       if( $token eq '@' && $self->{tag} eq 'always' ){ }
    elsif( $token eq '(' && $self->{tag} eq 'always' ){ }
    elsif( $token eq ')' && $self->{tag} eq 'always' ){ }
    elsif( $token eq '(' && $self->{tag} eq 'else'   ){ }
    elsif( $token eq '(' && $self->{tag} eq 'if'     ){ $self->{tag} = 'if_cond'; }
    elsif( $token eq ')' && $self->{tag} eq 'if_cond'){ $self->{tag} = 'if_body';
                                                        $gl_queue->shift_all_par_queue();
                                                        my $t = $gl_queue->get_all_par_queue_table();
                                                        $gl_queue->clr_par_queue();
                                                       # $gl_graph->set_BlockIf_cond_hstable($t);
                                                       # $gl_graph->set_BlockIf_Graph();
                                                       # $gl_graph->set_BlockIf_cond_Graph();
                                                      }
    elsif(                  $self->{tag} eq 'if_cond'){ $gl_queue->push_par_queue($token); }

     $self->{operators}{$token}++;
}

sub symbol {
    my $self = shift;
    my $token = shift;
    
     if( $self->{tag} eq 'always' && $self->{sen} eq 'pos' ){ }
  elsif( $self->{tag} eq 'always' && $self->{sen} eq 'neg' ){ }
  elsif( $self->{tag} eq 'always'){}
  elsif( $self->{tag} eq 'module'){    }

  elsif( $self->{tag} eq 'if_cond'){ $gl_queue->push_par_queue($token); }    

    $self->{symbols}{$token}++;
}



sub number {
    my $self = shift;
    my $token = shift;

    if( $self->{tag} eq 'if_cond' ){ $gl_queue->push_par_queue($token); }
   
    $self->{numbers}{$token}++;
}


sub keyword {
    my $self  = shift;
    my $token = shift;

    switch($token){
      case 'endmodule'  { $self->{tag} = 'endmodule';  } 
      case 'module'     { $self->{tag} = 'module';     }
      case 'always'     { $self->{tag} = 'always';     }
      case 'posedge'    { if($self->{tag} eq 'always'){ $self->{sen} = 'pos'; } }
      case 'negedge'    { if($self->{tag} eq 'always'){ $self->{sen} = 'neg'; } }
      case 'and'        { if($self->{tag} eq 'always'){ $self->{sen} = 'and'; } }
      case 'or'         { if($self->{tag} eq 'always'){ $self->{sen} = 'or' ; } }
      case 'assign'     {  $self->{tag} = 'assign';    }
      case 'else'       {  $self->{tag} = 'else';      }
      case 'if'         {  $self->{tag} = 'if';        }
      case 'end'        {  $self->{tag} = 'end';       }
      case 'begin'      {   } 
      case 'parameter'  { $self->{tag} = 'parameter';  }
    }
   $self->{keywords}{$token}++;
   print $token."\n";
}



1;
