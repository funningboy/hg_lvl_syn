use MyParser;
use Data::Dumper; 
#use CDFG;
#use Queue;
#use BlockIfGraph;
#use BlockForGraph;
#use DFG2Graph;

#use PortGraph;
 
  my $parser = MyParser->new();
  $parser->parse_file ("FSM.v");
#  $parser->alu_report();
#  $parser->report();

#use PortGraph;
#my $pt = PortGraph->new();
#   $pt->set_in_list('ina','32');
#   $pt->set_in_list('inb','32');
#   $pt->clr_in_list();
#   $pt->set_in_list('inc','32');
#print Dumper($pt->get_in_list);
#my $qu = Queue->new();
#print $qu->is_par_queue_empty()."\n";
#   $qu->push_par_queue('[3:0]');
#   $qu->push_par_queue('=');
#print $qu->is_par_queue_empty()."\n";
#   $qu->push_par_queue('ina');
#my $str = $qu->pop_all_par_queue();
#   print $str."\n";
#
#my $cfg = CDFG->new();
#   $cfg->set_vertex('a',0);
#   $cfg->set_vertex('b',0);
#   $cfg->set_vertex('+',0);
#   $cfg->set_vertex('c',0);
#
#   $cfg->set_edge('a','+',0);
#   $cfg->set_edge('b','+',0);
#   $cfg->set_edge('+','c',0);
#
#   $cfg->set_path('a','+');
#   $cfg->dump_CDFG();
#
#
#my $if_blk = BlockIfGraph->new();
#=========================================
#   if( a==1 ) begin ... 
#=========================================
#   push (@{$if_cond{Vertex}}, { vex => 'a',
#                                dly => '0',});
#   push (@{$if_cond{Vertex}}, { vex => '==',
#                                dly => '0',});
#   push (@{$if_cond{Vertex}}, { vex => '1',
#                                dly => '0',});
#
#   push (@{$if_cond{Edge}}, { src => 'a',
#                              dst => '==',
#                              dly => '0', });
#
#   push (@{$if_cond{Edge}}, { src => '==',
#                              dst => '1',
#                              dly => '0', });
#
#
#   $if_blk->set_if_cond_graph(\%if_cond);
#
##=====================================
##  if->body c=a+b;
##=====================================
#   push (@{$if_body{Vertex}}, { vex => 'a',
#                                dly => '0',});
#   push (@{$if_body{Vertex}}, { vex => '+',
#                                dly => '0',});
#   push (@{$if_body{Vertex}}, { vex => 'b',
#                                dly => '0',});
#   push (@{$if_body{Vertex}}, { vex => '=',
#                                dly => '0'});
#   push (@{$if_body{Vertex}}, { vex => 'c',
#                                dly => '0'});
#
#   push (@{$if_body{Edge}}, { src => 'a',
#                              dst => '+', 
#                              dly => '0',});
#   push (@{$if_body{Edge}}, { src => 'b',
#                              dst => '+', 
#                              dly => '0',});
#   push (@{$if_body{Edge}}, { src => '+', 
#                              dst => '=',
#                              dly => '0',});
#   push (@{$if_body{Edge}}, { src => '=', 
#                              dst => 'c',
#                              dly => '0',});
# 
#   $if_blk->set_if_body_graph(\%if_body);
#
#   @{$if_end->{Vertex}} = [];
#   @{$if_end->{Edge}}   = [];
#   $if_blk->set_if_end_graph(\%if_end);
#   
#   $if_blk->del_if_cond_graph();
#   $if_blk->del_if_end_graph();
#   $if_blk->dump_if_graph();
#
#
#my $for_blk = BlockForGraph->new();
#============================================
# for( init ; cond ; update) 
# for( i=0; i<9; i++ ) 
#============================================



#my $sys = sysperl->new();
#my $vei = sysperl->Verilog->read('xxx.v');
#          $vei->check_net_list();
#          $vei->check_port();
#          $vei->check_cell();
#          $vei->check_pin();
# 
#my $syc = sysperl->SystemC->read('xxx.cc');
#          $sys->check_net_list();
#
#
#################################################
#
#my $sys = sysperl->new();
#my $mod = $sys->set_module_name('test');
#          $mod->set_pin_list({ ina => [31:0],
#                               inb => [31:0],
#                               otc => [31:0],
#                               clk => [ 0:0],
#                               rst => [ 0:0],});
#
#my $blk1 = $mod->set_always_block();
#           $blk1->set_senstive(['clk.pos']);
#           $blk1->set_method(' if()');
#
#
#my $blk2 = $mod->set_always_block();
#           $blk2->set_senstive()


#my $dfg = DFG2Graph->new();
#   $dfg->run_text();
#   $dfg->dump_graph();
#   $dfg->dump_graphviz();
#print Dumper($dfg);
#
