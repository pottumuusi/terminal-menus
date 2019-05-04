unit module NewModule; # TODO rename me

use Util;
use File::Temp;	# Installed by running "zef install File::Temp"
		# TODO add File::Temp installing as a build dependency

# TODO Use g_debug.print for all debug prints

# TODO possibly rename me when module renamed
class Dialog {
	my constant DEBUG_ON = 1;

	my constant DIALOG_OK = 0;
	my constant DIALOG_CANCEL = 1;
	my constant DIALOG_HELP = 2;
	my constant DIALOG_EXTRA = 3;
	my constant DIALOG_ITEM_HELP = 4;
	my constant DIALOG_ESC = 255;
	my constant DIALOG_ERR = 256;

	has $!g_debug = Nil;

	has $!init_done = 0;
	has $!fh_comm;
	has $!dialog_comm_file;	# TODO consider having "name" as part of the
				# name of this variable.

	# Try to have constructor with no effect. Did not work.
	# It seems that accessors to member variables are automatically
	# generated.
	# method new {}

	method init() {
		$!g_debug = Util::Debug.new();

		($!fh_comm, $!dialog_comm_file) = tempfile;
		$!g_debug.print(DEBUG_ON,
				"dialog_comm_file is: $!dialog_comm_file");

		$!init_done = 1;

		return 0;
	}

	method teardown() {
		if (1 != $!init_done) {
			say("Teardown called when init not done");
			return 0;
		}

		# File::Temp closes the file handle automatically? At least
		# temp file unlink is done automatically. File handle is closed
		# on DESTROY (what is it?).

		$!init_done = 0;

		return 0;
	}

	method !init_ok() {
		# TODO Add necessary checks

		if (! $!init_done) {
			say(&?ROUTINE.name ~ ": Init not done");
			return 0;
		}

		if (! defined $!dialog_comm_file) {
			say(&?ROUTINE.name ~ ": No file for communicating with dialog");
			return 0;
		}

		return 1;
	}

	method input_box($height, $width) {
		say("input_box start");

		my $ret = DIALOG_ERR;
		my $result;
		my $dialog_cmd;

		if (! self!init_ok()) {
			print("Dialog not initialized properly\n");
			return -1;
		}

		# Construct dialog command which passes user input via temp file.
		$dialog_cmd = "dialog ";
		$dialog_cmd ~= "--title 'INPUT BOX' ";
		$dialog_cmd ~= "--clear ";
		$dialog_cmd ~= "--inputbox 'Hello' $height $width ";
		$dialog_cmd ~= "2> $!dialog_comm_file";

		say("running command $dialog_cmd");
		$ret = shell("$dialog_cmd");

		$result = "";
		for $!fh_comm.IO.lines -> $row {
			$row.chomp;
			$result ~= $row;
		}

		return $result;
	}
};
