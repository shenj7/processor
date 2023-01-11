from argparse import ArgumentParser
import subprocess
import shlex
import sys

def command_line_parser(main_args):
    parser = ArgumentParser(description="translate violet team instructions to machine language. does not check whether an immediate is small enough, or if the register is within range")
    parser.add_argument('-i',
                        '--instruction',
                        required=True,
                        help="instruction to translate, as a string")
    args = parser.parse_args(main_args)
    return args


def typeswitch(inst):
    rlen = 4
    ilen = 3
    mlen = 4
    instlen = len(inst)
    func = inst[0]
    if func in ["add", "grt", "sub", "eq"]:
        return rtype_parse(inst) if instlen == rlen else f"malformed instruction, should be length {rlen}"
    elif func in ["addi", "jalr", "lui"]:
        return itype_parse(inst) if instlen == ilen else f"malformed instruction, should be length {ilen}"
    elif func in ["lwr", "swr", "bne"]:
        return mtype_parse(inst) if instlen == mlen else f"malformed instruction, should be length {mlen}"
    else:
        return "incorrect instruction"

def make_4bin(dec):
    return ('{0:04b}').format(int(dec))


def make_8bin(dec):
    return ('{0:08b}').format(int(dec))


def rtype_parse(inst):
    rs2, rs1, rd, op, func2 = make_4bin(inst[3]), make_4bin(inst[2]), make_4bin(inst[1]), "", ""
    func = inst[0]
    if func in ["add", "grt", "sub", "eq"]:
        op = "00"
    else:
        op = "11"

    if func in ["add", "jalr"]:
        func2 = "00"
    elif func == "grt":
        func2 = "01"
    elif func == "sub":
        func2 = "10"
    elif func == "eq":
        func2 = "11"
    else:
        return f"instruction not found: {func}"

    return rs2 + rs1 + rd + op + func2


def itype_parse(inst):
    #TODO: add size checking for immmidiate
    imm, rd, op, func2 = make_8bin(inst[2]), make_4bin(inst[1]), "01", ""
    func = inst[0]

    if func == "addi":
        func2 = "00"
    elif func == "jalr":
        func2 = "01"
    elif func == "lui":
        func2 = "10"
    else:
        return f"instruction not found: {func}"

    return imm + rd + op + func2


def mtype_parse(inst):
    #TODO: add size checking for immmidiate
    imm, rs2, rs1, op, func2 = make_4bin(inst[3]), make_4bin(inst[2]), make_4bin(inst[1]), "10", ""
    func = inst[0]

    if func == "lw":
        func2 = "00"
    elif func == "sw":
        func2 = "01"
    elif func == "bne":
        func2 = "10"
    else:
        return f"instruction not found: {func}"
    return imm + rs2 + rs1 + op + func2


def reg_trans(reg):
    if reg[0] == 'x' or reg[0].isdigit():
        return reg[1:]
    elif reg == "zero":
        return "0"
    elif reg == "ra":
        return "1"
    elif reg == "sp":
        return "2"
    elif reg == "at":
        return "15"
    elif reg[0] == 't':
        return f"{int(t[1:])+3}"
    elif reg[0] == 's':
        return f"{int(t[1:])+5}"
    elif reg[0] == 'a':
        return f"{int(t[1:])+10}"
    else:
        return "bad reg"


def parse_inst(inst):
    registers = inst.replace(",", "").split(" ")
    instruction = [registers[0]]
    registers = registers[1:]
    for register in registers:
        instruction.append(reg_trans(register))

    return instruction


def main(main_args=""):
    #TODO: add aliases for registers (x1 -> ra, etc)
    args = command_line_parser(main_args)
    instruction = parse_inst(args.instruction)
    machine_code = typeswitch(instruction)
    print(machine_code)

if __name__ == '__main__':
    main(sys.argv[1:])
