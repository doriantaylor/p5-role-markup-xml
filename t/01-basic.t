#!perl -T

use strict;
use warnings FATAL => 'all';


package My::Test;

use Moo;
with 'Role::Markup::XML';

package main;

use Test::More;

plan tests => 5;


my $obj = My::Test->new;

isa_ok($obj, 'My::Test', 'object checks out');

ok($obj->does('Role::Markup::XML'), 'object does role');

ok('html'      =~ &Role::Markup::XML::QNAME_RE, 'bare matches qname');
ok('html:html' =~ &Role::Markup::XML::QNAME_RE, 'ns matches qname');

my $doc = $obj->_DOC;

isa_ok($doc, 'XML::LibXML::Document');

my $html = $obj->_XML(
    doc  => $doc,
    spec => [{ -pi => 'test'}, { -doctype => 'html' }, { -comment => 'wut' },
             { -name => 'html', xmlns => 'http://www.w3.org/1999/xhtml'}],
);

#diag($doc->toString(1));

my $title = $obj->_XML(
    parent => $html,
    spec => { -name => 'head',
              -content => { -name => 'title', -content => 'hi' } },
);

#diag($doc->toString(1));

$obj->_XML(
    next => $title->parentNode,
    #spec => { -name => 'svg', xmlns => 'http://www.w3.org/2000/svg' },
    spec => { -comment => 'lol' },
);

#diag($doc->toString(1));

#diag(&Role::Markup::XML::QNAME_RE);
