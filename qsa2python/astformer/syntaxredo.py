# encoding: UTF-8

"""
    ASTFormer / Syntax-Redo -- Módulo de reconstrucción de sintaxis
    
    Syntax-Redo analiza las cláusulas que en Python no son válidas y genera un
    nuevo código AST para ellas.
    
    Las entradas a reinterpretar son:
    
    - SWITCH / CASE : Convierte una secuencia de switch a su equivalente en 
        instrucciones IF.
        
    - WITH : Convierte las instrucciones internas para que vayan precedidas
        del identificador que se determina en el WITH.
    
    - FOR : Convierte las instrucciones FOR estilo C a WHILE o a FOR-IN de Python
    
    Ejemplo SWITCH:
    
        Antes: ~~~~~~~~~~~~~~~~~~~~~
        
    switch curLA.modeAccess(): # ERROR / TODO: remove 'switch' because there isn't one in python!
        case curLA.Insert # ERROR / TODO: remove 'case' because there isn't one in python!
        cantidad = -1 * float(curLA.valueBuffer("cantidad")) # type: Number
        if not self.iface.cambiarStock(codAlmacen, curLA.valueBuffer("referencia"), cantidad):
            return False
        break
        case curLA.Del # ERROR / TODO: remove 'case' because there isn't one in python!
        if not self.iface.cambiarStock(codAlmacen, curLA.valueBuffer("referencia"), curLA.valueBuffer("cantidad")):
            return False
        break
        case curLA.Edit # ERROR / TODO: remove 'case' because there isn't one in python!
        if curLA.valueBuffer("referencia") != curLA.valueBufferCopy("referencia") or curLA.valueBuffer("cantidad") != curLA.valueBufferCopy("cantidad"):
            cantidad = -1 * float(curLA.valueBuffer("cantidad")) # type: Number
            if self.iface.cambiarStock(codAlmacen, curLA.valueBufferCopy("referencia"), curLA.valueBufferCopy("cantidad")):
                if not self.iface.cambiarStock(codAlmacen, curLA.valueBuffer("referencia"), cantidad):
                    return False
            else:
                return False
        break
    
        Después: ~~~~~~~~~~~~~~~~~~~

    if curLA.modeAccess() == curLA.Insert:
        cantidad = -1 * float(curLA.valueBuffer("cantidad")) # type: Number
        if not self.iface.cambiarStock(codAlmacen, curLA.valueBuffer("referencia"), cantidad):
            return False
    elif curLA.modeAccess() == curLA.Del:
        if not self.iface.cambiarStock(codAlmacen, curLA.valueBuffer("referencia"), curLA.valueBuffer("cantidad")):
            return False
    elif curLA.modeAccess() == curLA.Edit:
        if curLA.valueBuffer("referencia") != curLA.valueBufferCopy("referencia") or curLA.valueBuffer("cantidad") != curLA.valueBufferCopy("cantidad"):
            cantidad = -1 * float(curLA.valueBuffer("cantidad")) # type: Number
            if self.iface.cambiarStock(codAlmacen, curLA.valueBufferCopy("referencia"), curLA.valueBufferCopy("cantidad")):
                if not self.iface.cambiarStock(codAlmacen, curLA.valueBuffer("referencia"), cantidad):
                    return False
            else:
                return False
    
    Ejemplo WITH:
    
        Antes: ~~~~~~~~~~~~~~~~~~~~
        
    with cursor: # ERROR / TODO: remove ''with'' because is not the same!
        setModeAccess(cursor.Edit)
        refreshBuffer()
        if not valueBuffer("codalmacen"):
            setValueBuffer("codalmacen", "ALG")
            commitBuffer()
        
        Después: ~~~~~~~~~~~~~~~~~~
        
    cursor.setModeAccess(cursor.Edit)
    cursor.refreshBuffer()
    if not cursor.valueBuffer("codalmacen"):
        cursor.setValueBuffer("codalmacen", "ALG")
        cursor.commitBuffer()
        

"""