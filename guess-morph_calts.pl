while($line=<>) {
chomp($line);
		($id,$token,$pos,$fs)=split(/\t+/,$line);
		chomp($fs);
		if($fs=~/\|/)
		{
		$fs=~s/<fs af=\'|\'>//g;
		if(($fs) && ($fs=~/\|/))
		{
	($fs1,$fs2,$fs3,$fs4)=split(/\|/,$fs);
	($root1,$lcat1,$g1,$n1,$p1,$c1,$tam1,$suff1)=split(/,/,$fs1);
	($root2,$lcat2,$g2,$n2,$p2,$c2,$tam2,$suff2)=split(/,/,$fs2);
		if($root1 eq "hE")
		{
			if(($p1 eq "1" or $p1 eq "2")&&($p2 eq "3"))
			{
				$fs1="";
			}
		}
		}
		$fst1= "$id\t$token\t$pos\t<fs af='$fs2>";
		$fst2= "$id\t$token\t$pos\t<fs af='$fs1'>|<fs af='$fs2>";
		$fst3= "$id\t$token\t$pos\t<fs af='$fs1'>|<fs af='$fs2>|<fs af='$fs3'>";
		$fst4= "$id\t$token\t$pos\t<fs af='$fs1'>|<fs af='$fs2>|<fs af='$fs3'>|<fs af='$fs4'>";
		if($fs1 eq "")
		{
			print "$fst1\n";
		}
		else {
			if($fs4 ne ""){
				$fst4=~s/>>|>'>/>/g;
				print "$fst4\n";
			}
			elsif($fs3 ne ""){
				$fst3=~s/>>|>'>/>/g;
				print "$fst3\n";
			}
			else{
				print "$fst2\n";
			}
		}
		}
		else {
		print "$id\t$token\t$pos\t$fs\n";
		}
		

}
