#!/usr/bin/python
from __future__ import division
import sys

wordProbDict = {}
fileIdString = ""
wordCountDict = {}
mCount = 0
fCount = 0

# def calcProb(key, mfWordCountDict):
# 	return ((mfWordCountDict[key][0]) / (mfWordCountDict[key][0] + mfWordCountDict[key][1]))

def calcProb(mfWordCountDict, key, ind, count):
	retVal =  ((mfWordCountDict[key][ind]) / count)
	if retVal == float(0):
		retVal = ((mfWordCountDict[key][ind]+0.1) / (count+0.1))
	return retVal

def writeListToFile(f, toWriteList):
	for item in toWriteList:
		for item2 in item:
			f.write(str(item2) + '\t')
		f.write('\n')

def generateFreqBelowThresholdFS(mfWordCountDict, threshold):
	keysToDeleteList = []
	toWriteList = []
	
	localTotalWordCount = long(0)

	f = open('Datasets//fs_wordsBelowThreshold_'+ fileIdString +'.txt', 'w')
	for key in mfWordCountDict:
		if mfWordCountDict[key][0] < threshold and mfWordCountDict[key][1] < threshold:
			probF = calcProb(mfWordCountDict, key, 0, fCount)
			probM = calcProb(mfWordCountDict, key, 1, mCount)
			toWriteList.append([key, probF, probM, wordProbDict[key]])
			keysToDeleteList.append(key)
			localTotalWordCount = localTotalWordCount + wordCountDict[key]

	# update just the current list words
	
	check = long(0)
	intermToWriteList = []
	for item in toWriteList:
		prob = wordCountDict[item[0]] / localTotalWordCount
		check = check + prob;
		intermToWriteList.append([item[0], item[1], item[2], str(prob)])

	print check
	toWriteList = intermToWriteList

	toWriteList.sort(key=lambda x: x[0], reverse=False)
	writeListToFile(f,toWriteList)

	for key in keysToDeleteList:
		mfWordCountDict.pop(key, None)

	return mfWordCountDict


def generateObsceneJunkWordsFS(mfWordCountDict):
	substrWordsList = ['nigga', 'fuck', 'sex']
	keysToDeleteList = []
	toWriteList = []
	
	localTotalWordCount = long(0)

	f = open('Datasets//fs_obsceneJunkWords_'+ fileIdString +'.txt', 'w')
	for key in mfWordCountDict:
		for w in substrWordsList:
			if w in key:
				probF = calcProb(mfWordCountDict, key, 0, fCount)
				probM = calcProb(mfWordCountDict, key, 1, mCount)
				toWriteList.append([key, probF, probM, wordProbDict[key]])
				keysToDeleteList.append(key)
				localTotalWordCount = localTotalWordCount + wordCountDict[key]

	# update just the current list words
	
	intermToWriteList = []
	check = long(0)
	for item in toWriteList:
		prob = wordCountDict[item[0]] / localTotalWordCount
		intermToWriteList.append([item[0], item[1],  item[2], str(prob)])
		check = check + prob;

	print check
	toWriteList = intermToWriteList

	toWriteList.sort(key=lambda x: x[0], reverse=False)
	writeListToFile(f,toWriteList)

	for key in keysToDeleteList:
		mfWordCountDict.pop(key, None)

	return mfWordCountDict


def generateHashtagsFS(mfWordCountDict):
	keysToDeleteList = []
	toWriteList = []

	localTotalWordCount = long(0)

	f = open('Datasets//fs_wordsWithHashtags_'+ fileIdString +'.txt', 'w')
	for key in mfWordCountDict:
		if key[0] == '#':
			probF = calcProb(mfWordCountDict, key, 0, fCount)
			probM = calcProb(mfWordCountDict, key, 1, mCount)
			toWriteList.append([key, probF, probM, wordProbDict[key]])
			keysToDeleteList.append(key)
			localTotalWordCount = localTotalWordCount + wordCountDict[key]


	# update just the current list words
	check = long(0)
	intermToWriteList = []
	for item in toWriteList:
		prob = wordCountDict[item[0]] / localTotalWordCount
		intermToWriteList.append([item[0], item[1],  item[2], str(prob)])
		check = check + prob;

	print check
	toWriteList = intermToWriteList

	toWriteList.sort(key=lambda x: x[0], reverse=False)
	writeListToFile(f,toWriteList)

	for key in keysToDeleteList:
		mfWordCountDict.pop(key, None)

	return mfWordCountDict

