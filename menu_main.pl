#!/usr/bin/perl

use warnings;
use strict;

use File::Temp;

use Dialog;

my $dialog_result = undef;

Dialog::init();

$dialog_result = Dialog::input_box(16, 51);
print("dialog_result is: $dialog_result\n");

Dialog::teardown();
