#!usr/bin/perl
#use strict;
#use GDBM_File;
#the module prunes multiple feature structures

sub Disambiguate_Feature
{
	my $sent = @_[0];
	my $guessmorph_home = @_[1];
		
	my @all_leaves = &get_leaves($sent);
	foreach $node (@all_leaves)
	{
	 	$pos = &get_field($node, 3,$sent);
	        $lex = &get_field($node, 2,$sent);
		$node = $node - $delete;        #always update the node position (cases when some nodes are deleted)
		$pos = &get_field($node, 3,$sent);
	        $lex = &get_field($node, 2,$sent);
		if($pos eq "NN" or $pos eq "NNP" or $pos eq "NST" or $pos eq "XC")
		{
			my $feature = &get_field($node, 4,$sent);
			my $array_fs = &read_FS($feature,$sent);
			my $num_fs = &get_num_fs($array_fs,$sent);
			my $pos_next_node = &get_field($node+1, 3,$sent);
			if ($num_fs > 1)
			{
				
				@cas_values = &get_values("cas", $array_fs,$sent);
				$fs = &get_fs_reference($array_fs,1,$sent);
#	$string=&make_string_2($fs,$sent);
				$string_o="";
			        $string_d="";	
				for(my $i = $#cas_values; $i >= 0; $i--)
				{
					if($cas_values[$i] eq 'd')
					{
						 $fs = &get_fs_reference($array_fs,$i,$sent);
						 if ($string_d eq "")
						 {
							 $string_d = $string_d . &make_string_2($fs,$sent);
						 }
						 else
						 {
						 	$string_d=$string_d . "|" . &make_string_2($fs,$sent);
						 }
						 
					}
					if($cas_values[$i] eq 'o')
					{
						 $fs = &get_fs_reference($array_fs,$i,$sent);
						 if ($string_o eq "")
						 {
							 $string_o = $string_o . &make_string_2($fs,$sent);
						 }
						 else
						 {
						 	$string_o=$string_o . "|" . &make_string_2($fs,$sent);
						 }
					}
				}

				if($pos_next_node eq "PSP"){
					&modify_field($node,4,$string_o,$sent);
				}
				else{
					&modify_field($node,4,$string_d,$sent);
				}


			}

			


		}
		
	}

}
1;
