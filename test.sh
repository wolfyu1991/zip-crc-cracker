#!/bin/bash

python3 -m pip install -r requirements.txt

# make text files
echo -n crc > 1.txt
echo -n  32 > 2.txt
echo -n  foo > 3.txt
echo -n  decr > 4.txt
echo -n  ypt > 5.txt
echo -n  able > 6.txt

# make zip files
zip 1.zip 1.txt 2.txt
rar a 2.rar 3.txt
7z a 3.7z 4.txt 5.txt 6.txt

# run the cracker
time python3 crack.py 1.zip 2.rar 3.7z | tee result.txt

# check the result
grep '1.txt : '\''crc'\'  result.txt || { echo failed ; exit 1 ; }
grep '2.txt : '\''32'\'   result.txt || { echo failed ; exit 1 ; }
grep '3.txt : '\''foo'\'  result.txt || { echo failed ; exit 1 ; }
grep '4.txt : '\''decr'\' result.txt || { echo failed ; exit 1 ; }
grep '5.txt : '\''ypt'\'  result.txt || { echo failed ; exit 1 ; }
grep '6.txt : '\''able'\' result.txt || { echo failed ; exit 1 ; }
grep 'flag : crc32foodecryptable' result.txt || { echo failed ; exit 1 ; }
echo passed
