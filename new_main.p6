#!$HOME/my/tools/perl/rakudo/install/bin/perl6

# need NewModule; # How does need keyword work?

use File::Temp;	# Installed by running "zef install File::Temp"
		# TODO add File::Temp installing as a build dependency
use NewModule;

constant $DIALOG_OK = 0;
constant $TEST = "A test";

my $dialog = NewModule::Dialog.new();

$dialog.tryme("passed to tryme");

say("DIALOG_OK is: $DIALOG_OK");
say("TEST is: $TEST");

my $fh;
my $filename;
($fh, $filename) = tempfile;
say("filename is: $filename");

$dialog.init();
$dialog.input_box(16, 51);
$dialog.teardown();

# use Dialog;
# 
# my $dialog_result = undef;
# 
# Dialog::init();
# 
# $dialog_result = Dialog::input_box(16, 51);
# print("dialog_result is: $dialog_result\n");
# 
# Dialog::teardown();
