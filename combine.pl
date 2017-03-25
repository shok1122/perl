use strict;
use File::Basename;

my @array;
my $header = ",";

sub test()
{
	my $indexFile = $_[0];
	my $pathFile = $_[1];

	$header .= basename($pathFile) . ",";

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

my $index = 0;
my $numArg = $#ARGV + 1;
while ($index < $numArg)
{
	&test($index, $ARGV[$index]);
	$index++;
}

print("$header\n");
foreach my $var (@array)
{
	print("$var\n");
}
