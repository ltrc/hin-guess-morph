#!/usr/bin/perl
use Dir::Self;
use lib __DIR__ . "/src";
use lib __DIR__ . "/API";
use Getopt::Long;
use feature_filter;
use shakti_tree_api;
use DisambiguateFeature;

GetOptions("help!"=>\$help,"input=s"=>\$input,"output=s",\$output);
print "Unprocessed by Getopt::Long\n" if $ARGV[0];
foreach (@ARGV) {
	print "$_\n";
	exit(0);
}

if($help eq 1)
{
	print "Guess Morph  - Guess Morph Version 1.2\n(14th July 2007 last modified on 9th August 2009)\n\n";
	print "usage : ./guessmorph.pl [-i inputfile|--input=\"input_file\"] [-o outputfile|--output=\"output_file\"] \n";
	print "\tIf the output file is not mentioned then the output will be printed to STDOUT\n";
	exit(0);
}

if ($input eq "")
{
  $input="/dev/stdin";
}

read_story($input);

$numBody = get_bodycount();
#print "$numBody";
for(my($bodyNum)=1;$bodyNum<=$numBody;$bodyNum++)
{

	$body = get_body($bodyNum,$body);

# Count the number of Paragraphs in the story
	my($numPara) = get_paracount($body);

#print STDERR "Paras : $numPara\n";

# Iterate through paragraphs in the story
	for(my($i)=1;$i<=$numPara;$i++)
	{

		my($para);
		# Read Paragraph
		$para = get_para($i);


		# Count the number of sentences in this paragraph
		my($numSent) = get_sentcount($para);
		# Iterate through sentences in the paragraph
		for(my($j)=1;$j<=$numSent;$j++)
		{

			# Read the sentence which is in SSF format
			my($sent) = get_sent($para,$j);
                        #print "YES";
			#Copy Vibhakti Info
      		        #ComputeVibhakti($sent,$vibh_home);

			#Compute TAM
			Disambiguate_Feature($sent);
		}
	}
}

if($output eq "" )
{
	printstory();
}

else
{
	printstory_file("$output");
}
