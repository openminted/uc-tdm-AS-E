#Bash
#
#***********************
#Processing internal resources
#***********************
#Gene lexical processing
#***********************
#Add in synonyms of the first column of TAIR in the second one  
cat resources/gene_aliases_20130831_TAIR.txt | awk -F"\t" '{print$0"\n"$1"\t"$2"\t"$2;}'|sort -u > resources/gene_aliases_20130831_TAIR_synonymesfirst.txt
#Addition in synonyms of the first column of TAIR in the third one 
cat resources/gene_aliases_20130831_TAIR_synonymesfirst.txt | awk -F"\t" '{print$0"\n"$1"\t"$2"\t"$1;}'|sort -u > resources/gene_aliases_20130831_TAIR_synonymes.txt
#all dashes replaced by spaces: apetala-2-3 => apetala 2 3
cat resources/gene_aliases_20130831_TAIR_synonymes.txt | perl -npe '$line=$_; $line=~s/-/ /g; print $line;' |sort -u > resources/gene_aliases_20130831_TAIR_tiret.txt
#extended dash and space file: print all the lines you read, + create if space between anything that is not finished by chifrre space number (APETELA 2), paste (APETALA2) or dash (APETALA-2) or underscore (APETALA_2)
#if anything is terminated by letter + digit (+ other hypothetical number) (APETALA2) is detached (APETALA2) or dash (APETALA-2) or underscore (APETALA_2)
cat resources/gene_aliases_20130831_TAIR_tiret.txt | perl -npe 's/ +/ /g; if(/^(.+[^\d])\s(\d+(\s\d+)*)$/){print "$1$2\n"; print "$1-$2\n"; print $1."_".$2."\n";} if(/^(.+[a-zA-Z])(\d+(\s\d+)*)$/){print "$1 $2\n"; print "$1-$2\n"; print $1."_".$2."\n";}' |sort -u > resources/gene_aliases_20130831_TAIR_extended.txt
#***********************
#Gene and Protein families
#***********************
#Creating a lexicon from the first column
cut -f1 resources/gene_families_sep_29_09_update.txt | sort -u > resources/gene_families_lexicon.txt
##***********************
#RNA
#***********************
#RNA MirTarBase is in xls 
#convertion with gnumeric : example Separator: tab : ctrl+v+tab
ssconvert -O 'separator="	" eol=unix quote=' resources/ath_MTI.xls resources/ath_MTI.txt
#adding the second column and removing 
cat resources/ath_MTI.txt | awk -F"\t" '{print$1"\t"$2"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9;}' | awk -F"\t" '{gsub("ath-","",$3);print$1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10;}' | sort | head -n -1 > resources/ath_MTI_extended.txt 
#***********************
#Expander
bash alvisir-index-expander configuration/expander configuration/expander.xml



