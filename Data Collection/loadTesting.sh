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

loadTest $1 $2