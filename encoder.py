#!/usr/bin/python
#a basic swap encoder

import sys
shellcode= sys.argv[1]
if len(shellcode) % 2 ==1:
	shellcode = '\x90' + shellcode

encoded = ""

x = bytearray(shellcode)
for i in range(0, len(shellcode), 2):
	#place \x
	encoded += '\\x'
	s = x[i] #store the current even bit
	x[i] = x[i + 1] #swap bits
	encoded += '%02x' % x[i] #append
	encoded += '\\x'
	x[i+1] = s
	encoded += '%02x' % x[i+1]
print ""
print"Encoded:"
print encoded
