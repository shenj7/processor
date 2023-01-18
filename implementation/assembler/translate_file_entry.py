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


def get_labels(file, starting_add):
    labels = dict()
    address = starting_add
    file.seek(0)
    for instruction in file:
        loc = instruction.find(":")
        if loc != -1:
            label = instruction[0:loc]
            labels[label] = address
        address = address + 2

    return labels


def replace_label(new_inst, labels):
    replaced = ""
    for label in labels:
        if label in new_inst:
            replaced = new_inst.replace(label, str(labels[label]))
        else:
            replaced = new_inst

    return replaced


def make_machine_file(file, labels):
    f = open(file.name + "_machine", "w")
    file.seek(0)
    for instruction in file:
        loc = instruction.find(":")
        new_inst = ""
        if loc != -1:
            new_inst = instruction[loc+1:]
        else:
            new_inst = instruction
        print(new_inst)
        print(labels)
        new_inst = replace_label(new_inst, labels)
        new_inst = typeswitch(parse_inst(new_inst))
        f.write(new_inst)

    return f



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
