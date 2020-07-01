#!/usr/bin/env python3
file = "baserom.gbc"

offset = 0xfce1a
count = 1

file = open(file, "rb")
file.seek(offset)

while count != 0:
	count -= 1
	while True:
		byte = int.from_bytes(file.read(1), "little")
		if byte == 0x00:
			arg = int.from_bytes(file.read(2), "little")
			print("\tscall $%04x ; TEMP" % arg)
		elif byte == 0x01:
			print("\tfarscall")
		elif byte == 0x02:
			arg = int.from_bytes(file.read(2), "little")
			print("\tmemcall $%04x ; TEMP" % arg)
		elif byte == 0x03:
			arg = int.from_bytes(file.read(2), "little")
			print("\tsjump $%04x ; TEMP" % arg)
		elif byte == 0x06:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(2), "little")
			print("\tifequal $%02x, $%04x ; TEMP" % (arg1, arg2))
		elif byte == 0x08:
			arg = int.from_bytes(file.read(2), "little")
			print("\tiffalse $%04x ; TEMP" % arg)
		elif byte == 0x0c:
			arg = int.from_bytes(file.read(2), "little")
			print("\tjumpstd $%04x ; TEMP" % arg)
		elif byte == 0x0f:
			arg = int.from_bytes(file.read(2), "little")
			print("\tspecial $%04x ; TEMP" % arg)
		elif byte == 0x16:
			arg1 = int.from_bytes(file.read(2), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\ttext_far $%04x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x19:
			arg = int.from_bytes(file.read(2), "little")
			print("\treadmem $%04x ; TEMP" % arg)
		elif byte == 0x1e:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tloadvar $%02x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x47:
			print("\topentext")
		elif byte == 0x49:
			print("\tclosetext")
		elif byte == 0x4c:
			arg = int.from_bytes(file.read(2), "little")
			print("\twritetext $%04x ; TEMP" % arg)
		elif byte == 0x4f:
			arg = int.from_bytes(file.read(2), "little")
			print("\tloadmenu $%04x ; TEMP" % arg)
		elif byte == 0x50:
			print("\tclosewindow")
		elif byte == 0x53:
			print("\twaitbutton")
		elif byte == 0x58:
			print("\tverticalmenu")
		elif byte == 0x5a:
			print("\trandomwildmon")
		elif byte == 0x5e:
			print("\tstartbattle")
		elif byte == 0x5f:
			print("\treloadmapafterbattle")
		elif byte == 0x7a:
			print("\treloadmap")
		elif byte == 0x84:
			arg = int.from_bytes(file.read(2), "little")
			print("\tplaysound $%04x ; TEMP" % arg)
		elif byte == 0x90:
			print("\tend")
			print("")
			break

#print(chars)
