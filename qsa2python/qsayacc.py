# encoding: UTF-8
import ply.yacc as yacc
from qsalexer import tokens
import sys
import pprint
prettyprint = pprint.PrettyPrinter(depth=4,indent = 8)
pformat = prettyprint.pformat

global last_error_lextoken
global last_ok_pos
last_error_lextoken = None
last_ok_pos = None
precedence = (
    ('left', 'PLUS', 'MINUS'),
    ('left', 'TIMES', 'DIVIDE'),
    ('left', 'ICONST', 'SCONST', 'FCONST', 'CCONST', 'RXCONST', 'ID'),
    ('left', 'LT', 'GT', 'LE', 'GE', 'EQ', 'NE'),
    ('left', 'LNOT', 'LAND', 'LOR'),
    ('left', 'LPAREN', 'RPAREN'),
    ('left', 'LBRACKET', 'RBRACKET'),
    ('right', 'IF','ELSE'),
    ('left', 'LBRACE', 'RBRACE'),
    ('left', 'NEWLINE'),
    ('left', 'SEMI', 'COMMENTBLOCKSTART', 'RAWDATA', 'COMMENTBLOCKEND'), # -- importante para poder tener puntoycoma opcional!
)


def update_lexpos(p):
    global last_ok_pos
    lexpos1 = [ p.lexspan(i) for i in range(1,len(p)) ]
    lexpos2 = filter( lambda (x,y): x>0 and y>0, lexpos1)
    lexpos2a = [x for x,y in lexpos2 ]
    lexpos2b = [y for x,y in lexpos2 ]
    for element in p[1:]:
        if type(element) is not dict: continue
        if 'lexpos' not in element: continue
        lexpos2a.append(element['lexpos'][0])
        lexpos2b.append(element['lexpos'][1])
        
    if type(p[0]) is dict and len(lexpos2) > 0:
        p[0]['lexpos'] = [min(lexpos2a),max(lexpos2b)]
        last_ok_pos = max(p[0]['lexpos'] + [last_ok_pos])

def p_empty(p):
    'empty :'
    pass

# Constante: Valor inmediato. Entero, Float, String, Carácter, Expresión regular.
def p_const(p): 
    '''const : ICONST
             | FCONST
             | SCONST
             | CCONST
             | RXCONST
    '''
    if p.slice[1].type == "ICONST":
        p[1] = int(p[1])
    if p.slice[1].type == "FCONST":
        p[1] = float(p[1])
    if p.slice[1].type == "SCONST":
        p[1] = p[1] #str(p[1][1:-1])
    if p.slice[1].type == "CCONST":
        p[1] = p[1] #str(p[1][1:-1])
    if debug > 4:
        p[0] = { 'type' : 'const.%s' % p.slice[1].type, 'value' : p[1] }
    else:
        p[0] = p[1]
    update_lexpos(p)
    
