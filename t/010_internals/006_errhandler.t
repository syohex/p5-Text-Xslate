#!perl -w

use strict;
use Test::More;

use Text::Xslate;

my $warn = '';
my $die  = '';
my $tx = Text::Xslate->new(
    verbose      => 2,
    warn_handler => sub{ $warn = "@_" },
    die_handler  => sub{ $die  = "@_"  },
);

is $tx->render_string(
    'Hello, <:= $lang :> world!',
    { lang => undef }), "Hello,  world!", "error handler" for 1 .. 2;

like $warn, qr/\b nil \b/xms, 'warnings are produced';
is $die, '';

$warn = '';
$die  = '';

eval {
is $tx->render_string(
    ': include "no/such/path" ',
    { lang => undef }), "Hello,  world!", "error handler" for 1 .. 2;
};

is $warn, '';
like $die, qr{no/such/path}, 'the error handler was called';
like $@,   qr{no/such/path}, 'errors are thrown, anyway';

done_testing;
