#manticora@rofan, 14.04.2009
#plugin autokach
#����: 	�������� ������ ��� ���. ����� ������� ���� (lockMap) 
#		� ��������� �� ��� ����� ���� (mon_control.txt, items_control.txt)
#�������:
#	1. �������� � Microsoft Excel ��� OpenOffice Calc ������������ ���� ������� (kach.xls ��� kach.ods),
#	�� ���������� ���������:
#		1.	[����� �� �������] - ������ ���������� �����
		# 2.	[��� �����] - ����������� ���, ������� � �������� ����� �������� �� ������ �������
		# 3.	[���� �����] - ������������ ���, �� ������� ��� ���� ����� ��� ��������
		# 4.	[�����] - �����, � ������� �������� �������� (saveMap)
		# 5.	[�������] - �������, �� ������� ����� �������� �������� � "��� �����" �� "���� �����" ������������ (lockMap)
		# 6.	[���� �����] - ������ ����� ����� ������� ",", ������� ���� ���� (mconf Mob 2 0 0)
		# 7.	[�� ���� �����] - ������ ����� ����� ������� ",", ������� �� ���� ���� (mconf Mob 0 0 0)
		# 8.	[��� �� �����] - ������ ���� ����� ������� ",", ������� ���� �������� ����� �� ����� (iconf Loot 0 1 0)
		# 9.	[��� �� �������] - ������ ���� ����� ������� ",", ������� ���� ��������� ������� (iconf Loot 0 0 1)
	# ����������� ����� ��������� ��������� ����������:
		# 1. �������� �����, �������, ���� ������ ��������������� ���������������� ���������.
		# 2. [��� �����] <= [���� �����].
		# 3. ������� ������ ���� ��� �����-���������, ������ ������.
		# 4. ������ � ������� ������ ���� ����������� �� ������� [��� �����].
		# 5. ����� ���� ��������� (����������������) ����� � ����������� ������ [��� �����], [���� �����], [�����].
		# ��� ���� ����������� �������� �� ����� � ��� �� ������ �������� ��������� ���� ��� ����.
		# 6. ����� ���� ��������� ���������������� ����� � ����������� ������ [�����]. ��� ���� ����������� 
		# ��� ���������� ���������� ���������� ������ ������ ����, �� �� ���������� � ������ �����.
		# 7. ������ ��������� ���������, ����� � ������� [��� �����] � [���� �����] ��������� ��� ������������,
		# �� [�����]� ��� ���� - ������.
	# 2. ��������� ������� � ������ *.csv (kach.csv). ������� ���������� ������ � ������� ";". 
	# ��� ������ ����� �������:
	# 1;0;11;izlude;moc_fild01;all, Drops, Picky, Poring, Ant's Egg, PecoPeco's Egg;Andre, Deniro, Piere, Baby Desert Wolf, Yellow Plant;all;Jellopy
	# 2;0;11;izlude;prt_fild10;all, Savage Babe, Shining Plant, Thief Bug;Poporing, Red Mushroom, Savage;all;Jellopy
	# 3;12;13;izlude;moc_fild02;all, Ant's Egg, Drops, PecoPeco's Egg, Picky;Green Plant, Peco Peco, Yellow Plant;all;Jellopy
	# 4;12;13;izlude;prt_fild09;all, Condor, PecoPeco's Egg, Picky, Savage Babe;Baby Desert Wolf, Yellow Plant;all;Jellopy
	# 5;14;15;morocc;moc_fild07;all, Drops, PecoPeco's Egg, Picky, Super Picky;Yellow Plant;all;Jellopy
	# 6;14;15;morocc;moc_fild10;all, Ant's Egg, Drops, PecoPeco's Egg, Picky, Super Picky;Yellow Plant, Green Plant, Magnolia;all;Jellopy
	# 7;14;15;morocc;moc_fild12;all, Drops, PecoPeco's Egg, Picky, Super Picky;Yellow Plant;all;Jellopy
	# 8;16;17;morocc;moc_fild11;all, Muka, Shining Plant;Piere, Andre, Deniro, Golem, Hode, Magnolia;all;Jellopy
	# 9;16;17;morocc;moc_fild06;all, Ant's Egg, Condor, Muka;Peco Peco, Yellow Plant, Magnolia;all;Jellopy
	# 10;18;19;izlude;moc_fild04;all, Ant's Egg, Desert Wolf, Metaller, Scorpion;Yellow Plant, Piere, Magnolia, Andre;all;Jellopy
	# 11;18;19;izlude;moc_fild13;all, Anacodaq, Desert Wolf, Drops, Poporing, Sidewinder, Snake;Red Mushroom, Yellow Plant;all;Jellopy
	# 3. ������� kach.csv �������� � openkore\control.
	# 4. ������ autokach.pl �������� � openkore\plugins.
	# 5. ������� ������ ���� kach.mcs � openkore\control.
	# 5. �������� ���� � ��������� (macro savetown, macro conftown) ��������� �� ������ vedro.txt � openkore\control.
	# 6. � openkore\control\macros.txt ���������� kach.mcs: "!include kach.mcs".
	# 7. � openkore\control\macros.txt ���������� vedro.txt: "!include vedro.txt".
	# 8. � openkore\control\config.txt ������� �������� QuestPart (�������� ������ ������� �����������).
	# 9. ��������� OpenKore.
	# 10. ������ ������� ka4 ��� kach.
	# 11. ������������ ���� � ���������: "reload macro".
	# 12. ��������� ��������������� ������: "macro autokach".
	# 13. ������������ ��������������� �����
