#!/usr/bin/env python3
file = "../baserom.gbc"

offset = int(input("Enter offset: "), 16)
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
			print("\tfarscall $%04x ; TEMP (Must be a label)" % arg)
		elif byte == 0x02:
			arg = int.from_bytes(file.read(2), "little")
			print("\tmemcall $%04x ; TEMP" % arg)
		elif byte == 0x03:
			arg = int.from_bytes(file.read(2), "little")
			print("\tsjump $%04x ; TEMP" % arg)
		elif byte == 0x04:
			print("\tfarsjump $%04x ; TEMP (Must be a label)" % arg)
		elif byte == 0x05:
			arg = int.from_bytes(file.read(2), "little")
			print("\tmemjump $%04x ; TEMP" % arg)
		elif byte == 0x06:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(2), "little")
			print("\tifequal $%02x, $%04x ; TEMP" % (arg1, arg2))
		elif byte == 0x07:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(2), "little")
			print("\tifnotequal $%02x, $%04x ; TEMP" % (arg1, arg2))
		elif byte == 0x08:
			arg = int.from_bytes(file.read(2), "little")
			print("\tiffalse $%04x ; TEMP" % arg)
		elif byte == 0x09:
			arg = int.from_bytes(file.read(2), "little")
			print("\tiftrue $%04x ; TEMP" % arg)
		elif byte == 0x0a:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(2), "little")
			print("\tifgreater $%02x, $%04x ; TEMP" % (arg1, arg2))
		elif byte == 0x0b:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(2), "little")
			print("\tifless $%02x, $%04x ; TEMP" % (arg1, arg2))
		elif byte == 0x0c:
			arg = int.from_bytes(file.read(2), "little")
			print("\tjumpstd $%04x ; TEMP" % arg)
		elif byte == 0x0d:
			arg = int.from_bytes(file.read(2), "little")
			print("\tcallstd $%04x ; TODO" % arg)
		elif byte == 0x0e:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(2), "little")
			print("\tcallasm $%02x, $%04x ; TEMP" % (arg1, arg2))
		elif byte == 0x0f:
			arg = int.from_bytes(file.read(2), "little")
			print("\tspecial $%04x ; TODO" % arg)

		elif byte == 0x10:
			arg = int.from_bytes(file.read(2), "little")
			print("\tmemcallasm $%04x ; TEMP" % arg)
		elif byte == 0x11:
			arg = int.from_bytes(file.read(1), "little")
			print("\tcheckmapscene $%02x ; TEMP (Must be a label)" % arg)
		elif byte == 0x12:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tsetmapscene $%02x, $%02x ; TEMP (First byte must be a label)" % (arg1, arg2))
		elif byte == 0x13:
			print("\tcheckscene")
		elif byte == 0x14:
			arg = int.from_bytes(file.read(1), "little")
			print("\tsetscene $%02x" % arg)
		elif byte == 0x15:
			arg = int.from_bytes(file.read(1), "little")
			print("\tsetval $%02x" % arg)
		elif byte == 0x16:
			arg = int.from_bytes(file.read(1), "little")
			print("\taddval $%02x" % arg)
		elif byte == 0x17:
			arg = int.from_bytes(file.read(1), "little")
			print("\trandom $%02x" % arg)
		elif byte == 0x18:
			print("\tcheckver")
		elif byte == 0x19:
			arg = int.from_bytes(file.read(2), "little")
			print("\treadmem $%04x ; TEMP" % arg)
		elif byte == 0x1a:
			arg = int.from_bytes(file.read(2), "little")
			print("\twritemem $%04x ; TEMP" % arg)
		elif byte == 0x1b:
			arg1 = int.from_bytes(file.read(2), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tloadmem $%04x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x1c:
			arg = int.from_bytes(file.read(1), "little")
			print("\treadvar $%02x" % arg)
		elif byte == 0x1d:
			arg = int.from_bytes(file.read(1), "little")
			print("\twritevar $%02x" % arg)
		elif byte == 0x1e:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tloadvar $%02x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x1f:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tgiveitem $%02x, $%02x" % (arg1, arg2))

		elif byte == 0x20:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\ttakeitem $%02x, $%02x" % (arg1, arg2))
		elif byte == 0x21:
			arg = int.from_bytes(file.read(1), "little")
			print("\tcheckitem $%02x" % arg)
		elif byte == 0x22:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			arg3 = int.from_bytes(file.read(1), "little")
			arg4 = int.from_bytes(file.read(1), "little")
			print("\tgivemoney $%02x, $%02x, $%02x, $%02x ; TODO" % (arg1, arg2, arg3, arg4))
		elif byte == 0x23:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			arg3 = int.from_bytes(file.read(1), "little")
			arg4 = int.from_bytes(file.read(1), "little")
			print("\ttakemoney $%02x, $%02x, $%02x, $%02x ; TODO" % (arg1, arg2, arg3, arg4))
		elif byte == 0x24:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			arg3 = int.from_bytes(file.read(1), "little")
			arg4 = int.from_bytes(file.read(1), "little")
			print("\tcheckmoney $%02x, $%02x, $%02x, $%02x ; TODO" % (arg1, arg2, arg3, arg4))
		elif byte == 0x25:
			arg = int.from_bytes(file.read(2), "little")
			print("\tgivecoins $%04x" % arg)
		elif byte == 0x26:
			arg = int.from_bytes(file.read(2), "little")
			print("\ttakecoins $%04x" % arg)
		elif byte == 0x27:
			arg = int.from_bytes(file.read(2), "little")
			print("\tcheckcoins $%04x" % arg)
		elif byte == 0x28:
			arg = int.from_bytes(file.read(1), "little")
			print("\taddcellnum $%02x" % arg)
		elif byte == 0x29:
			arg = int.from_bytes(file.read(1), "little")
			print("\tdelcellnum $%02x" % arg)
		elif byte == 0x2a:
			arg = int.from_bytes(file.read(1), "little")
			print("\tcheckcellnum $%02x" % arg)
		elif byte == 0x2b:
			arg = int.from_bytes(file.read(1), "little")
			print("\tchecktime $%02x" % arg)
		elif byte == 0x2c:
			arg = int.from_bytes(file.read(1), "little")
			print("\tcheckpoke $%02x" % arg)
		elif byte == 0x2d:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			arg3 = int.from_bytes(file.read(1), "little")
			arg4 = int.from_bytes(file.read(1), "little")
			arg5 = int.from_bytes(file.read(2), "little")
			arg6 = int.from_bytes(file.read(2), "little")
			print("\tgivepoke $%02x, $%02x, $%02x, $%02x, $%04x, $%04x ; TEMP" % (arg1, arg2, arg3, arg4, arg5, arg6))
		elif byte == 0x2e:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tgiveegg $%02x, $%02x ; TEMP" % (arg1, arg2))
		elif byte == 0x2f:
			arg = int.from_bytes(file.read(2), "little")
			print("\tgivepokemail $%04x ; TEMP" % arg)

		elif byte == 0x30:
			arg = int.from_bytes(file.read(2), "little")
			print("\tcheckpokemail $%04x ; TEMP" % arg)
		elif byte == 0x31:
			arg = int.from_bytes(file.read(2), "little")
			print("\tcheckevent $%04x ; TEMP" % arg)

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
		elif byte == 0x4e:
			print("\tyesorno")
		elif byte == 0x4f:
			arg = int.from_bytes(file.read(2), "little")
			print("\tloadmenu $%04x ; TEMP" % arg)

		elif byte == 0x50:
			print("\tclosewindow")
		elif byte == 0x52:
			arg = int.from_bytes(file.read(2), "little")
			print("\tjumptext $%04x ; TEMP" % arg)
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

		elif byte == 0x70:
			print("\tstopfollow")
		elif byte == 0x7a:
			print("\treloadmap")
		elif byte == 0x7e:
			arg = int.from_bytes(file.read(2), "little")
			print("\tplaymusic $%04x ; TEMP" % arg)

		elif byte == 0x80:
			arg1 = int.from_bytes(file.read(2), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			print("\tmusicfadeout $%04x, $%02x ; TEMP" % (arg1, arg2))
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

		elif byte == 0xa0:
			print("\tcredits")
		elif byte == 0xa1:
			arg1 = int.from_bytes(file.read(1), "little")
			arg2 = int.from_bytes(file.read(1), "little")
			arg3 = int.from_bytes(file.read(1), "little")
			arg4 = int.from_bytes(file.read(1), "little")
			arg5 = int.from_bytes(file.read(1), "little")
			print("\twarpfacing $%02x, $%02x, $%02x, $%02x, $%02x ; TEMP" % (arg1, arg2, arg3, arg4, arg5))

#print(chars)
