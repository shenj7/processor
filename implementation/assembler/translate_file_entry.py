from argparse import ArgumentParser
import subprocess
import shlex
import sys
from translate_instruction import parse_inst, typeswitch

def command_line_parser(main_args):
    parser = ArgumentParser(description="translate violet team instructions to machine language. does not check whether an immediate is small enough, or if the register is within range")
    parser.add_argument('-f',
                        '--file',
                        help="file to translate")
    args = parser.parse_args(main_args)

    return args


def get_labels(f, starting_add):
    labels = dict()
    address = starting_add
    f.seek(0)
    for instruction in f:
        loc = instruction.find(":")
        if loc != -1:
            label = instruction[0:loc]
            #should label be address or address/2?
            labels[label] = str(address)
        address = address + 2

    return labels


def replace_label(new_inst, labels):
    replaced = ""
    split_inst = new_inst.split(" ")
    split_inst[-1] = split_inst[-1].strip()
    if split_inst[-1] in labels:
        split_inst[-1] = labels[split_inst[-1]]
    replaced = " ".join(split_inst)
    print(replaced)
    return replaced


def make_machine_file(f, labels):
    fm = open(f.name + "_machine", "w")
    f.seek(0)
    print(labels)
    for instruction in f:
        if not instruction.strip():
            continue
        loc = instruction.find(":")
        new_inst = ""
        if loc != -1:
            new_inst = instruction[loc+2:]
        else:
            new_inst = instruction
        new_inst = replace_label(new_inst, labels)
        new_inst = parse_inst(new_inst)
        new_inst = typeswitch(new_inst)
        fm.write(new_inst)
        fm.write("\n")

    return fm



def main(main_args=""):
    args = command_line_parser(main_args)
    file = args.file
    f = open(file, "r")
    labels = get_labels(f, 0)
    newfile = make_machine_file(f, labels)
    print(f"machine translation for {file} written to {newfile.name}")


    f.close()
    newfile.close()


if __name__ == '__main__':
    main(sys.argv[1:])