def p_listvalues(p):
    '''
    listvalues  : expression
                | listvalues COMMA expression
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'expression': 
        p[0] = [p[1]]
    elif typelist == 'listvalues COMMA expression': 
        p[0] = p[1] + [p[3]]
    else:
        print >> sys.stderr, "PANIC: Unknown argument list %s" % repr(typelist)
        
    
def p_list(p):
    '''
    list : LBRACKET RBRACKET
         | LBRACKET listvalues RBRACKET
    '''
    
    p[0] = { 'type': 'list', 'valuelist' : [] }
    
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'LBRACKET listvalues RBRACKET': 
        p[0]['valuelist'] = p[2]

    update_lexpos(p)

# Expresión: combinación de elementos que devuelven un valor computado.
def p_expression_math(p):
    '''
    expression : expression PLUS expression
               | expression MINUS expression
               | expression TIMES expression
               | expression DIVIDE expression
    '''
        
    p[0] = { 'type': 'expression.math.%s' % p.slice[2].type, 'valuelist' : [p[1], p[3] ] }
    if type(p[1]) is dict:
        if p[1]['type'] == p[0]['type']:
            del p[0]['valuelist'][0]
            p[0]['valuelist'] = p[1]['valuelist'] + p[0]['valuelist'] 
    update_lexpos(p)
            
def p_expression_compare(p):
    '''
    expression : expression LT expression
               | expression LE expression
               | expression GT expression
               | expression GE expression
               | expression EQ expression
               | expression NE expression
    '''
    p[0] = { 'type': 'expression.compare.%s' % p.slice[2].type, 'valuelist' : [p[1], p[3] ] }
    update_lexpos(p)
                        
def p_expression_boolcompare(p):
    '''
    expression : expression LOR expression
               | expression LAND expression
    '''
    p[0] = { 'type': 'expression.boolcompare.%s' % p.slice[2].type, 'valuelist' : [p[1], p[3] ] }
    update_lexpos(p)
            
def p_expression_unary(p):
    '''
    expression : LNOT expression
    '''
    p[0] = { 'type': 'expression.unary.%s' % p.slice[1].type, 'value' : p[2] }
    update_lexpos(p)
            
    

def p_expression_paren(p):
    '''
    expression : LPAREN expression RPAREN
    '''
    p[0] = { 'type': 'expression.paren', 'value' : p[2] }
    update_lexpos(p)
        


def p_expression_value(p):
    '''
    expression : const
               | reference
               | call
               | newinstance
               | list
    '''
    if debug > 5:
        p[0] = { 'type': 'expression.%s' %  p.slice[1].type, 'value' : p[1] }
    else:
        p[0] = p[1]
    update_lexpos(p)


# Referencia: Variable con nombre que se debe acceder para obtener el valor.
def p_reference(p):
    '''
    reference   : ID
                | reference PERIOD ID
                | call PERIOD ID
                | reference LBRACKET expression RBRACKET
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'ID': 
        p[0] = { 'type' : 'reference.ID', 'value' : p[1], 'parent' : [] }
    elif typelist == 'reference PERIOD ID':
        if p[1]['type'] == "reference.ID":
            parent = p[1]['parent'] + [p[1]['value']]
        else:
            parent = [p[1]]
        p[0] = { 'type' : 'reference.ID', 'value' : p[3], 'parent' : parent}
    elif typelist == 'call PERIOD ID': 
        parent = p[1]['method']['parent'] + [p[1]]
        p[1]['method']['parent'] = []
        p[0] = { 'type' : 'reference.ID', 'value' : p[3], 'parent' : parent}
    elif typelist == 'reference LBRACKET expression RBRACKET': 
        parent = p[1]['parent'] + [p[1]['value']]
        p[0] = { 'type' : 'reference.arrayelement', 'value' : p[3], 'parent' : parent}
    else:
        print >> sys.stderr, "PANIC: Unknown argument list %s" % repr(typelist)
    update_lexpos(p)
    
# Llamada: Ejecución de una función a la que apunta la referencia
def p_call(p):
    '''
    call : reference argumentlist
    '''
    p[0] = { 'type' : 'call', 'method' : p[1] , 'args' : p[2]}
    update_lexpos(p)

def p_newinstance(p):
    '''
    newinstance : NEW reference argumentlist
    '''
    p[0] = { 'type' : 'newinstance', 'method' : p[2] , 'args' : p[3]}
    update_lexpos(p)

def p_newinstance_2(p):
    '''
    newinstance : NEW reference 
    '''
    p[0] = { 'type' : 'newinstance', 'method' : p[2] , 'args' : []}
    update_lexpos(p)
    

def p_argumentlist(p):
    '''
    argumentlist : LPAREN RPAREN
                 | LPAREN argumentset RPAREN
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'LPAREN RPAREN': 
        p[0] = []
    elif typelist == 'LPAREN argumentset RPAREN': 
        p[0] = p[2]
    else:
        print >> sys.stderr, "PANIC: Unknown argument list %s" % repr(typelist)
    update_lexpos(p)
    
    

def p_argumentset(p):
    '''
    argumentset : expression
                | argumentset COMMA expression
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'expression': 
        p[0] = [p[1]]
    elif typelist == 'argumentset COMMA expression': 
        p[0] = p[1] + [p[3]]
    else:
        print >> sys.stderr, "PANIC: Unknown argument set %s" % repr(typelist)
    update_lexpos(p)
    
    

