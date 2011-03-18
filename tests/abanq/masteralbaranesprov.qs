/***************************************************************************
                 masteralbaranesprov.qs  -  description
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
	function recordDelBeforealbaranesprov() { return this.ctx.interna_recordDelBeforealbaranesprov(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var pbnAAlbaran:Object;
	var pbnGFactura:Object;
	var tdbRecords:FLTableDB;
	var tbnImprimir:Object;
	var curFactura:FLSqlCursor;
	var curLineaFactura:FLSqlCursor;
    
    function oficial( context ) { interna( context ); } 
	function imprimir(codAlbaran:String) {
		return this.ctx.oficial_imprimir(codAlbaran);
	}
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function pbnGenerarFactura_clicked() {
		return this.ctx.oficial_pbnGenerarFactura_clicked();
	}
	function generarFactura(where:String, curAlbaran:FLSqlCursor):Number {
		return this.ctx.oficial_generarFactura(where, curAlbaran);
	}
	function copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean {
		return this.ctx.oficial_copiaLineasAlbaran(idAlbaran, idFactura);
	}
	function copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.oficial_copiaLineaAlbaran(curLineaAlbaran, idFactura);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function restarCantidad(idLineaPedido:Number, cantidad:Number) {
		return this.ctx.oficial_restarCantidad(idLineaPedido, cantidad);
	}
	function asociarAAlbaran() {
		return this.ctx.oficial_asociarAAlbaran();
	}
	function whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.ctx.oficial_whereAgrupacion(curAgrupar);
	}
	function totalesFactura():Boolean {
		return this.ctx.oficial_totalesFactura();
	}
	function datosFactura(curAlbaran:FLSqlCursor,where:String):Boolean {
		return this.ctx.oficial_datosFactura(curAlbaran,where);
	}
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosLineaFactura(curLineaAlbaran);
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
	function pub_restarCantidad(idLineaPedido:Number, cantidad:Number) {
		return this.restarCantidad(idLineaPedido, cantidad);
	}
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_generarFactura(where:String, curAlbaran:FLSqlCursor):Number {
		return this.generarFactura(where, curAlbaran);
	}
	function pub_whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.whereAgrupacion(curAgrupar);
	}
	function pub_imprimir(codAlbaran:String) {
		return this.imprimir(codAlbaran);
	}
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
/** \C
Este es el formulario maestro de albaranes a proveedor.
\end */
function interna_init()
{
	this.iface.pbnGFactura = this.child("pbnGenerarFactura");
	this.iface.pbnAAlbaran = this.child("pbnAsociarAAlbaran");
	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.tbnImprimir = this.child("toolButtonPrint");

	connect(this.iface.pbnAAlbaran, "clicked()", this, "iface.asociarAAlbaran");
	connect(this.iface.pbnGFactura, "clicked()", this, "iface.pbnGenerarFactura_clicked");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado");
	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");

	var codEjercicio = flfactppal.iface.pub_ejercicioActual();;
	if (codEjercicio)
		this.cursor().setMainFilter("codejercicio='" + codEjercicio + "'");

	this.iface.procesarEstado();
}

