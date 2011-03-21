# encoding: UTF-8
from qsayacc import parser, configure_yaml
import yaml


def generatecode(obj):
    objlist = gc(obj)
    indent = "    "
    txt = []
    depth = 0
    for obj in objlist:
        txt.append(indent*depth + obj)
        
    return "\n".join(txt) + "\n"
    

def gc(obj):
    if type(obj) is not dict: return obj
    objtype = ["gc"] + str(obj['type']).split(".")
    function = None
    lookedfor = []
    while function is None:
        try:
            fname = "_".join(objtype)
            lookedfor.append(fname)
            function = globals()[fname]
        except KeyError:
            if len(objtype) > 2: 
                objtype = objtype[:-1]
            else:
                print "FATAL: No function suitable found for type %s" % repr(obj['type'])
                print "function list that we've looked for: %s" % " , ".join(lookedfor)
                return None
        
    return function(obj)

def gc_instructionset(obj):
    source = []
    for instruction in obj['instructionlist']:
        source.append(gc(instruction))
    return source

def gc_instruction_error(obj):
    return "# " + obj['value']

def gc_instruction_expression(obj):
    ret = gc(obj['value'])
    if 'warning' in obj:
        ret += " # WARN: %(warning)s" % obj
    return ret
    
def gc_expression_math(obj):
    objtype = str(obj['type']).split(".")
    operatorname = objtype[-1]
    operator_tr = { # traduccion de operadores matemáticos
        "PLUS" : "+",
        "TIMES" : "*",
        "MINUS" : "-",
        "DIV" : "/",
        "MOD" : "%",
    }
    operator = operator_tr[operatorname]
    #print operatorname, obj['valuelist']
    return (" %s " % operator).join([ str(gc(x)) for x in obj['valuelist'] ])

def gc_instruction_assigment(obj):
    objtype = str(obj['type']).split(".")
    operatorname = objtype[-1]
    operator_tr = { # traduccion de operadores de asignación
        "EQUALS" : "=",
        "PLUSPLUS" : "+= 1",
        "PLUSEQUAL" : "+=",
        "MINUSMINUS" : "-= 1",
        "MINUSEQUAL" : "-=",
        "TIMESEQUAL" : "*=",
        "DIVEQUAL" : "/=",
        "MODEQUAL" : "%=",
    }
    
    obj['operator'] = operator_tr[operatorname]
    obj['final_dest'] = gc(obj['dest'])
    
    if 'value' in obj:
        obj['final_value'] = gc(obj['value'])
        return "%(final_dest)s %(operator)s %(final_value)s" % obj
    else:
        return "%(final_dest)s %(operator)s" % obj

def gc_reference(obj):
    objtype = str(obj['type']).split(".")
    reftype = objtype[-1] # ID , arrayelement
    id_tr = { # Traduccion de nombres de variable.
        "this" : "self",
        "self" : "self_",
    }
    fullid = obj['parent'] 
    if reftype == "ID":
        fullid.append(obj['value'])
    
    final_fullid1 = [ gc(x) for x in fullid ]
    final_fullid2 = map(lambda x: id_tr[x] if x in id_tr else x, final_fullid1)
    txtfullid = ".".join(final_fullid2)

    if reftype == "ID":
        pass
    elif reftype == "arrayelement":
        txtfullid+="[%s]" % gc(obj['value'])
    else:
        print "FATAL: unknown reference type %s" % repr(reftype)
    return txtfullid

def gc_call(obj):
    obj['final_method'] = gc(obj['method'])
    obj['final_args'] = ", ".join([str(gc(x)) for x in obj['args'] ])
    
    return "%(final_method)s(%(final_args)s)" % obj
    





def convert(source):
    result = parser.parse(source)
    return generatecode(result)

def main():
    import sys
    configure_yaml()
    
    if len(sys.argv) > 1:
        s = " ".join(sys.argv[1:])
        print "Input program:"
        print s
        print
        result = parser.parse(s)
        print "YAML Interpretation:"
        print yaml.dump(result)
        print
        print "Output:"
        print generatecode(result)
        print
        sys.exit(0)

    

  
if __name__ == "__main__":
    main()