# Instrucción: parte de programa que realiza una operación.  
def p_instruction_expression(p):
    '''
    instruction : expression 
    '''
    if type(p[1]) is dict:
        subtype = p[1]['type']
    else:
        subtype = "value"
    
    p[0] = { 'type': 'instruction.%s' %  p.slice[1].type, 'value' : p[1] }
    if not subtype.endswith('call'):
        p[0]['warning'] =  'Using non-call expression (%s) as instruction' % repr(subtype)
    update_lexpos(p)


def p_instruction_setinstruction(p):
    '''
    instruction : setinstruction 
    '''
    p[0] = p[1]
    update_lexpos(p)

def p_instruction_return(p):
    '''
    instruction : RETURN expression 
                | RETURN
    '''
    
    p[0] = { 'type': 'instruction.return', 'value' : None }
    if len(p) > 2:
        p[0]['value'] = p[2]    
        
    update_lexpos(p)
    

# (Instrucción) Asignación: guardar el resultado de un cómputo en una variable.
def p_setinstruction_assigment(p):
    '''
    setinstruction : reference EQUALS expression
                | reference TIMESEQUAL expression
                | reference DIVEQUAL expression
                | reference MODEQUAL expression
                | reference PLUSEQUAL expression
                | reference MINUSEQUAL expression

    '''
    p[0] = { 'type': 'instruction.assigment.%s' %  p.slice[2].type, 'dest' : p[1], 'value' : p[3] }
    update_lexpos(p)

def p_instruction_assigment_2(p):
    '''
    setinstruction : reference PLUSPLUS
                | reference MINUSMINUS
    '''
    p[0] = { 'type': 'instruction.assigment.%s' %  p.slice[2].type, 'dest' : p[1], 'direction' : 1  }
    update_lexpos(p)

def p_expression_assigment_2(p):
    '''
    expression : reference PLUSPLUS
                | reference MINUSMINUS
    '''
    p[0] = { 'type': 'instruction.assigment.%s' %  p.slice[2].type, 'dest' : p[1], 'direction' : 1  }
    update_lexpos(p)

def p_instruction_assigment_3(p):
    '''
    setinstruction : PLUSPLUS reference
                | MINUSMINUS reference
    '''
    p[0] = { 'type': 'instruction.assigment.%s' %  p.slice[1].type, 'dest' : p[2], 'direction' : -1 }
    update_lexpos(p)

def p_expression_assigment_3(p):
    '''
    expression : PLUSPLUS reference
                | MINUSMINUS reference
    '''
    p[0] = { 'type': 'instruction.assigment.%s' %  p.slice[1].type, 'dest' : p[2], 'direction' : -1  }
    update_lexpos(p)

def p_commentlines(p):
    '''
    commentlines : RAWDATA
                 | commentlines RAWDATA
    '''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = p[1]+p[2]
    update_lexpos(p)


def p_instruction_comment(p):
    '''
    instruction : COMMENTBLOCKSTART COMMENTBLOCKEND
                | COMMENTBLOCKSTART commentlines COMMENTBLOCKEND
                | COMMENTLINE
                
    '''
    p[0] = { 'type': 'instruction.comment', 'value' : ("".join(p[1:])).split("\n") }
    update_lexpos(p)


# (Instrucción) Error: Composición de instrucción errónea. Se omite.    
def p_instruction_error(p):
    '''
    instruction     : error SEMI
                    | error NEWLINE
    
    '''
    global last_error_lextoken

    charlastline3 = p.lexer.lexdata.find("\n",last_error_lextoken.lexpos+1)
    
    charlastline1 = p.lexer.lexdata.rfind("\n",0,last_error_lextoken.lexpos)
    lpos1 = len(p.lexer.lexdata[charlastline1+1:last_error_lextoken.lexpos+1].replace("\t","        "))

    charlastline2 = p.lexer.lexdata.rfind("\n",0,p.lexpos(2))
    lpos2 = len(p.lexer.lexdata[charlastline2+1:p.lexpos(2)+1].replace("\t","        "))
    
    context1 = p.lexer.lexdata[charlastline1+1:last_error_lextoken.lexpos].strip() 
    context23 = p.lexer.lexdata[last_error_lextoken.lexpos:charlastline3].strip()
    try: 
        lentok = len(p[1].value)
    except:
        lentok = 1
    context2 = context23[:lentok]
    context3 = context23[lentok:]
    
    context = "%s`%s`%s" % (context1,context2,context3)
    error = "FATAL: Syntax error in input, line %d:%d-%d:%d : %s" % (last_error_lextoken.lineno,lpos1,p[1].lineno, lpos2,repr(context))

    print >> sys.stderr, error

    p[0] =  { 'type': 'instruction.%s' %  p.slice[1].type, 'value' : error }
    update_lexpos(p)