/** \C
Al borrar un albar�n se recalcular�n los valores del campo total en albar�n del pedido asociado, as� como el estado del pedido (si lo hay)
\end */
function interna_recordDelBeforealbaranesprov()
{
		var cursor:FLSqlCursor = this.cursor();
		var cantidad:Number;
		var idLineaPedido:Number;
		var numeroPedido:Number;

		var query:FLSqlQuery = new FLSqlQuery();
		query.setTablesList("lineasalbaranesprov");
		query.setSelect("idlineapedido, cantidad");
		query.setFrom("lineasalbaranesprov");
		query.setWhere("idalbaran = " + cursor.valueBuffer("idalbaran") + " AND idlineapedido <> 0;");
		query.exec();

		while (query.next()) {
				idLineaPedido = query.value(0);
				cantidad = query.value(1);
				this.iface.restarCantidad(idLineaPedido, cantidad);
		}

		var qryPedido = new FLSqlQuery();
		qryPedido.setTablesList("lineasalbaranesprov");
		qryPedido.setSelect("idpedido");
		qryPedido.setFrom("lineasalbaranesprov");
		qryPedido.setWhere("idalbaran = " + cursor.valueBuffer("idalbaran") + " AND idpedido <> 0 GROUP BY idpedido;");
		qryPedido.exec();
		while (qryPedido.next()) {
				idPedido = qryPedido.value(0);
				formRecordlineasalbaranesprov.iface.pub_actualizarEstadoPedido(idPedido);
		}
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Al pulsar el bot�n imprimir se lanzar� el informe correspondiente al albar�n seleccionado (en caso de que el m�dulo de informes est� cargado)
\end */
function oficial_imprimir(codAlbaran:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var codigo:String;
		if (codAlbaran) {
			codigo = codAlbaran;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_albaranesprov");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_albaranesprov_codigo", codigo);
		curImprimir.setValueBuffer("h_albaranesprov_codigo", codigo);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_albaranesprov");
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

function oficial_procesarEstado()
{
		if (this.cursor().valueBuffer("ptefactura") == true)
				this.iface.pbnGFactura.setEnabled(true);
		else
				this.iface.pbnGFactura.setEnabled(false);
}

/** \C
Al pulsar el bot�n de generar factura se crear� la factura correspondiente al albar�n.
\end */
function oficial_pbnGenerarFactura_clicked()
{
	var idFactura:Number;
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var where:String = "idalbaran = " + cursor.valueBuffer("idalbaran");

	if (cursor.valueBuffer("ptefactura") == false) {
		MessageBox.warning(util.translate("scripts", "Ya existe la factura correspondiente a este albar�n"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	this.iface.pbnGFactura.setEnabled(false);

	cursor.transaction(false);
	try {
		idFactura = this.iface.generarFactura(where, cursor);
		if (idFactura)
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la generaci�n de la factura:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	
	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}

/** \D 
Genera la factura asociada a uno o m�s albaranes
@param where: Sentencia where para la consulta de b�squeda de los albaranes a agrupar
@param curAlbaran: Cursor con los datos principales que se copiar�n del albar�n a la factura
@return Identificador de la factura creada, False: si hay error
\end */
function oficial_generarFactura(where:String, curAlbaran:FLSqlCursor):Boolean
{
	if (!this.iface.curFactura)
		this.iface.curFactura = new FLSqlCursor("facturasprov");
	
	this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
	this.iface.curFactura.refreshBuffer();
	
	if (!this.iface.datosFactura(curAlbaran,where))
		return false;
	
	if (!this.iface.curFactura.commitBuffer()) {
		return false;
	}
	var idFactura:Number = this.iface.curFactura.valueBuffer("idfactura");
	
	var curAlbaranes:FLSqlCursor = new FLSqlCursor("albaranesprov");
	curAlbaranes.select(where);
	var idAlbaran:Number;
	while (curAlbaranes.next()) {
		curAlbaranes.setModeAccess(curAlbaranes.Edit);
		curAlbaranes.refreshBuffer();
		idAlbaran = curAlbaranes.valueBuffer("idalbaran");
		if (!this.iface.copiaLineasAlbaran(idAlbaran, idFactura))
			return false;

		curAlbaranes.setValueBuffer("idfactura", idFactura);
		curAlbaranes.setValueBuffer("ptefactura", false);
		if (!curAlbaranes.commitBuffer())
			return false;
	}

	this.iface.curFactura.select("idfactura = " + idFactura);
	if (this.iface.curFactura.first()) {
/* 
		if (!formRecordfacturasprov.iface.pub_actualizarLineasIva(idFactura))
			return false;
*/
		
		this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
		this.iface.curFactura.refreshBuffer();
		
		if (!this.iface.totalesFactura())
			return false;
		
		if (this.iface.curFactura.commitBuffer() == false)
			return false;
	}
	return idFactura;
}

/** \D Informa los datos de una factura a partir de los de uno o varios albaranes
@param	curAlbaran: Cursor que contiene los datos a incluir en la factura
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosFactura(curAlbaran:FLSqlCursor,where:String):Boolean
{
	var fecha:String;
	if (curAlbaran.action() == "albaranesprov") {
		var hoy:Date = new Date();
		fecha = hoy.toString();
	} else
		fecha = curAlbaran.valueBuffer("fecha");
	
	var codEjercicio:String = curAlbaran.valueBuffer("codejercicio");
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturasprov");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}
	
	with(this.iface.curFactura) {
		setValueBuffer("codproveedor", curAlbaran.valueBuffer("codproveedor"));
		setValueBuffer("nombre", curAlbaran.valueBuffer("nombre"));
		setValueBuffer("cifnif", curAlbaran.valueBuffer("cifnif"));
		setValueBuffer("coddivisa", curAlbaran.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curAlbaran.valueBuffer("tasaconv"));
		setValueBuffer("recfinanciero", curAlbaran.valueBuffer("recfinanciero"));
		setValueBuffer("codpago", curAlbaran.valueBuffer("codpago"));
		setValueBuffer("codalmacen", curAlbaran.valueBuffer("codalmacen"));
		setValueBuffer("fecha", fecha);
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("codserie", curAlbaran.valueBuffer("codserie"));
		setValueBuffer("tasaconv", curAlbaran.valueBuffer("tasaconv"));
		setValueBuffer("recfinanciero", curAlbaran.valueBuffer("recfinanciero"));
		setValueBuffer("irpf", curAlbaran.valueBuffer("irpf"));
		setValueBuffer("automatica", true);
	}
	return true;
}

/** \D Copia los datos de una l�nea de albar�n en una l�nea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la l�nea de factura
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var referencia:String = curLineaAlbaran.valueBuffer("referencia");
	
	with (this.iface.curLineaFactura) {
		setValueBuffer("referencia", referencia);
		setValueBuffer("descripcion", curLineaAlbaran.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaAlbaran.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaAlbaran.valueBuffer("pvpsindto"));
		setValueBuffer("cantidad", curLineaAlbaran.valueBuffer("cantidad"));
		setValueBuffer("pvptotal", curLineaAlbaran.valueBuffer("pvptotal"));
		setValueBuffer("codimpuesto", curLineaAlbaran.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaAlbaran.valueBuffer("iva"));
		setValueBuffer("recargo", curLineaAlbaran.valueBuffer("recargo"));
		setValueBuffer("dtopor", curLineaAlbaran.valueBuffer("dtopor"));
		setValueBuffer("dtolineal", curLineaAlbaran.valueBuffer("dtolineal"));
		setValueBuffer("idalbaran", curLineaAlbaran.valueBuffer("idalbaran"));
	}
	
	/** \C La subcuenta de compras asociada a cada l�nea ser� la establecida en la tabla de art�culos
	\end */
	if (sys.isLoadedModule("flcontppal") && referencia != "") {
		var codSubcuenta = util.sqlSelect("articulos", "codsubcuentacom", "referencia = '" + referencia + "'");
		if (codSubcuenta) {
			var ejercicioActual:String = flfactppal.iface.pub_ejercicioActual();
			var idSubcuenta:Number = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + ejercicioActual + "'");
			if (!idSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No existe la subcuenta de compras con c�digo ") + codSubcuenta +  util.translate("scripts", " y ejercicio ") + ejercicioActual + ".\n" + util.translate("scripts", "Debe crear la subcuenta en el �rea Financiera."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			this.iface.curLineaFactura.setValueBuffer("codsubcuenta", codSubcuenta);
			this.iface.curLineaFactura.setValueBuffer("idsubcuenta", idSubcuenta);
		}
	}
	return true;
}

/** \D Informa los datos de una factura referentes a totales (I.V.A., neto, etc.)
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesFactura():Boolean
{
	with (this.iface.curFactura) {
		setValueBuffer("neto", formfacturasprov.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formfacturasprov.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("totalirpf", formfacturasprov.iface.pub_commonCalculateField("totalirpf", this));
		setValueBuffer("totalrecargo", formfacturasprov.iface.pub_commonCalculateField("totalrecargo", this));
		setValueBuffer("total", formfacturasprov.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formfacturasprov.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}

/** \D
Copia las l�neas de un albar�n como l�neas de su factura asociada
@param idAlbaran: Identificador del albar�n
@param idFactura: Identificador de la factuta
@return	Verdadero si no hay error, falso en caso contrario
\end */
function oficial_copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean
{
	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranesprov");
	curLineaAlbaran.select("idalbaran = " + idAlbaran);
	
	while (curLineaAlbaran.next()) {
		curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
		if (!this.iface.copiaLineaAlbaran(curLineaAlbaran, idFactura))
			return false;
	}
	return true;
}

/** \D
Copia una l�neas de albar�n en su factura asociada
@param curLineaAlbaran: Cursor posicionado en la l�nea de albar�n
@param idFactura: Identificador de la factuta
@return	identificador de la l�nea creada si no hay error falso en caso contrario
\end */
function oficial_copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number
{
	if (!this.iface.curLineaFactura)
		this.iface.curLineaFactura = new FLSqlCursor("lineasfacturasprov");
	
	with (this.iface.curLineaFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
	}
	
	if (!this.iface.datosLineaFactura(curLineaAlbaran))
		return false;
		
	if (!this.iface.curLineaFactura.commitBuffer())
			return false;
	
	return this.iface.curLineaFactura.valueBuffer("idlinea");

}
	
function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
		var util:FLUtil = new FLUtil();
		var valor:String;

		/** \C
		El --c�digo-- se construye como la concatenaci�n de --codserie--, --codejercicio-- y --numero--
		\end */
		if (fN == "codigo")
				valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));

		switch (fN) {
		/** \C
		El --total-- es el --neto-- menos el --totalirpf-- m�s el --totaliva-- m�s el --totalrecargo-- m�s el --recfinanciero--
		\end */
		case "total":{
						var neto:Number = parseFloat(cursor.valueBuffer("neto"));
						var totalIva:Number = parseFloat(cursor.valueBuffer("totaliva"));
						var totalIrpf:Number = parseFloat(cursor.valueBuffer("totalirpf"));
						var totalRecargo:Number = parseFloat(cursor.valueBuffer("totalrecargo"));
						var recFinanciero:Number = (parseFloat(cursor.valueBuffer("recfinanciero")) * neto) / 100;
						recFinanciero = parseFloat(util.roundFieldValue(recFinanciero, "albaranesprov", "total"));
						valor = neto - totalIrpf + totalIva + totalRecargo + recFinanciero;
						valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "total"));
						break;
				}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "totaleuros": {
						var total:Number = parseFloat(cursor.valueBuffer("total"));
						var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
						valor = total * tasaConv;
						valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "totaleuros"));
						break;
				}
		/** \C
		El --neto-- es la suma del pvp total de las l�neas de albar�n
		\end */
		case "neto":{
						valor = util.sqlSelect("lineasalbaranesprov", "SUM(pvptotal)", "idalbaran = " + cursor.valueBuffer("idalbaran"));
						valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "neto"));
						break;
				}
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las l�neas de albar�n
		\end */
		case "totaliva":{
						valor = util.sqlSelect("lineasalbaranesprov", "SUM((pvptotal * iva) / 100)", "idalbaran = " + cursor.valueBuffer("idalbaran"));
						valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "totaliva"));
						break;
				}
		/** \C
		El --totarecargo-- es la suma del recargo correspondiente a las l�neas de albar�n
		\end */
		case "totalrecargo":{
						valor = util.sqlSelect("lineasalbaranesprov", "SUM((pvptotal * recargo) / 100)", "idalbaran = " + cursor.valueBuffer("idalbaran"));
						valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "totalrecargo"));
						break;
				}
		/** \C
		El --irpf-- es el asociado a la --codserie-- del albar�n
		\end */
		case "irpf": {
						valor = util.sqlSelect("series", "irpf", "codserie = '" + cursor.valueBuffer("codserie") + "'");
						break;
				}
		/** \C
		El --totalirpf-- es el producto del --irpf-- por el --neto--
		\end */
		case "totalirpf": {
						valor = (parseFloat(cursor.valueBuffer("irpf")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
						valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "totalirpf"));
						break;
				}
		}
		return valor;
}

