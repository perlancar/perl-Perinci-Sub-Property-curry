package Perinci::Sub::Property::curry;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
#use Log::Any '$log';

use Data::Dmp;
use Perinci::Sub::PropertyUtil qw(declare_property);

declare_property(
    name => 'curry',
    type => 'function',
    schema => ['hash*'],
    wrapper => {
        meta => {
            v       => 2,
            prio    => 10,
            convert => 1,
        },
        handler => sub {
            my ($self, %args) = @_;
            my $v    = $args{new} // $args{value} // {};
            my $meta = $args{meta};

            $self->select_section('before_call_arg_validation');
            for my $an (keys %$v) {
                my $av = $v->{$an};
                $self->_errif(400, "\"Argument $an has been set by curry\"",
                              'exists($args{\''.$an.'\'})');
                $self->push_lines(
                    '$args{\''.$an.'\'} = '.dmp($av).';');
            }
        },
    },
);

1;
# ABSTRACT: Set arguments for function

=head1 SYNOPSIS

 # in function metadata
 args  => {a=>{}, b=>{}, c=>{}},
 curry => {a=>10},

 # when calling function
 f();             # equivalent to f(a=>10)
 f(b=>20, c=>30); # equivalent to f(a=>10, b=>20, c=>30)
 f(a=>5, b=>20);  # error, a has been set by curry


=head1 DESCRIPTION

This property sets arguments for function.


=head1 SEE ALSO

L<Perinci>

=cut
