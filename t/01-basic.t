#!perl -T

use strict;
use warnings FATAL => 'all';


package My::Test;

use Moo;
with 'Role::Markup::XML';

package main;

use Test::More;

plan tests => 2;


my $obj = My::Test->new;

isa_ok($obj, 'My::Test', 'object checks out');

ok($obj->does('Role::Markup::XML'), 'object does role');
