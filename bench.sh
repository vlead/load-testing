#!/bin/bash

#script to generate report for virtual lab server
#Note that first parameter to this is script file containing all the urls
#setting parameters for number of request n# and concurrency c# as global parameters

#function to create to get results for all urls i
loadTest() {
while read p; do 
  echo "Running tests for $p"         
  q=$(echo $p | sed 's/[:/.-]/_/g')
  mkdir $q
  while read n c; do                   
    cd $q 									
    echo "ab -n $n -c $c $p"
    ab -n $n -c $c $p > $q$n$c
    cd ..
  done < $2
done < $1
}

#function to extract required fields reports previously generated
extract() {
#echo "I am the extract function for generating reports and I do nothing, I just exist"
while read p; do
  #echo "Running tests for $p" 
  csv="_csv.csv"
  res="No of Requests,Concurreny Level,Time taken for tests,Requests per second,Complete requests,Failed requests,Time per request(mean across all concurrent requests),Transfer rate"$'\n'       
  q=$(echo $p | sed 's/[:/.-]/_/g') 
  while read n c; do
    res="$res$n,$c"                     
    while read field; do               
      cd $q
      #echo "ab -n $n -c $c $p $field :"
      res="$res,$(cat $q$n$c | grep "$field" | grep -o '[[:digit:]*\.[:digit:]]*')"
      #res="$res,$tem"
      cd ..
    done < $3 
    res="$res"$'\n'
  done < $2 
  echo "$res"
done < $1         
}

#invoking funtions
#loadTest $1 $2
extract $1 $2 $3
