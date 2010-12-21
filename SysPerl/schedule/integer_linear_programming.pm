#!/usr/bin/perl
 
package SysPerl::schedule::integer_linear_programming;
use SysPerl::DFG;
use SysPerl::constrain2DFG;
use strict;
use Data::Dumper;

sub new {
  my $class = shift;
  my $self  = {
      cons2DFG     => SysPerl::constrain2DFG->new(),
      alu_list     => {},
      bak_list     => {},
      index        => 0,
      deep_index   => 0, 
      total_power  => 0,
      avg_power    => 0,
      cyc_list     => {},
      distrib_list => {},
      pe_table     => {},
  };
  bless $self, $class;
  return $self;
}

#===============================
# method : integer_linear_programming scheduling
# flow1  . ASAP,ALAP,scheduling time graph
# flow2  . distribution graph
#===============================
sub run_integer_linear_programming_alg_ASAP {
   my ($self) = (@_);

       $self->{cons2DFG}->run_NewDFG_2_BakNewDFG_by_stacks();
       $self->{cons2DFG}->run_NewDFG_2_BakNewDFG_by_lists();
       $self->{cons2DFG}->clr_NewDFG_time_weighted();
       $self->{cons2DFG}->set_NewDFG_begin_time_weighted();
       $self->{cons2DFG}->run_NewDFG_ASAP_cycle();
       $self->{cons2DFG}->run_BakNewDFG_2_NewDFG_by_stacks();
       $self->{cons2DFG}->run_BakNewDFG_2_NewDFG_by_lists();

#   $self->{cons2DFG}->dump_NewDFG_time_weighted_edges();
#   $self->{cons2DFG}->dump_NewDFG_time_weighted_vertices();
#die;
}

sub run_integer_linear_programming_alg_ALAP {
    my ($self) = (@_);

       $self->{cons2DFG}->run_NewDFG_2_BakNewDFG_by_stacks();
       $self->{cons2DFG}->run_NewDFG_2_BakNewDFG_by_lists();
       $self->{cons2DFG}->clr_NewDFG_time_weighted();
       $self->{cons2DFG}->set_NewDFG_end_time_weighted();
       $self->{cons2DFG}->run_NewDFG_ALAP_cycle();
       $self->{cons2DFG}->run_BakNewDFG_2_NewDFG_by_stacks();
       $self->{cons2DFG}->run_BakNewDFG_2_NewDFG_by_lists();

#   $self->{cons2DFG}->dump_NewDFG_time_weighted_edges();
#   $self->{cons2DFG}->dump_NewDFG_time_weighted_vertices();
#die;
}

sub run_integer_linear_programming_alg_CSTEP {
    my ($self) = (@_);
        $self->{cons2DFG}->run_CSTEP_by_NewDFG();
        $self->{cons2DFG}->run_CSTEP_constrain_by_power();
}

sub set_deep_cons2DFG {
   my ($self,$DFG) = (@_);
       $self->{cons2DFG} = $DFG;
}

sub set_pe_number_constrain {
   my ($self,$pe_hs) = (@_);
       $self->{pe_table} = $pe_hs;
}

sub updt_pe_number_constrain {
   my ($self) = (@_);
 
   foreach my $pe (keys %{$self->{pe_table}} ){
     $self->{pe_table}->{$pe}++;
  } 
}


sub get_alu_list_cycle {
   my ($self) = (@_);

   my $alu_list = $self->{alu_list};
   my $cinx = $self->{index};
 
   foreach my $alu (sort {$alu_list->{$a}->{len}<=>$alu_list->{$b}->{len}} keys %{$alu_list} ){
           my $div = $alu_list->{$alu}->{len};
           my $cur = $alu_list->{$alu}->{cyc_list}->[$cinx%$div];      
              $self->{cyc_list}->{$cur}->{$alu} = 1;
              $cinx /= $div;
   }
#print Dumper($self->{cyc_list});
}

sub run_dependent_check {
  my ($self) = (@_);

  my $cyc_list = $self->{cyc_list};
  my $deep_cyc = $self->{cons2DFG}->{deep_cycle};

     $self->{cons2DFG}->run_NewDFG_2_BakNewDFG_by_stacks();
      
     foreach my $cyc (sort keys %{$cyc_list}){
       foreach my $alu ( keys %{$cyc_list->{$cyc}}){
          while($self->{cons2DFG}->{NewDFG}->is_vertex_pre_stack_empty($alu)){
                my $pre = $self->{cons2DFG}->{NewDFG}->shft_vertex_pre_stack($alu); 
                    for(my $i=$cyc+1; $i<=$deep_cyc; $i++){
                          if( $cyc_list->{$i}->{$pre} ) { return -1; }
                    }
         }  
      }
   }
 
   $self->{cons2DFG}->run_BakNewDFG_2_NewDFG_by_stacks();
return 0;
}


sub run_alu_check {
    my ($self) = (@_);
    
    my $cyc_list = $self->{cyc_list};
    my $index    = $self->{index};
    my $tmp_pe   = {};

    foreach my $cyc (keys %{$cyc_list}){
       $tmp_pe = {};
      foreach my $alu ( keys %{$cyc_list->{$cyc}} ){
            $alu =~ s/\:\:[0-9]*//g;
            $tmp_pe->{$alu}++;
#            print $cyc.','.$alu.','.$tmp_pe->{$alu}.','.$index."\n";
            if( $tmp_pe->{$alu} > $self->{pe_table}->{$alu} ){ return -1; }
      }
   }
return 0;
}

