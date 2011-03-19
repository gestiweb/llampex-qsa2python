import ply.yacc as yacc
from qsalexer import tokens
precedence = (
    ('left', 'PLUS', 'MINUS'),
    ('left', 'TIMES', 'DIVIDE'),
)
start = 'expression'
debug = 0

def p_number(p):
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
        p[1] = str(p[1][1:-1])
    if p.slice[1].type == "CCONST":
        p[1] = str(p[1][1:-1])
    if debug > 4:
        p[0] = { 'type' : 'const.%s' % p.slice[1].type, 'value' : p[1] }
    else:
        p[0] = p[1]


def p_expression(p):
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
            
                
    

def p_expression_paren(p):
    '''
    expression : LPAREN expression RPAREN
    '''
    if debug > 1:
        p[0] = { 'type': 'expression.paren', 'value' : p[2] }
    else:
        p[0] = p[2]
        
def p_expression_number(p):
    '''
    expression : const
    '''
    if debug > 5:
        p[0] = { 'type': 'expression.%s' %  p.slice[1].type, 'value' : p[1] }
    else:
        p[0] = p[1]
    

def calculate(expr):
    if type(expr) is not dict: return expr
    etype = expr['type'].split(".")
    if etype[0] == "expression": return calculate_expression(expr,etype)
    if etype[0] == "const": return calculate(expr['value'])
    raise ValueError, "Unknown type: %s" % ".".join(etype)
    
def calculate_expression(expr,etype):
    if etype[1] == "math": return calculate_expression_math(expr,etype)
    if etype[1] == "paren": return calculate(expr['value'])
    if etype[1] == "const": return calculate(expr['value'])
    raise ValueError, "Unknown type: %s" % ".".join(etype)

def calculate_expression_math(expr,etype):
    vlist = [ calculate(e) for e in expr['valuelist'] ]
    startval = vlist[0]
    endlist = vlist[1:]
    function = None
    if etype[2] == "PLUS": function = lambda x,y: x+y
    if etype[2] == "MINUS": function = lambda x,y: x-y
    if etype[2] == "TIMES": function = lambda x,y: x*y  
    if etype[2] == "DIVIDE": function = lambda x,y: x/y
        
    if function is None:
        raise ValueError, "Unknown type: %s" % ".".join(etype)
    return reduce(function, endlist, startval)
    
    
        
    
    
# Error rule for syntax errors
def p_error(p):
    print "Syntax error in input!"

# Build the parser
parser = yacc.yacc(errorlog=yacc.NullLogger())
import yaml
import sys

def float_representer(dumper, data):
    value = (u'%.6f' % data).rstrip("0")
    
    if len(value) == 0 or value.endswith("."): value += "0"

    #ret = dumper.represent_scalar('!float', value)
    ret = yaml.ScalarNode(u'tag:yaml.org,2002:float',value)
    #print ret, dir(ret), repr(ret)
    return ret

yaml.add_representer(float, float_representer)

if len(sys.argv) > 1:
    s = " ".join(sys.argv[1:])
    print "Input data:", s
    result = parser.parse(s)
    print "Result:", calculate(result)
    print "Eval:", eval(s)
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
    print yaml.dump(result)

