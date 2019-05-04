#!$HOME/my/tools/perl/rakudo/install/bin/perl6

# TODO rename this file

# need NewModule; # How does need keyword work?

use v6;
use Util;
use NewModule;
use File::Temp;	# Installed by running "zef install File::Temp"
		# TODO add File::Temp installing as a build dependency

# TODO Use g_debug.print for all debug prints

sub main() {
	# TODO remove test constants
	constant $DIALOG_OK = 0;
	constant $TEST = "A test";

	my $fh;
	my $dialog;
	my $filename;
	my $global_debug;

	$dialog = NewModule::Dialog.new();
	$global_debug = Util::Debug.new(); # TODO rename to g_debug

	if ($global_debug.is_on()) {
		say("DIALOG_OK is: $DIALOG_OK");
		say("TEST is: $TEST");
	}

	($fh, $filename) = tempfile;
	if ($global_debug.is_on()) {
		say("filename is: $filename");
	}

	$dialog.init();
	my $user_insertion = $dialog.input_box(16, 51);
	$dialog.teardown();

	if ($global_debug.is_on()) {
		say("user_insertion: is $user_insertion");
	}
}

main();