sub run_peak_power_check {
    my ($self) = (@_);

    my $cyc_list = $self->{cyc_list};
    my $index    = $self->{index};
   
       $self->{total_power} = 0;
    foreach my $cyc (keys %{$cyc_list}){ 
       my $sum =0;
       foreach my $alu (keys %{$cyc_list->{$cyc}} ){
               my $pw = $self->{cons2DFG}->{power_list}->{$alu};
                  $sum += $pw;
   }
      $self->{power_list}->{$index}->{$cyc} = $sum;
      $self->{total_power}+=$sum;
  }
      $self->{avg_power} = $self->{total_power}/$self->{cons2DFG}->{deep_cycle};
}

sub run_min_peak_power {
    my ($self) = (@_);

    my $power_list = $self->{power_list};
    my ($sum,$root,$min,$min_inx) = (0,0,0,0);

   foreach my $inx (keys %{$power_list}){ 
     $sum = 0;
     foreach my $cyc (keys %{$power_list->{$inx}}){
       $sum += ($power_list->{$inx}->{$cyc} - $self->{avg_power})**2;      
     }
      $root = sqrt($sum/$self->{cons2DFG}->{deep_cycle});   
      if( $min == 0 ||
          $root < $min ){ $min = $root; $min_inx = $inx; }
   }
 $self->{index} = $min_inx;
}

sub run_alu_list_2_bak_list {
    my ($self) = (@_);
    my $cyc_list = $self->{cyc_list};
    
    foreach my $cyc (keys %{$cyc_list}){
      foreach my $alu (keys %{$cyc_list->{$cyc}}){
        $self->{bak_list}->{$cyc}->{$alu} = $cyc_list->{$cyc}->{$alu};
    }
   }
}

sub run_bak_list_2_alu_list {
    my ($self) = (@_);
    my $bak_list = $self->{bak_list};   
   
    $self->{cyc_list} = {};

    foreach my $cyc (keys %{$bak_list}){
      foreach my $alu (keys %{$bak_list->{$cyc}}){
        $self->{cyc_list}->{$cyc}->{$alu} = $bak_list->{$cyc}->{$alu};
    }
  }
}

sub run_alu_list_ini {
  my ($self) = (@_);

  my $cst_alu  = $self->{cons2DFG}->{cstep_list}->{ALU};

  foreach my $alu ( keys %{$cst_alu}){
    my $bg = $cst_alu->{$alu}->{begin};
    my $ed = $cst_alu->{$alu}->{end};

       if( $bg!=$ed ){
         for(my $i=$bg; $i<=$ed; $i++){
             push (@{$self->{alu_list}->{$alu}->{cyc_list}},$i);
             $self->{deep_index}++;
       }
      $self->{alu_list}->{$alu}->{len} = $ed-$bg+1;
    } else{
      $self->{cyc_list}->{$bg}->{$alu} = 1;
     }
  }
}

sub run_updt_integer_linear_programming_alg_ASAP {
    my ($self) = (@_);

       my $cyc_list = $self->{cyc_list};
       
       $self->{cons2DFG}->run_NewDFG_2_BakNewDFG_by_stacks();
       $self->{cons2DFG}->run_NewDFG_2_BakNewDFG_by_lists();
       $self->{cons2DFG}->clr_NewDFG_time_weighted();
       $self->{cons2DFG}->set_NewDFG_begin_time_weighted();

       foreach my $cyc (keys %{$cyc_list}){
         foreach my $alu (keys %{$cyc_list->{$cyc}}){ 
            $self->{cons2DFG}->set_NewDFG_updt_time_weighted($alu,$cyc);
        }
       }

       $self->{cons2DFG}->run_NewDFG_ASAP_cycle();
       $self->{cons2DFG}->run_BakNewDFG_2_NewDFG_by_stacks();
       $self->{cons2DFG}->run_BakNewDFG_2_NewDFG_by_lists();
}

sub run_updt_distrib_list {
    my ($self) = (@_);

    my $power_list = $self->{power_list};
    my $inx        = $self->{index}; 

     foreach my $cyc (keys %{$power_list->{$inx}}){
        $self->{distrib_list}->{$cyc} = $power_list->{$inx}->{$cyc};
     }
}  

sub run_integer_linear_programming_scheduling {
    my ($self) = (@_);
    my $time = 0;
 
        $self->run_integer_linear_programming_alg_ASAP();
        $self->run_integer_linear_programming_alg_ALAP();
        $self->run_integer_linear_programming_alg_CSTEP();

        $self->run_alu_list_ini();
        $self->run_alu_list_2_bak_list();

      while($time>=0){
        for(my $i=0; $i<=$self->{deep_index}; $i++){ 
                      $self->{index} = $i; 
                      $self->run_bak_list_2_alu_list();
                      $self->get_alu_list_cycle();

            if( $self->run_alu_check()       !=-1 &&
                $self->run_dependent_check() !=-1 ){
                      $self->run_peak_power_check();
                 }
        }

       $self->run_min_peak_power();
       $self->run_bak_list_2_alu_list();
       $self->get_alu_list_cycle();
       my $rst = $self->run_alu_check();
       if( $rst==-1 ){ 
                       print "out off hardware constrains, we would inc the hardware number by $time...\n";
                       $self->updt_pe_number_constrain();
                       $time++;
        }else{
          last; 
        }    
    }

 $self->run_updt_integer_linear_programming_alg_ASAP();
 $self->run_integer_linear_programming_alg_CSTEP();

 $self->run_updt_distrib_list();
}

sub report {
  my ($self) = (@_); 

    print Dumper($self->{cons2DFG}->{cstep_list});
    print Dumper($self->{cyc_list});                       
    print Dumper($self->{distrib_list});
}

1;
