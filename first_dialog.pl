#!/usr/bin/perl

use warnings;
use strict;

use File::Temp;

# use POSIX ();
# if (! -e "$dialog_comm_pipe") {
# 	print("Comm pipe does not exist. Creating...\n");
# 	POSIX::mkfifo("$dialog_comm_pipe", $dialog_comm_pipe_permissions);
# 	print("Done");
# }

# my $dialog_comm_file = "comm.txt";
my $dialog_comm_pipe = "comm_pipe";
my $dialog_comm_pipe_permissions = 0666;
my $ret;

my $DIALOG_OK = 0;
my $DIALOG_CANCEL = 1;
my $DIALOG_HELP = 2;
my $DIALOG_EXTRA = 3;
my $DIALOG_ITEM_HELP = 4;
my $DIALOG_ESC = 255;

# my $stored_fileno = fileno(2);
# print("Hello\n");
# print("stored_fileno is: $stored_fileno\n");

# $dialog_comm_file = qx/mktemp/;
# print("dialog_comm_file is: $dialog_comm_file");
# qx/chmod go+rw $dialog_comm_file/;
# print("dialog_comm_file is: $dialog_comm_file");

# my $fh_comm;
my $tempfilename;
# ($fh, $tempfilename) = tempfile();
my $fh_comm = File::Temp->new();
my $dialog_comm_file = $fh_comm->filename;
# print("fh filename is: $fname");

print "dialog_comm_file is: $dialog_comm_file\n";

# $dialog_comm_file = "testi_1.txt";

# print("Opening read fh\n");
# open(my $fh_comm, '<', "$dialog_comm_pipe") or die "Could not open comm fh";
# print("Done opening read fh\n");

# my $testvar = "test";
# open(my $fh_comm, ">", "$dialog_comm_file") or die "Could not open comm fh $dialog_comm_file reason: $!";
# my $err = open(my $fh_comm, '<', "$dialog_comm_file");
# open(my $fh_comm, "<", "tmp\.ynwjxJHuMg") or die "Could not open comm fh tmp\.ynwjxJHuMg";

# print("Err is: $err");

# print $fh_comm "Hello world\n";

# qx/echo "second write" >> $dialog_comm_file/;

# close($fh_comm);
# open(my $fh_comm, "<", "$dialog_comm_file") or die "Could not open comm fh $dialog_comm_file reason: $!";

print("Reading from comm file\n");
while (my $row = <$fh_comm>) {
	chomp $row;
	print($row);
}
print("\nDone reading from comm file\n");

# die "Stopping early";

print("Showing dialog\n");
# $ret = qx/dialog --title "INPUT BOX" --clear --inputbox "Hello" 16 51/;
# $ret = system("dialog --title 'INPUT BOX' --clear --inputbox 'Hello' 16 51 2> $dialog_comm_pipe");
# $ret = system("dialog --title 'INPUT BOX' --clear --inputbox 'Hello' 16 51");
$ret = system("dialog --title 'INPUT BOX' --clear --inputbox 'Hello' 16 51 2> $dialog_comm_file");
print("\nresult of dialog command is: $ret\n");

print("Reading from comm file 2\n");
while (my $row = <$fh_comm>) {
	chomp $row;
	print($row);
}
print("\nDone reading from comm file 2\n");

# print("Reading from pipe\n");
# while (my $row = <$fh_comm>) {
# 	chomp $row;
# 	print($row);
# }

# print("Reading from comm file\n");
# while (my $row = <$fh_comm>) {
# 	chomp $row;
# 	print($row);
# }

print "dialog_comm_file is: $dialog_comm_file\n";

close($fh_comm);

# dialog --title "INPUT BOX" \
#   --clear  \
#   --inputbox "Hi, this is an input dialog box. You can use \n
# this to ask questions that require the user \n
# to input a string as the answer. You can \n
# input strings of length longer than the \n
# width of the input box, in that case, the \n
# input field will be automatically scrolled. \n
# You can use BACKSPACE to correct errors. \n\n
# Try entering your name below:" 16 51 2>&1 1>&3)
