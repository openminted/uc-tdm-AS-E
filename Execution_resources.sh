#Lancement du script depuis le répertoire local
#
#***********************
#Traitement des ressources
#***********************
#Gene
#***********************
#Ajout en synonymes de la première colonne de TAIR dans la seconde 
cat resources/gene_aliases_20130831_TAIR.txt | awk -F"\t" '{print$0"\n"$1"\t"$2"\t"$2;}'|sort -u > resources/gene_aliases_20130831_TAIR_synonymesfirst.txt
#Ajout en synonymes de la première colonne de TAIR dans la troisième 
cat resources/gene_aliases_20130831_TAIR_synonymesfirst.txt | awk -F"\t" '{print$0"\n"$1"\t"$2"\t"$1;}'|sort -u > resources/gene_aliases_20130831_TAIR_synonymes.txt
#tous les tirets remplacés par des espaces : apetala-2-3 => apetala 2 3
cat resources/gene_aliases_20130831_TAIR_synonymes.txt | perl -npe '$line=$_; $line=~s/-/ /g; print $line;' |sort -u > resources/gene_aliases_20130831_TAIR_tiret.txt
#fichier étendu tiret et espace on imprime toutes les lignes qu'on lit, + on créé si espace entre quoique ce soit non fini par chifrre espace chiffre (APETELA 2), on colle (APETALA2) ou tiret (APETALA-2) ou underscore (APETALA_2) / si quoi que ce soit terminé par lettre + chiffre (+ d'autre chiifre hypothétique) (APETALA2) on décolle (APETALA2) ou tiret (APETALA-2) ou underscore (APETALA_2)
cat resources/gene_aliases_20130831_TAIR_tiret.txt | perl -npe 's/ +/ /g; if(/^(.+[^\d])\s(\d+(\s\d+)*)$/){print "$1$2\n"; print "$1-$2\n"; print $1."_".$2."\n";} if(/^(.+[a-zA-Z])(\d+(\s\d+)*)$/){print "$1 $2\n"; print "$1-$2\n"; print $1."_".$2."\n";}' |sort -u > resources/gene_aliases_20130831_TAIR_extended.txt
#***********************
#Familles de Gènes et Proteines
#***********************
#Création d'un lexique à partir de la première colonne
cut -f1 resources/gene_families_sep_29_09_update.txt | sort -u > resources/gene_families_lexicon.txt
##***********************
#RNA
#***********************
#RNA MirTarBase en xls 
#convertion avec gnumeric : exemple 
ssconvert -O 'separator="	" eol=unix quote=' resources/ath_MTI.xls resources/ath_MTItoto.txt
#Separator: tab : ctrl+v+tab
#je rajoute la seconde colonne en enlevant 
cat resources/ath_MTI.txt | awk -F"\t" '{print$1"\t"$2"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9;}' | awk -F"\t" '{gsub("ath-","",$3);print$1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10;}' | sort | head -n -1 > resources/ath_MTI_extended.txt 
#***********************
#Expander
bash alvisir-index-expander configuration/expander configuration/expander.xml
#***********************
#Entities plan
#/bibdev/install/alvisnlp/devel/bin/alvisnlp -inputDir /bibdev/travail/arabidopsis/alvisir2_devel -log plan/alvisnlp.log plan/entities.plan


