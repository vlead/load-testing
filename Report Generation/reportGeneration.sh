#function to extract required fields reports previously generated
extractCsv() {
while read url; do #loop to read url from 'url' file
  csv="_csv.csv"   #storing file extension in variable 'csv'
  #storing headers of csv files in 'res'
  res="No of Requests,Concurreny Level,Time taken for tests,Requests per second,Complete requests,Failed requests,Time per request(mean across all concurrent requests),Transfer rate"$'\n'       
  dir=$(echo $url | sed 's/[:/.-]/_/g') #extracting filename 'dir' from 'url'
  while read n c; do #loop for reading 'n' and 'c' from 'config' file
    res="$res$n,$c"  #adding parameters values to 'res'                   
    while read field; do #loop for reading 'field' from 'fields' files         
      cd $dir #changing directory to 'dir'
      #echo "ab -n $n -c $c $p $field :"
      #concatenating value for 'field'
      res="$res,$(cat $dir$n$c | grep "$field" | grep -o '[[:digit:]*\.[:digit:]]*')"
      #res="$res,$tem"
      cd .. #changing to parent directory
    done < $3 #exiting loop which reads 'fields' file as third parameter
    res="$res"$'\n' #concatenating new line character after each tuple of csv file
  done < $2 #exiting loop which reads 'config' file as second parameter
  echo "$res" > "$dir$csv" #redirecting content in 'res' to a csv file named '$dir$csv'
done < $1
echo "Reports are generated successfully in CSV format"  #echoing script completion       
}

#invoking extracCsv() funtion
extractCsv $1 $2 $3
