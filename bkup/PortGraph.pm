
package PortGraph;
use strict;
use Data::Dumper;

sub new {
    my $class = shift;
    my $self = {_in_list => {},
                _ot_list => {},
                _wr_list => {},
                _rg_list => {},
               };

    bless $self, $class;
    return $self;
}

sub clr_in_list {
    my ($self) = (@_);
    $self->{_in_list} = {};
}

sub get_in_list {
    my ($self) = (@_);
    return $self->{_in_list};
}

sub set_in_list {
    my ($self,$name,$len) = (@_);
       ${$self->{_in_list}}{$name} = $len;
}

sub clr_ot_list {
    my ($self,$name,$len) = (@_);
        $self->{_ot_list} = {};
}

sub get_ot_list {
    my ($self,$name,$len) = (@_);
    return  $self->{_ot_list};
}

sub set_ot_list {
    my ($self,$name,$len) = (@_);
       ${$self->{_ot_list}}{$name} = $len;
}

sub clr_wr_list {
    my ($self,$name,$len) = (@_);
       $self->{_wr_list} = {}; 
}

sub get_wr_list {
    my ($self,$name,$len) = (@_);
    return $self->{_wr_list}; 
}

sub set_wr_list {
    my ($self,$name,$len) = (@_);
       ${$self->{_wr_list}}{$name} = $len;
} 

sub clr_rg_list {
     my ($self,$name,$len) = (@_);
        $self->{_rg_list} = {}; 
}

sub get_rg_list {
    my ($self,$name,$len) = (@_);
    return $self->{_rg_list};
}

sub set_rg_list {
    my ($self,$name,$len) = (@_);
       ${$self->{_rg_list}}{$name} = $len;
}

1;