def p_instruction_semi(p):
    '''
    instruction : instruction SEMI
    '''
    
    p[1]['semi'] = True
    p[0] =  p[1]
    update_lexpos(p)


def p_instruction_newline(p):
    '''
    instruction : instruction NEWLINE
    '''
    p[1]['newline'] = True
    p[0] =  p[1]
    update_lexpos(p)

# (Instrucción) Bloque:
def p_instruction_block(p):
    '''
    instruction : instructionblock
    '''
    
    p[0] =  { 'type': 'instructionblock', 'value' : p[1] }
    update_lexpos(p)

# Set de instrucciones: Colección de una o más instrucciones a ejecutar en orden.
def p_instructionset_empty(p):
    '''
    instructionset : SEMI
                   | NEWLINE
    '''
    p[0] = { 'type': 'instructionset', 'instructionlist' : [] }
    update_lexpos(p)


def p_instructionset(p):
    '''
    instructionset : instruction
                   | instructionset instruction
    '''
    instructionlist = []
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'instruction': 
        instructionlist = [p[1]]
    elif typelist == 'instructionset SEMI': 
        instructionlist = p[1]['instructionlist']
    elif typelist == 'instructionset SEMI instruction': 
        instructionlist = p[1]['instructionlist'] + [p[3]]
    elif typelist == 'instructionset instruction': 
        instructionlist = p[1]['instructionlist'] + [p[2]]
    else:
        print >> sys.stderr, "PANIC: Unknown instruction set %s" % repr(typelist)
    
    p[0] = { 'type': 'instructionset', 'instructionlist' : instructionlist }
    update_lexpos(p)


def p_instructionblock(p):
    '''
    instructionblock : LBRACE instructionset RBRACE
    '''
    p[0] = p[2]
    update_lexpos(p)

def p_instructionblock_empty(p):
    '''
    instructionblock : LBRACE RBRACE
    '''
    p[0] = { 'type': 'instructionset', 'instructionlist' : [] }
    update_lexpos(p)


def p_vardefopttype(p):
    '''
    vardefopttype   : empty
    '''
    p[0] = None
    update_lexpos(p)

def p_vardefoptdefval(p):
    '''
    vardefoptdefval : empty
    '''
    p[0] = None
    update_lexpos(p)
    
def p_vardefopttype2(p):
    '''
    vardefopttype   : COLON ID
    '''
    p[0] = p[2]
    update_lexpos(p)

def p_vardefoptdefval2(p):
    '''
    vardefoptdefval : EQUALS expression
    '''
    p[0] = p[2]
    update_lexpos(p)
    
def p_instruction_vardef(p):
    '''
    instruction : vardefinstruction
    '''
    p[0] = p[1]
    update_lexpos(p)

    
def p_vardefinstruction(p):
    '''
    vardefinstruction : VAR vardef
                      | CONST vardef 
    '''
    p[0] = { 'type': 'instruction.%s' %  p.slice[2].type, 'value' : p[2] }
    update_lexpos(p)

    
def p_vardef(p): # Se cambio ID por reference, para tratarlos por igual...
    '''
    vardef  : reference vardefopttype vardefoptdefval
    '''
    p[0] = {'type' : 'vardef' , 'name': p[1], 'vartype' : p[2], 'value' : p[3]}
    update_lexpos(p)
    

