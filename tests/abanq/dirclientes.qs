/***************************************************************************
                 dirclientes.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var bloqueoProvincia:Boolean;
    function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C Si en la tabla de direcciones de clientes no hay todav�a ninguna direcci�n asociada al cliente, la primera direcci�n introducida se tomar� como direcci�n de facturaci�n y direcci�n de env�o
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Insert) {
		var cursorCli:FLSqlCursor = new FLSqlCursor("dirclientes");
		cursorCli.select("codcliente = '" + cursor.valueBuffer("codcliente") + "'");
		if (!cursorCli.first()){
			cursor.setValueBuffer("domenvio", "true");
			cursor.setValueBuffer("domfacturacion", "true");
		}
	}
	this.iface.bloqueoProvincia = false;
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "provincia": {
			if (!this.iface.bloqueoProvincia) {
				this.iface.bloqueoProvincia = true;
				flfactppal.iface.pub_obtenerProvincia(this);
				this.iface.bloqueoProvincia = false;
			}
			break;
		}
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
