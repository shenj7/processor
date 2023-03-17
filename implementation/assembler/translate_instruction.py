def typeswitch(inst):
    rlen = 4
    ilen = 3
    mlen = 4
    instlen = len(inst)
    func = inst[0]
    if func in ["add", "grt", "sub", "eq", "jalr", "bne"]:
        return rtype_parse(inst) if instlen == rlen else f"malformed instruction, should be length {rlen}"
    elif func in ["lui", "lli", "jal"]:
        return itype_parse(inst) if instlen == ilen else f"malformed instruction, should be length {ilen}"
    elif func in ["addi", "lw", "sw", "wri", "rea"]:
        return mtype_parse(inst) if instlen == mlen else f"malformed instruction, should be length {mlen}"
    else:
        return "incorrect instruction"

def make_4bin(dec):
    #does twos complement: https://stackoverflow.com/questions/21871829/twos-complement-of-numbers-in-python
    num = int(dec)
    return format(num if num >= 0 else (1 << 4) + num, '04b')
    #return ('{0:04b}').format(int(dec))


def make_8bin(dec):
    num = int(dec)
    return format(num if num >= 0 else (1 << 8) + num, '08b')
    #return ('{0:08b}').format(int(dec))


def rtype_parse(inst):
    rs2, rs1, rd, iid = make_4bin(inst[3]), make_4bin(inst[2]), make_4bin(inst[1]), ""
    func = inst[0]

    if func == "add":
        iid = "0000"
    elif func == "grt":
        iid = "0001"
    elif func == "sub":
        iid = "0010"
    elif func == "eq":
        iid = "0011"
    elif func == "jalr":
        iid = "0100"
    elif func == "bne":
        iid = "1011"
    else:
        return f"instruction not found: {func}"

    return rs2 + rs1 + rd + iid


def itype_parse(inst):
    #TODO: add size checking for immmidiate
    imm, rd, iid = make_8bin(inst[2]), make_4bin(inst[1]), ""
    func = inst[0]

    if func == "lui":
        iid = "0101"
    elif func == "jal":
        iid = "0110"
    elif func == "lli":
        iid = "1111"
    else:
        return f"instruction not found: {func}"

    return imm + rd + iid


def mtype_parse(inst):
    #TODO: add size checking for immmidiate
    imm, rs1, rd, iid = make_4bin(inst[3]), make_4bin(inst[2]), make_4bin(inst[1]), ""
    func = inst[0]

    if func == "addi":
        iid = "1000"
    elif func == "lw":
        iid = "1001"
    elif func == "sw":
        iid = "1010"
    elif func == "wri":
        iid = "1100"
    elif func == "rea":
        iid == "1101"
    else:
        return f"instruction not found: {func}"
    return imm + rs1 + rd + iid


def reg_trans(reg):
    if reg[0] == 'x':
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
        return f"{int(reg[1:])+3}"
    elif reg[0] == 's':
        return f"{int(reg[1:])+5}"
    elif reg[0] == 'a':
        return f"{int(reg[1:])+10}"
    else:
        return reg


def parse_inst(inst):
    registers = inst.replace(",", "").split(" ")
    instruction = [registers[0]]
    registers = registers[1:]
    # r type: [id, rd, rs1, rs2]
    # i type: [id, rd, imm]
    # m type: [id, rs1, rs2, imm]
    for register in registers:
        instruction.append(reg_trans(register))
    return instruction
