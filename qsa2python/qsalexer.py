import ply.lex as lex
import sys
# Reserved words
reserved = (
    'BREAK', 'CASE', 'CONST', 'CONTINUE', 'DEFAULT', 'DO',
    'ELSE', 'FOR', 'IF', 
    'RETURN', 
    #'STRUCT', 
    'SWITCH', 
    'WHILE', 'CLASS', 'VAR', 'FUNCTION', 
    'EXTENDS', 'NEW','WITH','TRY','CATCH','THROW', 'DELETE'
    )
comments = (
    'COMMENTBLOCKSTART',
    'COMMENTBLOCKEND',
    'COMMENTLINE',
    'RAWDATA',
    )
tokens = comments + reserved + (
    # Literals (identifier, integer constant, float constant, string constant, char const)
    'ID', 'ICONST', 'FCONST', 'SCONST', 'CCONST', 'RXCONST', 'AT',

    # Operators (+,-,*,/,%,|,&,~,^,<<,>>, ||, &&, !, <, <=, >, >=, ==, !=)
    'PLUS', 'MINUS', 'TIMES', 'DIVIDE', 'MOD',
    'OR', 'AND',  
    'CONDITIONAL1',
    #'NOT', 
    'XOR', 'LSHIFT', 'RSHIFT',
    'LOR', 'LAND', 'LNOT',
    'LT', 'LE', 'GT', 'GE', 'EQ', 'NE',
    
    # Assignment (=, *=, /=, %=, +=, -=, <<=, >>=, &=, ^=, |=)
    'EQUALS', 'TIMESEQUAL', 'DIVEQUAL', 'MODEQUAL', 'PLUSEQUAL', 'MINUSEQUAL',
#    'LSHIFTEQUAL','RSHIFTEQUAL', 'ANDEQUAL', 'XOREQUAL', 'OREQUAL',

    # Increment/decrement (++,--)
    'PLUSPLUS', 'MINUSMINUS',

    # Structure dereference (->)
#    'ARROW',

    # Conditional operator (?)
#    'CONDOP',
    
    # Delimeters ( ) [ ] { } , . ; :
    'LPAREN', 'RPAREN',
    'LBRACKET', 'RBRACKET',
    'LBRACE', 'RBRACE',
    'COMMA', 'PERIOD', 'SEMI', 'COLON',

    # Ellipsis (...)
#    'ELLIPSIS',
    'NEWLINE',
    )

# Completely ignored characters
t_ignore           = ' \r\t\x0c'
t_COMMENT_ignore           = '\r\x0c'


    
# Operators
t_PLUS             = r'\+'
t_MINUS            = r'-'
t_TIMES            = r'\*'
t_DIVIDE           = r'/'
t_MOD              = r'%'
t_OR               = r'\|'
t_AND              = r'&'
#t_NOT              = r'~'
t_XOR              = r'\^'
t_LSHIFT           = r'<<'
t_RSHIFT           = r'>>'
t_LOR              = r'\|\|'
t_LAND             = r'&&'
t_LNOT             = r'!'
t_LT               = r'<'
t_GT               = r'>'
t_LE               = r'<='
t_GE               = r'>='
t_EQ               = r'=='
t_NE               = r'!='
t_CONDITIONAL1      = r'\?'

# Assignment operators

t_EQUALS           = r'='
t_TIMESEQUAL       = r'\*='
t_DIVEQUAL         = r'/='
t_MODEQUAL         = r'%='
t_PLUSEQUAL        = r'\+='
t_MINUSEQUAL       = r'-='
"""
t_LSHIFTEQUAL      = r'<<='
t_RSHIFTEQUAL      = r'>>='
t_ANDEQUAL         = r'&='
t_OREQUAL          = r'\|='
t_XOREQUAL         = r'^='
"""

# Increment/decrement
t_PLUSPLUS         = r'\+\+'
t_MINUSMINUS       = r'--'

# ->
#t_ARROW            = r'->'

# ?
#t_CONDOP           = r'\?'


# Delimeters
t_LPAREN           = r'\('
t_RPAREN           = r'\)'
t_LBRACKET         = r'\['
t_RBRACKET         = r'\]'
t_LBRACE           = r'\{'
t_RBRACE           = r'\}'
t_COMMA            = r','
t_PERIOD           = r'\.'
t_SEMI             = r';'
t_COLON            = r':'
#t_ELLIPSIS         = r'\.\.\.'
t_AT               = r'@'
# Identifiers and reserved words

reserved_map = { }
for r in reserved:
    reserved_map[r.lower()] = r

states = (
   ('COMMENT','exclusive'),
)


def t_ID(t):
#    r'[A-Za-z_]+([\.]{0,1}[\w_]*)+'
    r'[A-Za-z_]+[\w_]*'
    t.type = reserved_map.get(t.value,"ID")
    return t



# Integer literal
t_ICONST = r'\d+([uU]|[lL]|[uU][lL]|[lL][uU])?'

# Floating literal
t_FCONST = r'((\d+)(\.\d+)(e(\+|-)?(\d+))? | (\d+)e(\+|-)?(\d+))([lL]|[fF])?'

# String literal
t_SCONST = r'\"([^\\\n]|(\\.))*?\"'

# Character constant 'c' or L'c'
t_CCONST = r'(L)?\'([^\\\n]|(\\.))*?\''

# REGEX constant 
t_RXCONST = r'/.+/g'



# Newlines
def t_NEWLINE(t):
    r'\n+'
    lines = t.value.count("\n")
    t.lexer.lineno += lines
    if lines > 1:
        return t

def t_COMMENTLINE(t):
    r'//(.*)'
    return t

def t_COMMENTBLOCKSTART(t):
    r'/\*'
    t.lexer.push_state("COMMENT")
    return t
    
def t_COMMENT_COMMENTBLOCKEND(t):
    r'(.+)\*/'
    t.lexer.pop_state()
    return t

def t_COMMENT_RAWDATA(t):
    r'[^\n]*\n'
    t.lexer.lineno += 1
    return t
    
def t_error(t):
    sys.stderr.write("Illegal character %s at line %d\n" % (repr(t.value[0]),t.lexer.lineno))
    t.lexer.skip(1)
    
def t_COMMENT_error(t):
    sys.stderr.write("Illegal COMMENT character %s at line %d\n" % (repr(t.value[0]),t.lexer.lineno))
    t.lexer.skip(1)


    
lexer = lex.lex(debug=False)
if __name__ == "__main__":
    lex.runmain(lexer)