def p_functionargset(p):
    '''
    functionargset  : vardef
                    | functionargset COMMA vardef
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'vardef': 
        p[0] = [p[1]]
    elif typelist == 'functionargset COMMA vardef': 
        p[0] = p[1] + [p[3]]
    else:
        print >> sys.stderr, "PANIC: Unknown argument set %s" % repr(typelist)
    update_lexpos(p)

def p_functionarglist(p):
    '''
    functionarglist : LPAREN functionargset RPAREN 
                    | LPAREN RPAREN
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'LPAREN functionargset RPAREN': 
        p[0] = p[2]
    elif typelist == 'LPAREN RPAREN': 
        p[0] = []
    else:
        print >> sys.stderr, "PANIC: Unknown argument set %s" % repr(typelist)
    update_lexpos(p)
    

# TODO: flow-control instructions: for, while, if, class, function, ..
def p_instruction_if(p):
    '''
    instruction : IF LPAREN expression RPAREN instruction
                | IF LPAREN expression RPAREN instruction ELSE instruction
    '''
    p[0] = { 'type' : 'instruction.if', 'condition' : p[3], 'source' : p[5], 'source_else': None }
    if len(p)>7:
        p[0]['source_else'] = p[7]
        
    update_lexpos(p)


def p_instruction_while(p):
    '''
    instruction : WHILE LPAREN expression RPAREN instruction
    '''
    p[0] = { 'type' : 'instruction.while', 'condition' : p[3], 'source' : p[5]}
        
    update_lexpos(p)

def p_optexpression(p):
    '''
    optexpression   : empty
                    | expression
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'expression':
        p[0] = p[1]
    elif typelist == 'empty':
        p[0] = None
    else:
        print >> sys.stderr, "PANIC: Unknown argument list %s" % repr(typelist)
    update_lexpos(p)
    
def p_instructioncomma(p):
    '''
    instructioncomma    : setinstruction
                        | instructioncomma COMMA setinstruction
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'setinstruction':
        p[0] = [p[1]]
    elif typelist == 'instructioncomma COMMA setinstruction':
        p[0] = p[1] + [p[3]]
    else:
        print >> sys.stderr, "PANIC: Unknown argument list %s" % repr(typelist)
    
    update_lexpos(p)

    
