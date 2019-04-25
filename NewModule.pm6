# Module

unit module NewModule; # TODO rename me

use File::Temp;	# Installed by running "zef install File::Temp"
		# TODO add File::Temp installing as a build dependency

# TODO possibly rename me when module renamed
class Dialog {
	my constant DEBUG = 1;

	my constant DIALOG_OK = 0;
	my constant DIALOG_CANCEL = 1;
	my constant DIALOG_HELP = 2;
	my constant DIALOG_EXTRA = 3;
	my constant DIALOG_ITEM_HELP = 4;
	my constant DIALOG_ESC = 255;
	my constant DIALOG_ERR = 256;

	has $!init_done = 0;
	has $!fh_comm;
	has $!dialog_comm_file;	# TODO consider having "name" as part of the
				# name of this variable.

	# Try to have constructor with no effect. Did not work.
	# It seems that accessors to member variables are automatically
	# generated.
	# method new {}

	method init() {
		# $!fh_comm = File::Temp->new();
		# $!dialog_comm_file = $fh_comm->filename;
		($!fh_comm, $!dialog_comm_file) = tempfile;

		# TODO check that dialog_comm_file exists(?)

		if (DEBUG) {
			say("dialog_comm_file is: $!dialog_comm_file");
		}

		$!init_done = 1;

		return 0;
	}

	method teardown() {
		if (1 != $!init_done) {
			say("Teardown called when init not done");
			return 0;
		}

		# File::Temp closes the file handle automatically? At least
		# temp file unlink is done automatically.
		#
		# if (defined $!fh_comm) {
		# 	say("closing fh_comm");
		# 	close($!fh_comm); # TODO handle close failure(?)
		# 	say("done closing fh_comm");
		# }

		$!init_done = 0;

		return 0;
	}

	method !init_ok() {
		# TODO Add necessary checks

		if (! defined $!dialog_comm_file) {
			return 0;
		}

		return 1;
	}

	method input_box($height, $width) {
		say("input_box start");

		# TODO Give height and width as named parameters
		# my $height = $_[0];
		# my $width = $_[1];

		my $ret = DIALOG_ERR;
		my $result;
		my $dialog_cmd;

		# TODO take into use
		#
		# if (!init_ok()) {
		# 	print("Dialog not initialized properly\n");
		# 	return -1;
		# }

		# Construct dialog command which passes user input via temp file.
		# $dialog_cmd = "dialog ";
		# $dialog_cmd ,= "--title 'INPUT BOX' ";
		# $dialog_cmd ,= "--clear ";
		# $dialog_cmd ,= "--inputbox 'Hello' $height $width ";
		# $dialog_cmd ,= "2> $!dialog_comm_file";

		$dialog_cmd = "dialog --title 'INPUT BOX' --clear --inputbox 'Hello' $height $width 2> $!dialog_comm_file";
		say("running command $dialog_cmd");
		$ret = shell("$dialog_cmd");
		# $ret = system("$dialog_cmd");

		$result = "";
		while (my $row = <$!fh_comm>) {
			chomp $row;
			$result ,= $row;
		}

		return $result;
	}

	# TODO deleteme
	method tryme($par1) {
		say("I have been tried :O ; par1 is: $par1");
		say("init_done is: $!init_done");
		# say("DEBUG is: DEBUG");
	}
};