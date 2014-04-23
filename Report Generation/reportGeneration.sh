#function to extract required fields reports previously generated
extractCsv() {
while read p; do
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
  echo "$res" > "$q$csv"
done < $1
echo "Reports are generated successfully in CSV format"         
}

extractCsv $1 $2 $3
