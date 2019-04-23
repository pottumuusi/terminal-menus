#!/usr/bin/perl

use warnings;
use strict;

use File::Temp;

use Dialog;

my $dialog_comm_pipe = "comm_pipe";
my $dialog_comm_pipe_permissions = 0666;
my $ret;
my $tempfilename;
my $fh_comm = File::Temp->new();
my $dialog_comm_file = $fh_comm->filename;

use constant DIALOG_OK => 0;
use constant DIALOG_CANCEL => 1;
use constant DIALOG_HELP => 2;
use constant DIALOG_EXTRA => 3;
use constant DIALOG_ITEM_HELP => 4;
use constant DIALOG_ESC => 255;

Dialog::test();

print "dialog_comm_file is: $dialog_comm_file\n";

print("Showing dialog\n");
$ret = system("dialog --title 'INPUT BOX' --clear --inputbox 'Hello' 16 51 2> $dialog_comm_file");
print("\nresult of dialog command is: $ret\n");

print("Reading from comm file 2\n");
while (my $row = <$fh_comm>) {
	chomp $row;
	print($row);
}
print("\nDone reading from comm file 2\n");

print "dialog_comm_file is: $dialog_comm_file\n";

close($fh_comm);
