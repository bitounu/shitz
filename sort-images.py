import os
import glob
import EXIF
from datetime import date

# zamiana daty na format yyyy-mm-dd i obciecie czasu
def parsedate(s):
    try:
		return s[0:4]+"-"+s[5:7]+"-"+s[8:10]
	except:
	   return None

def outtime(x):
	try:
		return date(int(x[0:4]),int(x[5:7]),int(x[8:10])).ctime()
	except:
		return None

# wcyciagam dane EXIF z wszystkich plikow, ktore je posiadaja
# w tym katalogu
#pliki = glob.glob('*.[j,J][p,P][g,G]')
pliki = glob.glob('*')
fotki = {}
for i in pliki:
	try:
		f = open(i, 'rb')
	except:
		print "'%s' is unreadable\n"%i
		continue
	# get the tags
	tags = EXIF.process_file(f, stop_tag='EXIF DateTimeOriginal')
	if not tags:
		print "No EXIF info found: ", i
		continue
	if tags != {}:
		if tags.get('EXIF DateTimeOriginal') == None:
			a = tags.get('Image DateTime')
		else:
			a = tags.get('EXIF DateTimeOriginal')
	fotki[i] = a

print "=============================================="
print ""

# konwersja daty w fotki{}
for (k, v) in fotki.iteritems():
	fotki[k] = parsedate(str(v))

# Sortowanie fotki{}
date = ""
tmp_dir = ""
alist = sorted(fotki.iteritems(), key=lambda (k,v): v)
for i in range(len(alist)):
	date = alist[i][1] # zapamietuje nowa date
	if tmp_dir == date:
		file = "../"+alist[i][0]
		dir = date+"/"+alist[i][0]
		os.utime(alist[i][0],outtime(date))
		os.symlink(file, dir)
		print "ln -sf ", file, dir
	else:
		print "----------------------------------------------"
		os.mkdir(date)
		print "mkdir ", date
		tmp_dir = date
		file = "../"+alist[i][0]
		dir = date+"/"+alist[i][0]
		os.utime(alist[i][0],outtime(date))
		os.symlink(file, dir)
		print "ln -sf ", file, dir



print ""
print "=============================================="
print "Fotek z danymi EXIF jest: ", len(fotki)