/** \D
Cambia el valor del campo totalenalbar�n de una determinada l�nea de pedido
@param idLineaPedido: Identificador de la l�nea de pedido
@param cantidad: Cantidad a restar
\end */
function oficial_restarCantidad(idLineaPedido:Number, cantidad:Number)
{
		var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
		with(curLineaPedido) {
				select("idlinea = " + idLineaPedido);
				first();
				setModeAccess(Edit);
				refreshBuffer();
				setValueBuffer("totalenalbaran", parseFloat(curLineaPedido.valueBuffer("totalenalbaran")) - parseFloat(cantidad));
				commitBuffer();
		}
}

/** \C
Al pulsar el bot�n de asociar a albar�n se abre la ventana de agrupar pedidos de proveedor
\end */
function oficial_asociarAAlbaran()
{
		var util:FLUtil = new FLUtil;
		var f:Object = new FLFormSearchDB("agruparpedidosprov");
		var cursor:FLSqlCursor = f.cursor();
		var where:String;
		var codProveedor:String;
		var codAlmacen:String;

		cursor.setActivatedCheckIntegrity(false);
		cursor.select();
		if (!cursor.first())
				cursor.setModeAccess(cursor.Insert);
		else
				cursor.setModeAccess(cursor.Edit);

		f.setMainWidget();
		cursor.refreshBuffer();
		var acpt:String = f.exec("codejercicio");
		if (acpt) {
				cursor.commitBuffer();
				var curAgruparPedidos:FLSqlCursor = new FLSqlCursor("agruparpedidosprov");
				curAgruparPedidos.select();
				if (curAgruparPedidos.first()) {
						where = this.iface.whereAgrupacion(curAgruparPedidos);
						var excepciones:String = curAgruparPedidos.valueBuffer("excepciones");
						if (!excepciones.isEmpty())
								where += " AND idpedido NOT IN (" + excepciones + ")";

						var qryAgruparPedidos:FLSqlQuery = new FLSqlQuery;
						qryAgruparPedidos.setTablesList("pedidosprov");
						qryAgruparPedidos.setSelect("codproveedor,codalmacen");
						qryAgruparPedidos.setFrom("pedidosprov");
						qryAgruparPedidos.setWhere(where + " GROUP BY codproveedor,codalmacen");

						if (!qryAgruparPedidos.exec())
								return;

						var totalProv:Number = qryAgruparPedidos.size();
						util.createProgressDialog(util.translate("scripts", "Generando albaranes"), totalProv);
						util.setProgress(1);
						var j:Number = 0;

						var curPedido:FLSqlCursor = new FLSqlCursor("pedidosprov");
						var whereAlbaran:String;
						while (qryAgruparPedidos.next()) {
								codProveedor = qryAgruparPedidos.value(0);
								codAlmacen = qryAgruparPedidos.value(1);
								whereAlbaran = where + " AND codproveedor = '" + codProveedor + "'" + " AND codalmacen = '" + codAlmacen + "'";
								curPedido.transaction(false);
								curPedido.select(whereAlbaran);
								if (!curPedido.first()) {
										curPedido.rollback();
										util.destroyProgressDialog();
										return;
								}
								curPedido.setValueBuffer("fecha", curAgruparPedidos.valueBuffer("fecha"));
								if (formpedidosprov.iface.pub_generarAlbaran(whereAlbaran, curPedido)) {
										curPedido.commit();
								} else {
										curPedido.rollback();
										util.destroyProgressDialog();
										return;
								}
								util.setProgress(++j);
						}
						util.setProgress(totalProv);
						util.destroyProgressDialog();
				}

				f.close();
				this.iface.tdbRecords.refresh();
		}
}

