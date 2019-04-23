package Dialog;

use warnings;
use strict;

use constant DEBUG => 1;

use constant DIALOG_OK => 0;
use constant DIALOG_CANCEL => 1;
use constant DIALOG_HELP => 2;
use constant DIALOG_EXTRA => 3;
use constant DIALOG_ITEM_HELP => 4;
use constant DIALOG_ESC => 255;
use constant DIALOG_ERR => 256;

our $init_done = 0;
our $fh_comm = undef;
our $dialog_comm_file = undef;

sub init {
	$fh_comm = File::Temp->new();
	$dialog_comm_file = $fh_comm->filename;

	# TODO check that dialog_comm_file exists(?)

	if (DEBUG) {
		print("dialog_comm_file is: $dialog_comm_file\n");
	}

	$init_done = 1;

	return 0;
}

sub teardown {
	if (1 != $init_done) {
		print("Teardown called when init not done\n");
		return 0;
	}

	if (defined $fh_comm) {
		close($fh_comm); # TODO handle close failure(?)
	}

	$init_done = 0;

	return 0;
}

sub init_ok {
	# TODO Add necessary checks

	if (! defined $dialog_comm_file) {
		return 0;
	}

	return 1;
}

sub input_box {
	# TODO Give height and width as named parameters
	my $height = $_[0];
	my $width = $_[1];

	my $ret = DIALOG_ERR;
	my $result = undef;
	my $dialog_cmd = undef;

	if (!init_ok()) {
		print("Dialog not initialized properly\n");
		return -1;
	}

	# Construct dialog command which passes user input via temp file.
	$dialog_cmd = "dialog ";
	$dialog_cmd = $dialog_cmd . "--title 'INPUT BOX' ";
	$dialog_cmd = $dialog_cmd . "--clear ";
	$dialog_cmd = $dialog_cmd . "--inputbox 'Hello' $height $width ";
	$dialog_cmd = $dialog_cmd . "2> $dialog_comm_file";
	$ret = system("$dialog_cmd");

	$result = "";
	while (my $row = <$fh_comm>) {
		chomp $row;
		$result = $result . $row;
	}

	return $result;
}

1;