def p_optinstructioncomma(p):
    '''
    optinstructioncomma : empty
                        | instructioncomma
                        | vardefinstruction
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    if typelist == 'instructioncomma':
        p[0] = p[1]
    elif typelist == 'vardefinstruction':
        p[0] = p[1]
    elif typelist == 'empty':
        p[0] = None
    else:
        print >> sys.stderr, "PANIC: Unknown argument list %s" % repr(typelist)
    update_lexpos(p)


def p_instruction_forclassic(p):
    '''
    instruction : FOR LPAREN optinstructioncomma SEMI optexpression SEMI optinstructioncomma RPAREN instruction
    '''
    p[0] = { 'type' : 'instruction.forclassic', 
        'initialization' : p[3], 
        'condition' : p[5], 
        'increment' : p[7], 
        'source' : p[9]}
    
    update_lexpos(p)


def p_instruction_switch(p):
    '''
    instruction : SWITCH LPAREN expression RPAREN instruction
    '''
    p[0] = { 'type' : 'instruction.switch', 'condition' : p[3], 'source' : p[5]}
        
    update_lexpos(p)

def p_instruction_case(p):
    '''
    instruction : CASE expression COLON
    '''
    p[0] = { 'type' : 'instruction.case', 'value' : p[2]}
        
    update_lexpos(p)

def p_instruction_case_default(p):
    '''
    instruction : DEFAULT COLON
    '''
    p[0] = { 'type' : 'instruction.default', 'value' : None}
        
    update_lexpos(p)

def p_instruction_break(p):
    '''
    instruction : BREAK
    '''
    p[0] = { 'type' : 'instruction.break', 'value' : None}
        
    update_lexpos(p)

def p_instruction_with(p):
    '''
    instruction : WITH LPAREN expression RPAREN instruction
    '''
    p[0] = { 'type' : 'instruction.with', 'condition' : p[3], 'source' : p[5]}
        
    update_lexpos(p)

    
def p_instruction_function(p):
    '''
    instruction : FUNCTION ID functionarglist instruction
                | FUNCTION ID functionarglist COLON ID instruction
    '''
    typelist = " ".join([ x.type for x in p.slice[1:] ])
    rettype = None
    source = None
    if typelist == 'FUNCTION ID functionarglist COLON ID instruction':
        rettype = p[5] 
        source = p[6]
    else:
        source = p[4]
    
    p[0] = { 'type' : 'instruction.function', 'name' : p[2], 'argumentlist' : p[3], 'source' : source, 'rettype' : rettype }
    update_lexpos(p)

def p_classextends(p):
    '''
        classextends : EXTENDS ID
    '''
    p[0] = p[2]
    update_lexpos(p)
    
def p_classextends_empty(p):
    '''
        classextends : empty
    '''
    p[0] = None
    update_lexpos(p)
    

def p_instruction_class(p):
    '''
    instruction    : CLASS ID classextends instruction
    '''
    p[0] = { 'type' : 'instruction.class', 'name' : p[2], 'extends' : p[3], 'source' : p[4] }
    update_lexpos(p)



start = 'instructionset'
debug = 50



    
    
# Error rule for syntax errors
def p_error(p):
    global last_error_lextoken
    global last_ok_pos
    last_error_lextoken = p
    if p:
        error = "FATAL: Syntax error in input, line %d, character %s!" % (p.lineno,repr(p.value))
        print >> sys.stderr, error
        debug = False
    else:
        debug = True
        error = "PANIC: no data in parser!?"        
        print >> sys.stderr, "** (%d)" % last_ok_pos , error
        #print >> sys.stderr, "**", yacc.format_stack_entry()
    if debug:
        global parser
        from codegenerator import generatecode
        for x in parser.symstack:
            print >> sys.stderr, " - %15s : %s" % (str(x.__class__.__name__), str(x)) 
            #if hasattr(x,"value") and 'type' in x.value:
            #    for n,line in list(enumerate(generatecode(x.value, "").split("\n")))[-15:]:
            #        print >> sys.stderr, "%d>>>" % n, line
            
        print >> sys.stderr, "Last State:", " ".join([str(x) for x in parser.statestack])
        #print >> sys.stderr, "Last Stack:", pformat(parser.symstack[1].value)
        print >> sys.stderr, yacc.format_stack_entry(parser.statestack)
        #for k in dir(yacc):
        #    print >> sys.stderr, k, "->",repr(getattr(yacc,k))
            
        
    return error 

yaml_configured = False
def configure_yaml():
    global yaml_configured
    if yaml_configured: return True
    import yaml
    def float_representer(dumper, data):
        value = (u'%.6f' % data).rstrip("0")
    
        if len(value) == 0 or value.endswith("."): value += "0"

        #ret = dumper.represent_scalar('!float', value)
        ret = yaml.ScalarNode(u'tag:yaml.org,2002:float',value)
        #print ret, dir(ret), repr(ret)
        return ret

    yaml.add_representer(float, float_representer)
    yaml_configured = True

# Build the parser
parser = yacc.yacc(debug=True)

"""try:
    parser = yacc.yacc(errorlog=yacc.NullLogger())
except:
    parser = yacc.yacc()
   """ 
def main():
    import sys
    from qsacalculate import calculate
    import yaml
    configure_yaml()

    if len(sys.argv) > 1:
        s = " ".join(sys.argv[1:])
        print "Input data:", s
        result = parser.parse(s)
        try:
            print "Result:", calculate(result)
        except Exception, e:
            print "Error calculating:", type(e).__name__, " ".join([str(x) for x in e.args])
        try:
            print "Eval:", eval(s)
        except Exception, e:
            print "Error evaluating:", type(e).__name__, " ".join([str(x) for x in e.args])
    
        print "---"
        print yaml.dump(result)
        sys.exit(0)


    while True:
        try:
            s = raw_input('calc > ')
        except EOFError:
            break
        if not s: continue
        result = parser.parse(s)
        try:
            print "Result:", calculate(result)
        except Exception, e:
            print "Error calculating:", type(e).__name__, " ".join([str(x) for x in e.args])
        #print "---"
        #print yaml.dump(result)

    
if __name__ == "__main__":
    main()

