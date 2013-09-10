
maximumViews = 17


pliststring  = '<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n<plist version="1.0">\n<dict>\n'


for i in range(maximumViews):

	number_of_views = i + 1;
	filename = str(number_of_views)+".txt"
	content = open(filename);
	lines = content.readlines();
	pliststring += "<key>" + str(number_of_views) + "</key>\n" + "<dict>"
	for line in lines:
		line.replace(",", "")
		items = line.split()
		pliststring += "<key>" + items[0] + "</key>\n"
		pliststring += "<dict>"

		pliststring += "<key>x</key>\n"
		pliststring += "<real>" + items[1][:-1] + "</real>\n"
		pliststring += "<key>y</key>\n"
		pliststring += "<real>" + items[2][:-1] + "</real>\n"
		pliststring += "<key>z</key>"
		pliststring += "<real>" + items[3] + "</real>\n"
		pliststring += "</dict>\n"

	content.close()

	pliststring += "</dict>\n"


pliststring += "</dict>\n</plist>\n"
f = open('coordinate.plist','w')
f.write(pliststring)
f.close()