/** \D
Construye la sentencia WHERE de la consulta que buscar� los pedidos a agrupar
@param curAgrupar: Cursor de la tabla agruparpedidosprov que contiene los valores de los criterios de b�squeda
@return Sentencia where
\end */
function oficial_whereAgrupacion(curAgrupar:FLSqlCursor):String
{
		var codProveedor:String = curAgrupar.valueBuffer("codproveedor");
		var nombre:String = curAgrupar.valueBuffer("nombre");
		var cifNif:String = curAgrupar.valueBuffer("cifnif");
		var codAlmacen:String = curAgrupar.valueBuffer("codalmacen");
		var codPago:String = curAgrupar.valueBuffer("codpago");
		var codDivisa:String = curAgrupar.valueBuffer("coddivisa");
		var codSerie:String = curAgrupar.valueBuffer("codserie");
		var codEjercicio:String = curAgrupar.valueBuffer("codejercicio");
		var fechaDesde:String = curAgrupar.valueBuffer("fechadesde");
		var fechaHasta:String = curAgrupar.valueBuffer("fechahasta");
		var where:String = "servido <> 'S�'";
		if (codProveedor && !codProveedor.isEmpty())
				where += " AND codproveedor = '" + codProveedor + "'";
		if (cifNif && !cifNif.isEmpty())
				where += " AND cifnif = '" + cifNif + "'";
		if (codAlmacen && !codAlmacen.isEmpty())
				where = where + " AND codalmacen = '" + codAlmacen + "'";
		where = where + " AND fecha >= '" + fechaDesde + "'";
		where = where + " AND fecha <= '" + fechaHasta + "'";
		if (codPago && !codPago.isEmpty() != "")
				where = where + " AND codpago = '" + codPago + "'";
		if (codDivisa && !codDivisa.isEmpty())
				where = where + " AND coddivisa = '" + codDivisa + "'";
		if (codSerie && !codSerie.isEmpty())
				where = where + " AND codserie = '" + codSerie + "'";
		if (codEjercicio && !codEjercicio.isEmpty())
				where = where + " AND codejercicio = '" + codEjercicio + "'";
		return where;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
