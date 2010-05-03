#!perl -w

use strict;
use Test::More;

use t::lib::TTSimple;

is render_file('include.tt', { lang => "Xslate" }),
    "include:\n" . "Hello, Xslate world!\n";

is render_file('include2.tt', { file => "hello.tt", lang => "Xslate" }),
    "include2:\n" . "Hello, Xslate world!\n";

is render_file('include2.tt', { file => "include.tt", lang => "Xslate" }),
    "include2:\n" . "include:\n" . "Hello, Xslate world!\n";

done_testing;