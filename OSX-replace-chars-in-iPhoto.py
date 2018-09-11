#!/usr/bin/python
# -*- coding: utf-8 -*-
import EasyDialogs
import os

def gdzie_zapisac():
    # ask for destination folder
	dir = EasyDialogs.AskFolder(
		message='Select destinatin folder',
		defaultLocation=os.getcwd(),
		wanted=unicode,
		)
	return dir


def napraw_nazwy(album):
	# loop for ZNAKI table
	ZNAKI = [',', '.', '\\', '/', '+', ':', ' ']
	for s in ZNAKI:
		album = album.replace(s, '_')
	return album

dir = gdzie_zapisac()
iPAlbumCount = os.getenv('iPAlbumCount')
for i in range(int(iPAlbumCount)):
	ALBUM_x = 'iPAlbumName_' + str(i)		        # variable name for particular album
	ALBUM = os.getenv(ALBUM_x)				        # link to its value with eval()
	ALBUM = napraw_nazwy(ALBUM)				        # replacing characters in albums name
#	ALBUMPATH = os.path.join(dir,ALBUM)		        # path to folder
	ALBUMPATH = dir + '/' + ALBUM.decode('utf-8')
	print "ALBUMPATH = " + ALBUMPATH.encode('utf-8')
	os.mkdir(ALBUMPATH)                             # create folder
