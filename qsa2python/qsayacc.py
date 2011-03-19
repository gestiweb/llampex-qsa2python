
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
        
    p[0] = { 'type': 'expression.math.%s' % p.slice[2].type, 'values' : [p[1], p[3] ] }
    if type(p[1]) is dict:
        if p[1]['type'] == p[0]['type']:
            del p[0]['values'][0]
            p[0]['values'] = p[1]['values'] + p[0]['values'] 
            
                
    

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
    vlist = [ calculate(e) for e in expr['values'] ]
    startval = vlist[0]
    endlist = vlist[1:]
    function = None
    if etype[2] == "PLUS": function = lambda x,y: x+y
    if etype[2] == "MINUS": function = lambda x,y: x-y
    if etype[2] == "TIMES": function = lambda x,y: x*y  
    if etype[2] == "DIVIDE": function = lambda x,y: x/float(y)
        
    if function is None:
        raise ValueError, "Unknown type: %s" % ".".join(etype)
    return reduce(function, endlist, startval)
    
    
    
        
    
    
# Error rule for syntax errors
def p_error(p):
    print "Syntax error in input!"

# Build the parser
parser = yacc.yacc()
import yaml
#s = "2+3+3/2.5/3.2+3+3*(5+6+8+9*2)"
s = """ "Hola" + " ." * 5 + "mundo"
"""
result = parser.parse(s)
print "Result:", calculate(result)
print "Eval:", eval(s)

print yaml.dump(result)
"""
while True:
   try:
       s = raw_input('calc > ')
   except EOFError:
       break
   if not s: continue
   result = parser.parse(s)
   print yaml.dump(result)
"""