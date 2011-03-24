# encoding: UTF-8

"""
    ASTFormer -- paquete de transformación de código AST a código AST reinterpretado.
    
    ASTFormer es un paquete de módulos dedicados a la transformación de código
    AST (Abstract Syntax Tree). El objetivo es, para una entrada AST dada, 
    buscar ciertos patrones y reprogramar el código (reorganizando las entradas
    AST) según unos criterios. Una vez terminado devuelve el nuevo código AST.
    
    ASTFormer se divide en varios módulos, cada uno se dedica a un tipo de 
    conversión determinada.
"""
