InputFile = open('../Data/test.fa','r')
seq = ''

print("chromsome\tA\tT\tC\tG\tN\tlength")

line = InputFile.upper()
if line[0] == '>' and seq == '':
    header = line.strip()
elif line[0] != '>':
    seq = seq + line.strip()
elif line[0] == '>' and seq != '':
    print(header,end='\t')
    length = len(seq)
for nt in "ATCGN":
    if nt == "N":
        print(str(seq.count(nt))+"\t"+str(length),end='\n')
    else:
        print(seq.count(nt),end='\t')
        seq = ''
        header = line.strip()

print(header,end='\t')
length = len(seq)
for nt in "ATCGN":
    if nt == "N":
        print(str(seq.count(nt))+"\t"+str(length),end='\n')
    else:
        print(seq.count(nt),end='\t')
        
InputFile.close()