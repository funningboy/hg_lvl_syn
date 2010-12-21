package MyParser;
use Verilog::Parser;
use Verilog::Netlist;
use Data::Dumper;
use Queue; 
use strict;
#my @ISA = qw(Verilog::Parser);


sub init_id {

}

sub inc_module_id {
    
}

sub inc_block_id {

}






# parse, parse_file, etc are inherited from Verilog::Parser
sub new {
      my $class = shift;
      #print "Class $class\n";
      my $self = $class->SUPER::new();
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

  sub check {
      my $self = shift;

      my $seq   = $self->{seq};
      my $level = $self->{level};       
     
 
  }

  sub operator {
      my $self = shift;
      my $token = shift;
      
      my $seq   = $self->{seq};
      my $level = $self->{level};       
       
         if( $token eq '@' && $self->{tag} eq 'always' ){ }
      elsif( $token eq '(' && $self->{tag} eq 'always' ){ $self->{_alw_grap_lvl}++; }
      elsif( $token eq ')' && $self->{tag} eq 'always' ){ $self->{_alw_grap_lvl}--; }
#        if( $token eq '+' ){ ($self->{tag} eq 'begin' )? $self->{aseq}{ADD}{$seq}{$level}++:0; }
#     elsif( $token eq '-' ){ ($self->{tag} eq 'begin' )? $self->{aseq}{SUB}{$seq}{$level}++:0; }
#     elsif( $token eq '*' ){ ($self->{tag} eq 'begin' )? $self->{aseq}{MUL}{$seq}{$level}++:0; }
#     elsif( $token eq '/' ){ ($self->{tag} eq 'begin' )? $self->{aseq}{DIV}{$seq}{$level}++:0; }
#     elsif( $token eq '>>'){ ($self->{tag} eq 'begin' )? $self->{aseq}{RIG}{$seq}{$level}++:0; }
#     elsif( $token eq '<<'){ ($self->{tag} eq 'begin' )? $self->{aseq}{LEF}{$seq}{$level}++:0; }

       $self->{operators}{$token}++;
  }

  sub number {
      my $self = shift;
      my $token = shift;
     
      $self->{numbers}{$token}++;
   }


 sub set_mdl_grap{

 }

  sub symbol {
      my $self = shift;
      my $token = shift;
      
       if( $self->{tag} eq 'always' && $self->{sen} eq 'pos' ){ }
    elsif( $self->{tag} eq 'always' && $self->{sen} eq 'neg' ){ }
    elsif( $self->{tag} eq 'always'){}
    elsif( $self->{tag} eq 'module' ){   }
        
      $self->{symbols}{$token}++;
  }


  sub error {
      my $self  = shift;
      my $token = shift;
      printf( "Parser Error please check the begin,end conditions had already exists in your code\n");
     # report($self);
      exit;
  }

#===========================================================
# KeyWord define from Verilog::Parser::keyword
#===========================================================
   sub keyword {
      my $self  = shift;
      my $token = shift;
 
        if($token eq 'endmodule'){  $self->{tag} = 'endmodule'; $self->{mdl_grap_id}++; } 
     elsif($token eq 'module'   ){  $self->{tag} = 'module';                    }
     elsif($token eq 'always'   ){  $self->{tag} = 'always';    $self->{blk_grap_id}++; }
       elsif($token eq 'posedge' && $self->{tag} eq 'always'){  $self->{sen} = 'pos'; }
       elsif($token eq 'negedge' && $self->{tag} eq 'always'){  $self->{sen} = 'neg'; } 
       elsif($token eq 'and'     && $self->{tag} eq 'always'){  $self->{sen} = 'and'; }
       elsif($token eq 'or'      && $self->{tag} eq 'always'){  $self->{sen} = 'or' ; }
     elsif($token eq 'assign'   ){  $self->{tag} = 'assign';                                       }
     elsif($token eq 'else'     ){  $self->{tag} = 'else';                                         }
     elsif($token eq 'if'       ){  $self->{tag} = 'if';                                           }
     elsif($token eq 'end'      ){  $self->{tag} = 'end';       }
     elsif($token eq 'begin'    ){   } 
     elsif($token eq 'parameter'){ $self->{tag} = 'parameter';                                     }
      else {}                                     

     $self->{keywords}{$token}++;
  }

   sub string {
      my $self = shift;
      my $token = shift;
     
     $self->{strings}{$token}++;
 }

 
  sub report {
      my $self = shift;
      
      printf("symbols...\n");
      printf Dumper(\%{$self->{symbols}});
  
      printf("operators...\n");
      printf Dumper(\%{$self->{operators}});

      printf("numbers...\n");
      printf Dumper(\%{$self->{numbers}});

      printf("attributes...\n");
      printf Dumper(\%{$self->{attributes}});
     
      printf("keys...\n");
      printf Dumper(\%{$self->{keywords}});

      printf("sysfuncs...\n");
      printf Dumper(\%{$self->{sysfuncs}});

 }


  sub alu_report {
      my $self = shift;

      printf ("ADD-> @ always block -> block level -> counts");
      printf Dumper(\%{$self->{aseq}{MAX_ADD}});

      printf ("SUB-> @ always block -> block level -> counts"); 
      printf Dumper(\%{$self->{aseq}{MAX_SUB}});

      printf ("MUL-> @ always block -> block level -> counts");
      printf Dumper(\%{$self->{aseq}{MAX_MUL}});
  

  }




1;