package autokach;
use Plugins;
use Globals;
use Log qw(message);

Plugins::register('autokach','AutoKach Plugin. f(lvl)=location. manticora', \&Unload, \&Unload);

my $chooks = Commands::register(['kach', 'make autokach.csv => autokach.mcs', \&mainKach], 
				['ka4',  'make autokach.csv => autokach.mcs', \&mainKach]);
my $datadir = $Plugins::current_plugin_folder;
my @folders = Settings::getControlFolders();
my $filename = "$datadir\\autokach.csv";
my $output = "$folders[0]\\autokach.mcs";
my $kach = "Kach";
my $setname = "";
my $am = "";
my @q = ();
my $n = 0;

sub Unload {
	Commands::unregister($chooks);
	undef $datadir;
	my @folders = Settings::getControlFolders();
	undef $filename;
	undef $output;
	undef $kach;
	undef $setname;
	undef $am;
	undef @q;
	undef $n;
	message "autokach plugin unloading or reloading\n", 'success';
}

sub mainKach {
	my ($cmd, $args) = @_;
	if (($args eq '') or ($args eq 'help')) {
		message "Usage:\nka4 help - this help\nka4 clear - clear file $output\n","list";
		message "ka4 <set_name> - generate file $output whith records <set_name>\n","list";
		return 1;
	}
	
	if ($args eq 'clear') {	
		open(O,">$folders[0]\\$output");
		print O "#\n#\n#";
		close(O);
		message "File $output was cleared\n","list";
		return 1;
	}
	
	if ($args ne '') {
		$setname = $args;	
		message "$setname","list";
	}

	$n = 0;
	open(F,"$filename") or die "No file $filename";
	while ($line = <F>) {
		chomp($line);
		($num, $set ,$lvl1, $lvl2, $saveMap, $lockMap, $kill, $notkill, $kafra, $sell) = split(";", $line);
		if ($setname eq $set) {
			$n++;	
			$q[$n]{lvl1} = $lvl1;
			$q[$n]{lvl2} = $lvl2;
			$q[$n]{saveMap} = $saveMap;
			$q[$n]{lockMap} = $lockMap;
			$q[$n]{kill} = $kill;
			$q[$n]{notkill} = $notkill;
			$q[$n]{kafra} = $kafra;
			$q[$n]{sell} = $sell;
		}
	}
	if ($n == 0) {
		message "HeTy Huqpura\nBad SetName: $setname\n","list";
		return 1;
	}
	
	#����������� ��� ������ � �������� � ������
	#������ ����� kach.mcs. ��������� ������ ��������� ��� �������...
	open(O,">$output");
	print O "#UTF-8\n";
	print O "macro autokach \{\n";
	print O "[\n";
	print O "	log ===================================\n";
	print O "	log ==== Begin AUTOKACH: $kach ====\n";
	print O "	log ===================================\n";
	message "===================================\n","list";
	message "==== Name of AUTOKACH: $kach ====\n","list";
	message "==== .CSV: $filename ====\n","list";
	message "==== File: $output ====\n","list";
	message "==== Begin: \"macro autokach\" ====\n","list";
	message "===================================\n","list";
	for ($i=1;$i<$n;$i++) {
		$s = "= $q[$i]{lvl1}..$q[$i]{lvl2} lvl -> $q[$i]{saveMap}, $q[$i]{lockMap} =\n";
		print O "	log $s";
		message "$s","list";
	}
	print O "	log ===================================\n";
	message "===================================\n","list";
	print O "	do conf saveMap none\n";
	print O "	do conf QuestPart $kach"."2\n";
	print O	"]\n\}\n\n";


	#������ - ��������� � ������. �����������, ��������� ���������: �����, ������, �������..
	#��������� ��������� ������� �� ��������� � �������� �������
	#�� ����� macro savetown � macro conftown
	print O "automacro $kach"."Town \{\n";
	%towns = ();
	for ($i=1;$i<$n;$i++) {	$towns{$q[$i]{saveMap}} = $q[$i]{saveMap};	}
	#�������� ������ ���� �������, ������� ��������� � �������� ��������
	$loc = "";	foreach $town (sort values %towns) {	$loc .= $town." ";	} chop($loc);	$loc =~ s/ /, /g;
	print O "	location $loc\n";
	print O "	run-once 1\n";
	print O "	eval \$::config\{QuestPart\} eq \"$kach"."0\"\n";
	print O "	call $kach"."TownM\n";
	print O "\}\n\n";
	print O "macro $kach"."TownM \{\n";
	print O	"if (\$.map != \@config(lockMap)) goto end\n";
	print O	"	#Propiska v gorode, save y kafra\n";
	print O "	call savetown\n";
	print O "	do conf lockMap none\n";
	print O "	pause \@rand(2,4)\n";
	print O "	#Settings - sell, buy, storage, etc\n";
	print O "	call conftown\n";
	print O "	do conf QuestPart $kach"."2\n";
	print O ":end\n";
	print O	"\}\n";

	
	$i=1;
	do {
		$automacro = $kach."_".$q[$i]{saveMap}."_".$q[$i]{lvl1}."_".$q[$i]{lvl2};
		$am .= " ".$automacro;
		print O "automacro $automacro \{\n";
		if ($q[$i]{lvl1} eq $q[$i]{lvl2}) { print O "	base = $q[$i]{lvl1}\n"; }
		else {	print O "	base >= $q[$i]{lvl1}\n"; print O "	base <= $q[$i]{lvl2}\n"; }
		print O "	run-once 1\n";
		print O "	eval \$::config{QuestPart} eq \"$kach"."2\" and \$::config\{saveMap\} eq \"$q[$i]{saveMap}\"\n";
		print O "	call $automacro"."M\n";
		print O "\}\n\n";
		print O "macro $automacro"."M \{\n";
		print O "	do conf attackAuto 2\n";
		print O "	do conf route_randomWalk 1\n";


		$j=$i; $lockMaps = "";
		while ( ($j <= $n) and ($q[$i]{lvl1} eq $q[$j]{lvl1}) and
				($q[$i]{lvl2} eq $q[$j]{lvl2}) and ($q[$i]{saveMap} eq $q[$j]{saveMap}) ) {
			$lockMaps .= $q[$j]{lockMap}." ";
			$j++;
		}
		#������� ������ ������ � ������, ������� �� ���� �� � �����������
		chop($lockMaps);	$lockMaps =~ s/ /","/g;
		print O "	do conf lockMap \@random(\"$lockMaps\")\n";

		
		$j=$i;
		while ( ($q[$i]{lvl1} eq $q[$j]{lvl1}) and ($j <= $n) and
				($q[$i]{lvl2} eq $q[$j]{lvl2}) and ($q[$i]{saveMap} eq $q[$j]{saveMap}) ) {
			$metka = $q[$j]{lockMap};	$metka =~ s/_//g;
			print O "	if (\@config(lockMap) != $q[$j]{lockMap}) goto not$metka\n";
			@mobs = split(",",$kill);	foreach $mob (@mobs) {		print O "\t\tdo mconf $mob 2 0 0\n";	}
			@mobs = split(",",$notkill);foreach $mob (@mobs) {		print O "\t\tdo mconf $mob 0 0 0\n";	}
			@items = split(",",$kafra);	foreach $item (@items) {	print O "\t\tdo iconf $item 0 1 0\n";	}
			@items = split(",",$sell);	foreach $item (@items) {	chomp($item);	print O "\t\tdo iconf $item 0 0 1\n";	}
			print O "	:not$metka\n";
			$j++;
		} 
		print O "	do conf QuestPart $kach"."2\n";
		print O "\}\n\n";
		$i=$j;
	} until $i > $n;
	

	#�� ����� �������� ����� ��������.
	$i=1;
	do {
		$j=$i;
		while ( ($j <= $n) and ($q[$i]{saveMap} eq $q[$j]{saveMap}) ) {
			$lockMaps .= $q[$j]{lockMap}." ";
			$j++;
		}
		$automacro = "$kach_moveto_$q[$i]{saveMap}_$q[$i]{lvl1}_$q[$j-1]{lvl2}";
		print O "#### $q[$i]{lvl1}..$q[$j-1]{lvl2} #### $q[$i]{saveMap}\n";
		print O "automacro $automacro \{\n";
		if ($q[$i]{lvl1} != $q[$j-1]{lvl2}) {	
		print O "	base >= $q[$i]{lvl1}\n";	print O "	base <= $q[$j-1]{lvl2}\n";	} 
		else { 	
		print O "	base = $q[$i]{lvl1}\n"; }
		print O "	run-once 1\n";
		print O	"	eval \$::config\{QuestPart\} eq \"$kach"."2\" and \$::config\{saveMap\} ne \"$q[$i]{saveMap}\"\n";
		print O "	call $automacro"."M\n";
		print O	"\}\n\n";
		print O "macro $automacro"."M \{\n";
		print O "	log Go to a new town: $q[$i]{saveMap}\n";
		print O "	if (\@config(saveMap) == $q[$i]{saveMap}) goto end\n";
		print O "		do conf attackAuto 0\n";
		print O "		do conf route_randomWalk 0\n";
		print O "		do conf lockMap $q[$i]{saveMap}\n";
		print O "		do conf QuestPart $kach"."0\n";
		print O "		do move \@config(lockMap)\n";
		print O "		release $kach"."Town\n";
		print O "	:end\n";
		print O "\}\n";
		$i = $j;
	} until $i > $n;

	
	#����� ���� ��������� ��������, ����� ���������� � ��������� ��� �����������, ���� ��� ����.
	print O "\nmacro autokachLock {\n";
	foreach (split(" ",$am)) {	print O "	lock $_\n";	}
	print O "}\n\n";

	print O "macro autokachRelease {\n";
	foreach (split(" ",$am)) {	print O "	release $_\n"; }
	print O "}\n\n";

	#����������� �������� �������� .csv, �� ������� �������� �����������.
	open(F,"$filename") or die "No file $filename";
	print O "# source file: $filename. SetName: $setname\n#\n";
	while (<F>) {
		($num, $set ,$lvl1, $lvl2, $saveMap, $lockMap, $kill, $notkill, $kafra, $sell) = split(";", $_);
		if ($setname eq $set) {	print O "# $_";	}
	}
	close(F);
	close(O);
	return 1;
}
