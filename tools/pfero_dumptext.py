#!/usr/bin/env python3

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('offset')
parser.add_argument('count', nargs='?')
parser.add_argument('-s', '--short', action='store_false')
parser.add_argument('-t', '--text-script', action='store_true')
parser.add_argument('-l', '--labels')
args = parser.parse_args()

chars = {}

file = "../baserom.gbc"

for line in open("../charmap.asm"):
    if line.startswith("\tcharmap "):
        line = line[9:].split(";")[0].split(",")
        if len(line) != 2:
            continue

        char = line[0].strip()[1:-1]
        byte = int(line[1].strip()[1:], 16)

        if byte not in chars:
            chars[byte] = char


if args.labels:
    labelsfile = open(args.labels.split(":")[0])
    labelslabel = args.labels.split(":")[1]
    nextlabel = ""
    for line in labelsfile:
        if line.startswith(labelslabel + ":"):
            nextlabel = line
            break
    for line in labelsfile:
        if line[0] == ' ' or line[0] == '\t' or line[0] == '\n':
            break
        nextlabel += line

def getnextlabel():
    global nextlabel
    ret = nextlabel
    for line in labelsfile:
        if line[0] != ' ' and line[0] != '\t' and line[0] != '\n':
            nextlabel = line
            break
    for line in labelsfile:
        if line[0] == ' ' or line[0] == '\t' or line[0] == '\n':
            break
        nextlabel += line

    if not nextlabel:
        nextlabel = "; text"

    return ret


file = open(file, "rb")
file.seek(int(args.offset, 0))

count = 1
if args.count:
    count = int(args.count, 0)

def print_text():
    done = 0
    while True:
        byte = int.from_bytes(file.read(1), "little")
        if not byte:
            break

        char = chars[byte]
        if char == "<NEXT>":
            print("\"")
            print("\tnext \"", end="")
        elif char == "<PARA>":
            print("\"\n")
            print("\tpara \"", end="")
        elif char == "<LINE>":
            print("\"")
            print("\tline \"", end="")
        elif char == "<CONT>":
            print("\"")
            print("\tcont \"", end="")
        elif char == "<DONE>":
            print("\"\n\tdone")
            done = 1
            break
        elif char == "<PROMPT>":
            print("\"\n\tprompt")
            done = 1
            break
        else:
            print(char, end="")

        if char == "@":
            break
    return done

while count != 0:
    count -= 1

    if args.labels:
        print(getnextlabel(), end="")

    if not args.text_script:
        if args.short:
            print("\tdb \"", end="")
        else:
            print("\tdb   \"", end="")
        done = print_text()
        if not done:
            if args.short:
                print("\"")
            else:
                print("\"\n")
        continue

    while True:
        byte = int.from_bytes(file.read(1), "little")

        if byte == 0:
            print("\ttext \"", end="")
            if print_text():
                break
            else:
                print("\"")
        elif byte == 0x01:
            arg = int.from_bytes(file.read(2), "little")
            print("\ttext_ram $%04x ; TEMP" % arg)
        elif byte == 0x02:
            arg1 = int.from_bytes(file.read(2), "little")
            arg2 = int.from_bytes(file.read(1), "little")
            print("\ttext_bcd $%04x, $%02x ; TEMP" % (arg1, arg2))
        elif byte == 0x03:
            arg = int.from_bytes(file.read(2), "little")
            print("\ttext_move $%04x ; TEMP" % arg)
        elif byte == 0x04:
            arg1 = int.from_bytes(file.read(2), "little")
            arg2 = int.from_bytes(file.read(1), "little")
            arg3 = int.from_bytes(file.read(1), "little")
            print("\ttext_box $%04x, $%02x, $%02x ; TEMP" % (arg1, arg2, arg3))
        elif byte == 0x05:
            print("\ttext_low")
        elif byte == 0x06:
            print("\ttext_promptbutton")
        elif byte == 0x07:
            print("\ttext_scroll")
        elif byte == 0x08:
            print("\ttext_asm")
            print("\t; h-haha")
            break
        elif byte == 0x09:
            arg1 = int.from_bytes(file.read(2), "little")
            arg2 = int.from_bytes(file.read(1), "little")
            arg2_1 = (arg2 >> 4) & 0xf
            arg2_2 = arg2 & 0xf
            print("\ttext_decimal $%04x, $%01x, $%01x ; TEMP" % (arg1, arg2_1, arg2_2))
        elif byte == 0x0a:
            print("\ttext_pause")
        elif byte == 0x0b:
            print("\tsound_dex_fanfare_50_79")
        elif byte == 0x0c:
            arg = int.from_bytes(file.read(1), "little")
            print("\ttext_dots $%02x ; TEMP" % arg)
        elif byte == 0x0d:
            print("\ttext_linkpromptbutton")
        elif byte == 0x0e:
            print("\tsound_dex_fanfare_20_49")
        elif byte == 0x0f:
            print("\tsound_item")
        elif byte == 0x10:
            print("\tsound_caught_mon")
        elif byte == 0x11:
            print("\tsound_dex_fanfare_80_109")
        elif byte == 0x12:
            print("\tsound_fanfare")
        elif byte == 0x13:
            print("\tsound_slot_machine_start")
        elif byte == 0x14:
            arg = int.from_bytes(file.read(1), "little")
            print("\ttext_buffer $%02x ; TEMP" % arg)
        elif byte == 0x15:
            print("\ttext_today")
        elif byte == 0x16:
            arg1 = int.from_bytes(file.read(2), "little")
            arg2 = int.from_bytes(file.read(1), "little")
            print("\ttext_far $%04x, $%02x ; TEMP" % (arg1, arg2))
        elif byte == 0x50:
            print("\ttext_end")
            break
    if not args.short or args.text_script:
        print()
