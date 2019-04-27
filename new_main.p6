#!$HOME/my/tools/perl/rakudo/install/bin/perl6

# TODO rename this file

# need NewModule; # How does need keyword work?

use v6;
use File::Temp;	# Installed by running "zef install File::Temp"
		# TODO add File::Temp installing as a build dependency
use NewModule;
use Util;

constant $DIALOG_OK = 0;
constant $TEST = "A test";

# if (Util::Debug.DEBUG()) {
# 	say("Debug is on");
# } else {
# 	say("Debug is off");
# }

my $dialog = NewModule::Dialog.new();

say("DIALOG_OK is: $DIALOG_OK");
say("TEST is: $TEST");

my $fh;
my $filename;
($fh, $filename) = tempfile;
say("filename is: $filename");

$dialog.init();
my $user_insertion = $dialog.input_box(16, 51);
$dialog.teardown();

say("user_insertion: is $user_insertion");
