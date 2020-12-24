#!/usr/bin/bash

echo "Convertiong all .txt to .json file"
for entry in *.txt; do
        #echo "${entry/.txt/.json}"
	mv $entry "${entry/.txt/.json}"
     
done

