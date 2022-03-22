#!/bin/bash

#---------------------------------------
#Usage: ~/file.sh "database" "query"

#~/Manel.sh Psammodromus algirus 

#if needed: permitions ->   chmod +x file.sh  ---or----  chmod 777 file.sh

#----------------------------------------

#what is database =  argument_database $1

#what is query = argument_species $2

#---------------------------------------

#function for search:
#https://www.ncbi.nlm.nih.gov/books/NBK25498/#chapter3.ESearch__ESummaryEFetch
#esearch.fcgi?db=pubmed&term=asthma&query_key=1&WebEnv=<webenv string>&usehistory=y

# usando o history
#buscar as sequencias e guardar em oioi xml
Esearch(){
web=$(wget https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi/\?db\="$1"\&term\="$2"\&usehistory\=y -O ./oioi.xml)
    #To obtain a query key:
query_key=$(grep -o "<QueryKey>.*</QueryKey>" oioi.xml| sed 's/<QueryKey>//' | sed 's/<\/QueryKey>//' ) 
    #To obtain the webenv: 
WebEnv=$(grep -o "<WebEnv>.*</WebEnv>" oioi.xml| sed 's/<WebEnv>//' | sed 's/<\/WebEnv>//')

return $query_key
return $WebEnv
}

Esearch $1 $2

#------------------------------------------
#function for fetch
#https://www.ncbi.nlm.nih.gov/books/NBK25499/#chapter4.EFetch

#efetch.fcgi?db=protein&query_key=<key>&WebEnv=<webenv string>
Efetch(){
Web2=$(wget https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi/\?db\="$1"\&query_key\="$query_key"\&WebEnv\="$WebEnv"\&rettype\=fasta -O -)

echo $Web2
}

Efetch $1