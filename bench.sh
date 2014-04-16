#!/bin/bash

#script to generate report for virtual lab server
#Note that first parameter to this is script file containing all the urls
#setting parameters for number of request n# and concurrency c# as global parameters
n1=100
c1=20
n2=1000
c2=400

#function to create to get results for all urls i
loadTest() {
while read p; do 								#Entering loop reading url in $p from url file in each iteration. 
  echo "Running tests for $p"					
  q=$(echo $p | sed 's/[:/.-]/_/g') 			#getting file name by replacing following sysmbols from url /:.- and getting valid directory name
  mkdir $q 										#creating directory for each url
  cd $q											#opening directory
  echo "ab -n $n1 -c $c1 -r $p"
  ab -n $n1 -c $c1 -r $p > $q$n1$c1				#running ab tool for current url with first set of parameters

  echo "ab -n $n2 -c $c2 -r $p"
  ab -n $n2 -c $c2 -r $p > $q$n2$c2             #running ab too for current url with second set of parameters
  cd ..											#Exiting current $q
done < $1;										#Exiting loop
}

#function to extract required fields reports previously generated
extract() {

}

#invoking funtions
loadTest $1




