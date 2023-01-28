from argparse import ArgumentParser
import subprocess
import shlex
import sys
from translate_instruction import parse_inst, typeswitch

def command_line_parser(main_args):
    parser = ArgumentParser(description="translate violet team instructions to machine language. does not check whether an immediate is small enough, or if the register is within range")
    parser.add_argument('-i',
                        '--instructions',
                        nargs="+",
                        help="instruction to translate, as a string")
    args = parser.parse_args(main_args)
    return args


def main(main_args=""):
    #TODO: add aliases for registers (x1 -> ra, etc)
    args = command_line_parser(main_args)
    instructions = args.instructions
    for instruction in instructions:
        instruction = parse_inst(instruction)
        print(typeswitch(instruction))

if __name__ == '__main__':
    main(sys.argv[1:])
