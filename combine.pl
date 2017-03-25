use strict;
use File::Basename;

my @array;
my $header = ",";

sub test()
{
	my $indexFile = $_[0];
	my $pathFile = $_[1];

	my $nameFile = basename($pathFile);
	$nameFile =~ s/\.csv//;
	$header .= $nameFile . ",";

	open(my $fhFrom, '<', $pathFile) or die("error: $!");
	my $i = 0;
	while (<$fhFrom>)
	{
		chomp($_);
		my @line = split(",", $_);
		if (0 == $indexFile)
		{
			$array[$i++] .= $line[0] . "," . $line[1] . ",";
		}
		else
		{
			$array[$i++] .= $line[1] . ",";
		}
	}
}

#-- entry point --#

my $index = 0;
my $numArg = $#ARGV + 1;
my $optDir = 0;
my $argDir = "";

while ($index < $numArg)
{
	if ("--dir" eq $ARGV[$index])
	{
		$argDir = $ARGV[$index + 1];
		$optDir = 1;
		$index += 1;
	}
	else
	{
		# do nothing
	}
	$index++;
}

$index = 0;
if (0 != $optDir)
{
	my @listFile = sort(glob($argDir . "/*.csv"));
	foreach my $file (@listFile)
	{
		&test($index, $listFile[$index]);
		$index++;
	}
}
else
{
	while ($index < $numArg)
	{
		&test($index, $ARGV[$index]);
		$index++;
	}
}

print("$header\n");
foreach my $var (@array)
{
	print("$var\n");
}
