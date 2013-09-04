

def get_businesses(filename):
    lines=open(filename).readlines()
    names=lines[0][:-1].split(';')
    businesses=[]
    for line in lines[1:]:
        parts=line[:-1].split(';')
        if len(parts)!=len(names):
            print "Invalid number of parts: "+str(len(parts))+"; expected: "+str(len(names))
            continue
        else:
            business={}
            for i in range(len(names)):
                part=parts[i]
                name=names[i]
                business[name]=part
            businesses.append(business)
    return businesses


