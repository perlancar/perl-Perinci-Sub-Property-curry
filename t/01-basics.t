#!perl

use 5.010;
use strict;
use warnings;

use Perinci::Sub::Wrapper qw(wrap_sub);
use Test::More 0.96;
use Test::Perinci::Sub::Wrapper qw(test_wrap);
use Perinci::Sub::property::curry;

my ($sub, $meta);

$sub = sub {[200,"OK",{@_}]};
$meta = {v=>1.1, args=>{a=>{}, b=>{}, c=>{}}, curry=>{a=>10}};
test_wrap(
    name        => 'a is curried #1',
    wrap_args   => {sub => $sub, meta => $meta},
    wrap_status => 200,
    call_argsr  => [],
    call_status => 200,
    call_res    => [200, "OK", {a=>10}],
);
test_wrap(
    name        => 'a is curried #2',
    wrap_args   => {sub => $sub, meta => $meta},
    wrap_status => 200,
    call_argsr  => [b=>20, c=>30],
    call_status => 200,
    call_res    => [200, "OK", {a=>10, b=>20, c=>30}],
);
test_wrap(
    name        => 'a cannot be set again',
    wrap_args   => {sub => $sub, meta => $meta},
    wrap_status => 200,
    call_argsr  => [a=>5],
    call_status => 400,
);

done_testing();
