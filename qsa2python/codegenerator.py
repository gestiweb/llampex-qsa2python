# encoding: UTF-8
from qsayacc import parser, configure_yaml
import yaml,sys


def generatecode(obj):
    objlist = gc(obj)
    indent = "    "
    txt = []
    flatcode = flattencode(objlist)
    #print repr(flatcode)
    for depth,obj in flatcode:
        txt.append(indent*depth + str(obj))
        
    return "\n".join(txt) + "\n"

def flattencode(objlist, depth = 0):
    if not objlist: return []
    flatval = []
    for obj in objlist:
        if type(obj) is list:
            newlines = flattencode(obj, depth+1)
            flatval += newlines
            if depth == 0:
                flatval.append( (depth, "") )
            if len(newlines)>10:
                flatval.append( (depth, "") )
        else:
            flatval.append( (depth, obj) )
    return flatval
        
    

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
                ret = [
                    "\"\"\"",
                    "   FATAL: No function suitable found for type %s" % repr(obj['type']),
                    "   function list that we've looked for: %s" % " , ".join(lookedfor),
                    "   YAML Interpretation:",
                    "",
                ]
                ret += [ "        " + line for line in (yaml.dump(obj)).split("\n") ]
                ret.append('"""')
                return "\n".join(ret)
        
    return function(obj)

def gc_instructionset(obj):
    source = []
    for instruction in obj['instructionlist']:
        val = gc(instruction)
        if type(val) is list: source += val
        else: source.append(val)
        if 'newline' in instruction:
            if instruction['newline']:
                source.append("")
                
    return source
    
def gc_instruction_error(obj):
    return "# " + obj['value']
    
def gc_instruction_comment(obj):
    return [ "# %s " % x for x in obj['value'] ]

def gc_vardef(obj):
    #name: b, type: vardef, value: null, vartype: String
    ret = obj['name']
    if obj['value'] is not None:
        ret += " = " + gc(obj['value'])
    return ret

def gc_instructionblock(obj):
    return gc(obj['value'])

def gc_instruction_function(obj):
    arglist = obj['argumentlist']
    obj['finalarglist'] = ", ".join([gc(arg) for arg in arglist])
    ret = []
    ret.append("def %(name)s(%(finalarglist)s):" % obj)
    ret.append(gc(obj['source']))
    return ret
    
def gc_instruction_expression(obj):
    ret = str(gc(obj['value']))
    if 'warning' in obj:
        ret += " # WARN: %(warning)s" % obj
    return ret

def gc_instruction_vardef(obj):
    ret = gc(obj['value'])
    if obj['value']['value'] is None:
        ret += " = None"
        
    if 'vartype' in obj['value']:
        ret += " # type: %(vartype)s" % obj['value']
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
        "true" : "True",
        "false" : "False",
        "null" : "None"
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
        print >> sys.stderr, "FATAL: unknown reference type %s" % repr(reftype)
    return txtfullid

def gc_call(obj):
    obj['final_method'] = gc(obj['method'])
    obj['final_args'] = ", ".join([str(gc(x)) for x in obj['args'] ])
    
    return "%(final_method)s(%(final_args)s)" % obj
    



opts = None

def convert(source):
    result = parser.parse(source)
    return generatecode(result)
    
def debug_convert(s):
    global opts
    #print "Input program:"
    #print s
    #print
    result = parser.parse(s)
    if opts.yaml:
        print 
        print "YAML Output:"
        print
        print yaml.dump(result)
    #print
    #print "Output:"
    code = generatecode(result)
    print
    print code
    print
    return code
    

def main():
    import sys
    from optparse import OptionParser
    parser = OptionParser()
    parser.set_defaults( stdin = False, filename = False, source = False, yaml = False)
    parser.add_option("-f", "--file",
                  action="store_true", dest="filename")
    parser.add_option("-s", "--source",
                  action="store_true", dest="source")
    parser.add_option("-i", "--stdin",
                  action="store_true", dest="stdin")
    parser.add_option("--yaml",
                  action="store_true", dest="yaml")
                  
    configure_yaml()
    (options, args) = parser.parse_args()
    global opts 
    opts = options
    if options.stdin + options.filename + options.source != 1:
        print >> sys.stderr, "ERROR: debe especificar EXACTAMENTE uno de los siguientes flags: -f -s -i"
        sys.exit(1)
        
    if options.source:
        s = " ".join(args)
        debug_convert(s)
        sys.exit(0)

    if options.stdin:
        debug_convert(sys.stdin.read())
        sys.exit(0)

    if options.filename:
        for filename in args:
            debug_convert(open(filename).read())
        sys.exit(0)

    

  
if __name__ == "__main__":
    main()
