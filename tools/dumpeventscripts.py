#!/usr/bin/env python3
file = "baserom.gbc"

offset = 0xfcec1
count = 2

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
		elif byte == 0x0d:
			arg = int.from_bytes(file.read(2), "little")
			print("\tcallstd $%04x ; TEMP" % arg)
		elif byte == 0x0e:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(2), "little")
			print("\tcallasm $%02x, $%04x ; TEMP" % (arg1, arg2))
		elif byte == 0x0f:
			arg = int.from_bytes(file.read(2), "little")
			print("\tspecial $%04x ; TODO" % arg)
		elif byte == 0x15:
			arg = int.from_bytes(file.read(1), "little")
			print("\tsetval $%02x" % arg)
		elif byte == 0x16:
			arg1 = int.from_bytes(file.read(2), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\ttext_far $%04x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x19:
			arg = int.from_bytes(file.read(2), "little")
			print("\treadmem $%04x ; TEMP" % arg)
		elif byte == 0x1b:
			arg1 = int.from_bytes(file.read(2), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tloadmem $%04x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x1e:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tloadvar $%02x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x2e:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tgiveegg $%02x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x40:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tgetmonname $%02x, $%02x ; TEMP" % (arg2, arg1))
		elif byte == 0x47:
			print("\topentext")
		elif byte == 0x48:
			arg = int.from_bytes(file.read(1), "little")
			print("\trefreshscreen $%02x" % arg)
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
		elif byte == 0x5c:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tloadwildmon $%02x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x5e:
			print("\tstartbattle")
		elif byte == 0x5f:
			print("\treloadmapafterbattle")
		elif byte == 0x60:
			arg = int.from_bytes(file.read(1), "little")
			print("\tcatchtutorial $%02x ; TEMP" % arg)
		elif byte == 0x7a:
			print("\treloadmap")
		elif byte == 0x7e:
			arg = int.from_bytes(file.read(2), "little")
			print("\tplaymusic $%04x ; TEMP" % arg)
		elif byte == 0x84:
			arg = int.from_bytes(file.read(2), "little")
			print("\tplaysound $%04x ; TEMP" % arg)
		elif byte == 0x90:
			print("\tend")
			print("")
			break
		elif byte == 0x9d:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tverbosegiveitem $%02x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x9f:
			print("\thalloffame")
		elif byte == 0xa1:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			arg3 = int.from_bytes(file.read(1), "little")
			arg4 = int.from_bytes(file.read(1), "little")
			arg5 = int.from_bytes(file.read(1), "little")
			print("\twarpfacing $%02x, $%02x, $%02x, $%02x, $%02x ; TEMP" % (arg1, arg2, arg3, arg4, arg5))

#print(chars)
