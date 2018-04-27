#!/bin/bash
# rm tmp_merged/*

unzip -j SnomedCT_BelgiumExtensionRF2_PRODUCTION_20180315T120000Z.zip "*Snapshot*" -d tmp_merged
unzip -j SnomedCT_InternationalRF2_PRODUCTION_20180131T120000Z.zip "*Snapshot*" -d tmp_merged

# find tmp_extract -name "*_INT_*"

MOD="_BE1000172_"
MODDATE="20180315"
MODEXT="$MOD$MODDATE.txt"
INT="_INT_"
INTDATE="20180131"
INTEXT="$INT$INTDATE.txt"

# der2_cciRefset_RefsetDescriptorSnapshot_INT_20180131.txt
cd tmp_merged

for f in *_INT_*
do
	# Remove suffix referencing Internaltional release
	modfile="${f/$INTEXT}"
	# Remove language reference (if it exists)
	modfile="${modfile/-en}"

	echo "Handling $modfile with $INTEXT and $MODEXT"

	#Check if one or more files (multiple languages) exist in the module version
	shopt -s nullglob
	set -- $modfile*$MODEXT
	if [ "$#" -gt 0 ]; then
	# if [ -f $modfile*$MODEXT ]; then
		echo "Merging file $modfile*$MODEXT and $f"
		# Append module files to internaltional release files
		tail --lines=+2 -q $modfile*$MODEXT >> $f
		# Remove module files from tmp_merged
		rm $modfile*$MODEXT 
	else
		echo "File not found $modfile*$MODEXT"
	fi
done

cd ..

zip tmp_merged.zip tmp_merged/*

rm -r tmp_merged

./load_release.sh tmp_merged.zip snomedct SNAP

echo "Enter database username:"
read dbUsername

dbUserPassword=""
echo "Enter database password (or return for none):"
read newDbPassword
if [ -n "$newDbPassword" ]
then
	dbUserPassword="-p${newDbPassword}"
fi

echo "Enter MySQL hostname:"
read dbHost

echo "Creating back-up from current MyISAM version of database"

mysqldump -h $dbHost -u $dbUsername $dbUserPassword --routines --add-drop-database --databases snomedct > snomed-ct.myisam.sql
tar -cvzf snomed-ct.myisam.tar.gz snomed-ct.myisam.sql
rm snomed-ct.myisam.sql

mysql -h $dbHost -u $dbUsername $dbUserPassword < convert_myisam_innodb.sql

mysqldump -h $dbHost -u $dbUsername $dbUserPassword --routines --add-drop-database --databases snomedct > snomed-ct.innodb.sql
tar -cvzf snomed-ct.myisam.tar.gz snomed-ct.innodb.sql
rm snomed-ct.innodb.sql