def generateRemainingFS(mfWordCountDict):
	toWriteList = []

	localTotalWordCount = long(0)

	f = open('Datasets//fs_remainingWords_'+ fileIdString +'.txt', 'w')
	for key in mfWordCountDict:
		probF = calcProb(mfWordCountDict, key, 0, fCount)
		probM = calcProb(mfWordCountDict, key, 1, mCount)
		toWriteList.append([key, probF, probM, wordProbDict[key]])
		localTotalWordCount = localTotalWordCount + wordCountDict[key]
		
	# update just the current list words
	
	check = long(0)
	intermToWriteList = []
	for item in toWriteList:
		prob = wordCountDict[item[0]] / localTotalWordCount
		intermToWriteList.append([item[0], item[1],  item[2], str(prob)])
		check = check + prob;

	print '\n' + str(check)
	print '\n' + str(localTotalWordCount)
	toWriteList = intermToWriteList

	toWriteList.sort(key=lambda x: x[0], reverse=False)
	writeListToFile(f,toWriteList)

def main():
	global wordProbList
	global fileIdString
	global wordCountDict
	global mCount
	global fCount
	mCount = 916
	fCount = 1370
	# A dictionary with word as the key
	# and a list as value
	# list has two coloumns : [female freq, male freq]
	if len(sys.argv) < 3:
		print ' Needs 3 input arguments : '
		print ' fileIdString , female freq file, male freq file, threshold(optional)'
		return

	fileIdString = sys.argv[1]
	femFileName = sys.argv[2]
	maleFileName = sys.argv[3]
	splitFeatureSet = True
	threshold = 0
	if len(sys.argv) > 4 and str(sys.argv[4]) != "":
		threshold = int(sys.argv[4])
	else:
		threshold = 10

	if len(sys.argv) > 5 and str(sys.argv[5]) != "":
		string = (str(sys.argv[5])).lower()
		if string == 'false' or string == 'f':
 			splitFeatureSet = False

	print 'fileIdString : ' + fileIdString
	print 'male freq file : ' + maleFileName
	print 'female freq file : ' + femFileName
	print 'threshold (default is 10) : ' + str(threshold)
	print 'split feature set :' + str(splitFeatureSet)
	print 'Number of females : ' + str(fCount)
	print 'Number of males : ' + str(mCount)
	print 'Is this correct ? ',
	ans = str(sys.stdin.read(1))
	if ans != 'y' and ans != 'Y':
		print 'Exiting...'
		return

	mfWordCountDict = {}
	wordCountDict = {}
	femFile = open(femFileName, 'r')
	totalWordCount = long(0)
	for line in femFile:
		line = line.rstrip('\n')
		words = line.split('\t')
		if mfWordCountDict.has_key(words[1]):
			mfWordCountDict[words[1]][0] = int(words[0])
			wordCountDict[words[1]] = wordCountDict[words[1]] + int(words[0])
		else:
			mfWordCountDict[words[1]] = [int(words[0]), 0]
			wordCountDict[words[1]] = int(words[0])
		totalWordCount = totalWordCount + int(words[0])

	maleFile = open(maleFileName, 'r')
	for line in maleFile:
		line = line.rstrip('\n')
		words = line.split('\t')
		if mfWordCountDict.has_key(words[1]):
			mfWordCountDict[words[1]][1] = int(words[0])
			wordCountDict[words[1]] = wordCountDict[words[1]] + int(words[0])
		else:
			mfWordCountDict[words[1]] = [0, int(words[0]), int(words[0])]
			wordCountDict[words[1]] = wordCountDict[words[1]] + int(words[0])
		totalWordCount = totalWordCount + int(words[0])

	# Generate all the data sets
	print 'Number of words in dict : ' + str(len(mfWordCountDict))
	print 'Total number of words : ' +  str(totalWordCount)

	print ''
	print 'Calculating probability of every word'
	wordProbList = [['zzzzzznotaword', 0.0]] # temp data structure for writing the word probability to file
	for key in wordCountDict:
		wordProbDict[key] = wordCountDict[key] / totalWordCount;
		wordProbList.append([key, wordProbDict[key]])
	wordProbList.pop(0)
	wordProbList.sort(key=lambda x: x[1], reverse=True)
	f= open('Datasets//wordProbabilitList_'+ fileIdString +'.txt', 'w')
	for item in wordProbList:
		f.write(item[0] + '\t' + str(item[1]) + '\n')

	if splitFeatureSet:
		print ''
		print 'Writing words below threshold words feature set...',
		mfWordCountDict = generateFreqBelowThresholdFS(mfWordCountDict, threshold)
		print 'done'
		print 'Number of remaining words in dict : ' + str(len(mfWordCountDict))

		print ''
		print 'Writing obscene/junk words feature set...',
		mfWordCountDict = generateObsceneJunkWordsFS(mfWordCountDict)
		print 'done'
		print 'Number of remaining words in dict : ' + str(len(mfWordCountDict))

		print ''
		print 'Writing hashtags words feature set...',
		mfWordCountDict = generateHashtagsFS(mfWordCountDict)
		print 'done'
	
	print 'Number of remaining words in dict : ' + str(len(mfWordCountDict))
	generateRemainingFS(mfWordCountDict)
	print ''
	print 'Writing remaining words feature set...',
	
	print 'done'


if __name__ == "__main__":
	main()