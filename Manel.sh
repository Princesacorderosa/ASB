#!/bin/bash

#---------------------------------------
#Usage: ~/file.sh "database" "query"
#nao podem estar entre aspas senao não dá!
#permitions chmod +x file.sh ou chmod 777 file.sh



#what is database =  argument_database $1

#what is query = argument_species $2

#---------------------------------------
#esearch.fcgi?db=pubmed&term=asthma&query_key=1&WebEnv=<webenv string>&usehistory=y

#function para search  , usando o history
#buscar as sequencias e guardar em oioi xml
wget https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi/\?db\="$1"\&term\="$2"\&usehistory\=y -O ./oioi.xml

#DESAFIO, FAZER SEM GRAVAR O OIOI o.o


#function esearch
Esearch(){
      web=$(wget https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi/\?db\="$1"\&term\="$2"\[organism\],cytb\[gene\]\&usehistory\=y -O ./oioi.xml)

# Get the list of IDs, comma separated and save them in xml file
#ids=$(cat oioi.xml |grep -i "^<Id>" | sed 's/[^0-9]//g' | tr "\n" "," |rev |cut -c 2- |rev ) # > IDs.xml)

#https://www.ncbi.nlm.nih.gov/books/NBK25498/#chapter3.ESearch__ESummaryEFetch

#query keys
query_key=$(grep -o "<QueryKey>.*</QueryKey>" oioi.xml| sed 's/<QueryKey>//' | sed 's/<\/QueryKey>//' ) 

#webenv
WebEnv=$(grep -o "<WebEnv>.*</WebEnv>" oioi.xml| sed 's/<WebEnv>//' | sed 's/<\/WebEnv>//')

echo $query_key
echo $WebEnv
}
#------------------------------------------
#function para fetch

Efetch(){

xy=$query_key

#https://www.ncbi.nlm.nih.gov/books/NBK25499/#chapter4.EFetch

#efetch.fcgi?db=protein&query_key=<key>&WebEnv=<webenv string>
wget https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi/\?db\="$1"\&query_key\=$query_key\&WebEnv\=$WebEnv\&rettype\=fasta -O -

#cat db_sp.fasta
}

#-----------------------------------------------------
#criar functions 
#para esearch

#para efetch
