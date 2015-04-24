#!/usr/bin/python
import sys
count = 0

wordFile = open('words_1gm.txt', 'w')
wordFile2 = open('words_2gm.txt', 'w')

with open('en.1grams') as f:
	for line in f:
		count = count +1
		if (count <= 5):
			continue;
		word = line.split('\t');
		wordFile.write(word[0]+'\t')
		femaleFrequency=0
		maleFrequency=0
		for i in range(1,1198,6):
		    femaleFrequency = femaleFrequency + int(word[i]);
		for i in range(3,1198,6):
		    maleFrequency = maleFrequency + int(word[i]);
		wordFile.write(str(femaleFrequency)+'\t'+str(maleFrequency) + '\n')
		print "\rProgress  : " + str(count),

print "\n Starting 2grams....\n"
count=0
with open('en.2grams') as f:
	for line in f:
		count = count +1
		if (count <= 5):
			continue;
		word = line.split('\t');
		wordFile2.write(word[0]+'\t')
		femaleFrequency=0
		maleFrequency=0
		for i in range(1,1198,6):
		    femaleFrequency = femaleFrequency + int(word[i]);
		for i in range(3,1198,6):
		    maleFrequency = maleFrequency + int(word[i]);
		wordFile2.write(str(femaleFrequency)+'\t'+str(maleFrequency) + '\n')
		print "\rProgress  : " + str(count),