variables = {}


def calculate(expr):
    if type(expr) is not dict: return expr
    etype = expr['type'].split(".")
    if etype[0] == "expression": return calculate_expression(expr,etype)
    if etype[0] == "const": return calculate(expr['value'])
    if etype[0] == "reference": return calculate_reference(expr,etype)
    if etype[0] == "instructionset": return calculate_instructionset(expr,etype)
    if etype[0] == "instruction": return calculate_instruction(expr,etype)
    raise ValueError, "Unknown type: %s" % ".".join(etype)

def calculate_instruction(expr,etype):
    if etype[1] == "error": return None
    if etype[1] == "assigment": return calculate_instruction_assigment(expr,etype)
    if etype[1] == "expression": return calculate(expr['value'])
    raise ValueError, "Unknown type: %s" % ".".join(etype)

def calculate_reference(expr,etype):
    dest = calculate(expr['value'])
    if dest not in variables: raise AttributeError, "Variable name %s not defined." % dest
    return variables[dest] 
    
def calculate_instruction_assigment(expr,etype):
    dest = calculate(expr['dest']['value'])
    value = calculate(expr['value'])
    variables[dest] = value
    return value

def calculate_instructionset(expr,etype):
    ret = None
    for instruction in expr['instructionlist']:
        ret = calculate(instruction)
    return ret
    
def calculate_expression(expr,etype):
    if etype[1] == "math": return calculate_expression_math(expr,etype)
    if etype[1] == "paren": return calculate(expr['value'])
    if etype[1] == "const": return calculate(expr['value'])
    if etype[1] == "reference": return calculate(expr['value'])
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
    
    
        