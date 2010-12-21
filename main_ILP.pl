#!/usr/bin/perl


use Data::Dumper;
use SysPerl::syntax2DFG;
use SysPerl::constrain2DFG;
use SysPerl::schedule::integer_linear_programming;
#use SysPerl::schedule::force_directed;
use SysPerl::arch::arch2DFG;
use strict;

#===================================
# @step 1 : gen simple DFG graph
# return  : DFG graph
#         : vertex_pre_stack 
#         : vertex_nxt_stack
#===================================
# 
#  y = b0*x0 + b1*x1 + b2*x2 + b3*x3 + b4*x4 + b5*x5;

my $tt = ['y','=','b0','*','x0','+',
                 ,'b1','*','x1','+',
                 ,'b2','*','x2','+',
                 ,'b3','*','x3','+',
                 ,'b4','*','x4','+',
                 ,'b5','*','x5',';'];

my $syn  = SysPerl::syntax2DFG->new();
   $syn->read_text($tt);
   $syn->run_text();
   $syn->free();

#   my $graph = $syn->get_deep_copy_graph();  
 
# remove tmp_reg && feedback assign 
# ex : d=c;
#      e=d+1;
    $syn->run_updt_DFG();

# get all graph && DFG flow 2 schedule 
my $DFG = $syn->get_deep_copy_DFG();

# dump graph as dot file    
  $syn->dump_DFG_graphviz_file('syn2DFG.dot');
  $syn->free();

#=====================================
# @step2. : 
# flow 1  : insert time weighted constrain 2 simple DFG graph and
#           gen Cstep graph(cycle step grpah)
# flow 2  : insert average power weighted constrain 2 Cstep and gen the force vale 
#           @ force directed scheduling
# return :  cycle graph
#=====================================
# set unit time wait delay
my $constrain_time_weighted_vertices = { 
     '+'  => 1,   # add delay 1 unit s
     '-'  => 1,   # sub delay 1 unit s
     '*'  => 1,   # mul
     '/'  => 1,   # div
     '%'  => 1,   # rem
     '>>' => 1,   # rsht
     '<<' => 1,   # lsht
};

#set unit average power consumed
my $constrain_power_weighted_vertices = {
     '+'  => 1.54,
     '-'  => 1,
     '*'  => 6.7,
     '/'  => 1,
     '%'  => 1,
     '>>' => 1,
     '<<' => 1,
};

my $con = SysPerl::constrain2DFG->new();
   $con->set_deep_DFG($DFG);

   $con->set_constrain_time_weighted($constrain_time_weighted_vertices);
   $con->set_constrain_power_weighted($constrain_power_weighted_vertices);

   $con->run_constrain_time_weighted_DFG();
   $con->run_constrain_NewDFG();
 
#   $con->dump_ALUDFG_graphviz_file('alu.dot');
   $con->dump_NewDFG_graphviz_file('con.dot');

#=============================
# schedule && cluster
#=============================
#my $sch = SysPerl::schedule::force_directed->new();
#   $sch->set_deep_cons2DFG($con);
#
#   $sch->run_forece_directed_scheduling();
#   $sch->report();

my $pe_number_constrain = {
     '+'  => 2,   # add numbers constrain for each time step
     '-'  => 2,   # sub 
     '*'  => 2,   # mul
     '/'  => 2,   # div
     '%'  => 2,   # rem
     '>>' => 2,   # rsht
     '<<' => 2,   # lsht
};

my $sch = SysPerl::schedule::integer_linear_programming->new();
   $sch->set_deep_cons2DFG($con);

   $sch->set_pe_number_constrain($pe_number_constrain);
   $sch->run_integer_linear_programming_scheduling();
   $sch->report();

#=============================
# explore hardware
#=============================  
my $arc = SysPerl::arch::arch2DFG->new();
   $arc->set_deep_sched2arch($sch);
   $arc->run_ALU_cluster();
   $arc->run_explore_SystemC();
