#function to create to get results for all urls i
loadTest() {
while read url; do 								#loop reads a line from url file i.e $1
  echo "Running tests for $url"         		#echo on outputstream to indicate flow
  dir=$(echo $url | sed 's/[:/.-]/_/g')			#extracting filename 'dir' from 'url'
  mkdir $dir									#making directory with name 'dir'
  while read n c; do                   			#loop for reading 'n' and 'c' from 'config' file
    cd $dir 									#changing directory named 'dir'
    echo "ab -n $n -c $c $url"					#echoing to show flow at runtime
    ab -n $n -c $c -X proxy.iiit.ac.in:8080 $url > $dir$n$c #running ab command with 'n' 'c' and redirecting output to a file named $dir$n$c 	
    cd ..										#Moving to parent directory
  done < $2										#passing 'config' file parameter
done < $1										#passing 'urls' file as parameter
}

loadTest $1 $2 #invoking loadTest() function with command line arguments $1 and $2
