/***************************************************************************
                 masterpresupuestoscli.qs  -  description
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
	var pbnGPedido:Object;
	var tdbRecords:FLTableDB;
	var tbnImprimir:Object;
	var curPedido:FLSqlCursor;
	var curLineaPedido:FLSqlCursor;

    function oficial( context ) { interna( context ); } 
	function imprimir(codPresupuesto:String) {
		return this.ctx.oficial_imprimir(codPresupuesto);
	}
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function pbnGenerarPedido_clicked() {
		return this.ctx.oficial_pbnGenerarPedido_clicked();
	}
	function generarPedido(cursor:FLSqlCursor):Number {
		return this.ctx.oficial_generarPedido(cursor);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function copiaLineas(idPresupuesto:Number, idPedido:Number):Boolean {
		return this.ctx.oficial_copiaLineas(idPresupuesto, idPedido);
	}
	function copiaLineaPresupuesto(curLineaPresupuesto:FLSqlCursor, idPedido:Number):Number {
		return this.ctx.oficial_copiaLineaPresupuesto(curLineaPresupuesto, idPedido);
	}
	function totalesPedido():Boolean {
		return this.ctx.oficial_totalesPedido();
	}
	function datosPedido(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosPedido(curPresupuesto);
	}
	function datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosLineaPedido(curLineaPresupuesto);
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
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_imprimir(codPresupuesto:String) {
		return this.imprimir(codPresupuesto);
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
Este es el formulario maestro de presupuestos a cliente.
\end */
function interna_init()
{
	this.iface.pbnGPedido = this.child("pbnGenerarPedido");
	this.iface.tdbRecords= this.child("tableDBRecords");
	this.iface.tbnImprimir = this.child("toolButtonPrint");

	connect(this.iface.pbnGPedido, "clicked()", this, "iface.pbnGenerarPedido_clicked");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado");
	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");

	var codEjercicio = flfactppal.iface.pub_ejercicioActual();
	if (codEjercicio)
		this.cursor().setMainFilter("codejercicio = '" + codEjercicio + "'");

	this.iface.procesarEstado();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Al pulsar el bot�n imprimir se lanzar� el informe correspondiente al presupuesto seleccionado (en caso de que el m�dulo de informes est� cargado)
\end */
function oficial_imprimir(codPresupuesto:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		
		var codigo:String;
		if (codPresupuesto) {
			codigo = codPresupuesto;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_presupuestoscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_presupuestoscli_codigo", codigo);
		curImprimir.setValueBuffer("h_presupuestoscli_codigo", codigo);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_presupuestoscli");
		return;
	}

	var tipoDoc:String = "presupuestoscli";
	var f:Object = new FLFormSearchDB("facturas_imp");
	var cursor:FLSqlCursor = f.cursor();

	cursor.setActivatedCheckIntegrity(false);
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var acpt:String = f.exec("desde");
	if (acpt) {
		cursor.commitBuffer();
		var q:FLSqlQuery = new FLSqlQuery(tipoDoc);
		q.setValueParam("from", cursor.valueBuffer("desde"));
		q.setValueParam("to", cursor.valueBuffer("hasta"));
		var rptViewer = new FLReportViewer();
		rptViewer.setReportTemplate(tipoDoc);
		rptViewer.setReportData(q);
		rptViewer.renderReport();
		rptViewer.exec();
		f.close();
	}
}

function oficial_procesarEstado()
{
		var cursor:FLSqlCursor = this.cursor();
		if (cursor.valueBuffer("editable") == false)
				this.iface.pbnGPedido.setEnabled(false);
		else
				this.iface.pbnGPedido.setEnabled(true);
}

/** \C
Al pulsar el bot�n de generar pedido se crear� el albar�n correspondiente al presupuesto seleccionado.
\end */
function oficial_pbnGenerarPedido_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.valueBuffer("editable") == false) {
		MessageBox.warning(util.translate("scripts", "El presupuesto ya est� aprobado"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	this.iface.pbnGPedido.setEnabled(false);

	cursor.transaction(false);
	try {
		if (this.iface.generarPedido(cursor))
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la generaci�n del pedido:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}

/** \D
Genera el pedido asociado a un presupuesto
@param cursor: Cursor con los datos principales que se copiar�n del presupuesto al pedido
@return True: Copia realizada con �xito, False: Error
\end */
function oficial_generarPedido(curPresupuesto:FLSqlCursor):Number
{
	if (!this.iface.curPedido)
		this.iface.curPedido = new FLSqlCursor("pedidoscli");
	
	var idPresupuesto:String = curPresupuesto.valueBuffer("idpresupuesto");
	
	this.iface.curPedido.setModeAccess(this.iface.curPedido.Insert);
	this.iface.curPedido.refreshBuffer();
	this.iface.curPedido.setValueBuffer("idpresupuesto", idPresupuesto);
	
	if (!this.iface.datosPedido(curPresupuesto))
		return false;
	
	if (!this.iface.curPedido.commitBuffer())
		return false;
	
	var idPedido:Number = this.iface.curPedido.valueBuffer("idpedido");
	var curPresupuestos:FLSqlCursor = new FLSqlCursor("presupuestoscli");
	curPresupuestos.select("idpresupuesto = " + idPresupuesto);
	if (!curPresupuestos.first())
		return false;
	
	curPresupuestos.setModeAccess(curPresupuestos.Edit);
	curPresupuestos.refreshBuffer();
	if (!this.iface.copiaLineas(idPresupuesto, idPedido))
		return false;
	curPresupuestos.setValueBuffer("editable", false);
	if (!curPresupuestos.commitBuffer())
		return false;
	
	this.iface.curPedido.select("idpedido = " + idPedido);
	if (this.iface.curPedido.first()) {
		this.iface.curPedido.setModeAccess(this.iface.curPedido.Edit);
		this.iface.curPedido.refreshBuffer();
		this.iface.curPedido.setValueBuffer("idpresupuesto", idPresupuesto);
		
		if (!this.iface.totalesPedido())
			return false;
		
		if (this.iface.curPedido.commitBuffer() == false)
			return false;
	}
	return idPedido;
}

/** \D Informa los datos de un pedido a partir de los de un presupuesto
@param	curPresupuesto: Cursor que contiene los datos a incluir en el pedido
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosPedido(curPresupuesto:FLSqlCursor):Boolean
{
	var fecha:String;
	if (curPresupuesto.action() == "presupuestoscli") {
		var hoy:Date = new Date();
		fecha = hoy.toString();
	} else
		fecha = curPresupuesto.valueBuffer("fecha");
	
	var codEjercicio:String = curPresupuesto.valueBuffer("codejercicio");
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "pedidoscli");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}
	
	var codDir:Number = curPresupuesto.valueBuffer("coddir");
	with (this.iface.curPedido) {
		setValueBuffer("codserie", curPresupuesto.valueBuffer("codserie"));
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("irpf", curPresupuesto.valueBuffer("irpf"));
		setValueBuffer("fecha", fecha);
		setValueBuffer("codagente", curPresupuesto.valueBuffer("codagente"));
		setValueBuffer("porcomision", curPresupuesto.valueBuffer("porcomision"));
		setValueBuffer("codalmacen", curPresupuesto.valueBuffer("codalmacen"));
		setValueBuffer("codpago", curPresupuesto.valueBuffer("codpago"));
		setValueBuffer("coddivisa", curPresupuesto.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curPresupuesto.valueBuffer("tasaconv"));
		setValueBuffer("codcliente", curPresupuesto.valueBuffer("codcliente"));
		setValueBuffer("cifnif", curPresupuesto.valueBuffer("cifnif"));
		setValueBuffer("nombrecliente", curPresupuesto.valueBuffer("nombrecliente"));
		if (codDir == 0)
			setNull("coddir");
		else
			setValueBuffer("coddir", codDir);
		setValueBuffer("direccion", curPresupuesto.valueBuffer("direccion"));
		setValueBuffer("codpostal", curPresupuesto.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curPresupuesto.valueBuffer("ciudad"));
		setValueBuffer("provincia", curPresupuesto.valueBuffer("provincia"));
		setValueBuffer("apartado", curPresupuesto.valueBuffer("apartado"));
		setValueBuffer("codpais", curPresupuesto.valueBuffer("codpais"));
		setValueBuffer("recfinanciero", curPresupuesto.valueBuffer("recfinanciero"));
		setValueBuffer("fechasalida", curPresupuesto.valueBuffer("fechasalida"));
		setValueBuffer("observaciones", curPresupuesto.valueBuffer("observaciones"));
	}
	
	return true;
}

/** \D Informa los datos de un pedido referentes a totales (I.V.A., neto, etc.)
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesPedido():Boolean
{
	with (this.iface.curPedido) {
		setValueBuffer("neto", formpedidoscli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formpedidoscli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("totalirpf", formpedidoscli.iface.pub_commonCalculateField("totalirpf", this));
		setValueBuffer("totalrecargo", formpedidoscli.iface.pub_commonCalculateField("totalrecargo", this));
		setValueBuffer("total", formpedidoscli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formpedidoscli.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
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
		case "total": {
			var neto:Number = parseFloat(cursor.valueBuffer("neto"));
			var totalIrpf:Number = parseFloat(cursor.valueBuffer("totalirpf"));
			var totalIva:Number = parseFloat(cursor.valueBuffer("totaliva"));
			var totalRecargo:Number = parseFloat(cursor.valueBuffer("totalrecargo"));
			var recFinanciero:Number = (parseFloat(cursor.valueBuffer("recfinanciero")) * neto) / 100;
			recFinanciero = parseFloat(util.roundFieldValue(recFinanciero, "presupuestoscli", "total"));
			valor = neto - totalIrpf + totalIva + totalRecargo + recFinanciero;
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "total"));
			break;
		}
		case "lblComision": {
			valor = (parseFloat(cursor.valueBuffer("porcomision")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "total"));
			break;
		}
		case "lblRecFinanciero": {
			valor = (parseFloat(cursor.valueBuffer("recfinanciero")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "total"));
			break;
		}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "totaleuros": {
			var total:Number = parseFloat(cursor.valueBuffer("total"));
			var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
			valor = total * tasaConv;
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "totaleuros"));
			break;
		}
		/** \C
		El --neto-- es la suma del pvp total de las l�neas de factura
		\end */
		case "neto": {
			valor = util.sqlSelect("lineaspresupuestoscli", "SUM(pvptotal)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto"));
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "neto"));
			break;
		}
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las l�neas de factura
		\end */
		case "totaliva": {
			var codCli:String = cursor.valueBuffer("codcliente");
			var regIva:String = util.sqlSelect("clientes","regimeniva","codcliente = '" + codCli + "'");
			if(regIva == "U.E." || regIva == "Exento"){
				valor = 0;
				break;
			}
			valor = util.sqlSelect("lineaspresupuestoscli", "SUM((pvptotal * iva) / 100)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto"));
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "totaliva"));
			break;
		}
		/** \C
		El --totarecargo-- es la suma del recargo correspondiente a las l�neas de factura
		\end */
		case "totalrecargo": {
			var codCli:String = cursor.valueBuffer("codcliente");
			var regIva:String = util.sqlSelect("clientes","regimeniva","codcliente = '" + codCli + "'");
			if(regIva == "U.E." || regIva == "Exento"){
				valor = 0;
				break;
			}
			valor = util.sqlSelect("lineaspresupuestoscli", "SUM((pvptotal * recargo) / 100)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto"));
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "totalrecargo"));
			break;
		}
		/** \C
		El --coddir-- corresponde a la direcci�n del cliente marcada como direcci�n de facturaci�n
		\end */
		case "coddir": {
			valor = util.sqlSelect("dirclientes", "id", "codcliente = '" + cursor.valueBuffer("codcliente") + "' AND domfacturacion = 'true'");
			if (valor == 0)
				valor = "";
			break;
		}
		/** \C
		El --irpf-- es el asociado al --codserie-- del albar�n
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
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "totalirpf"));
			break;
		}
		case "provincia": {
			valor = util.sqlSelect("dirclientes", "provincia", "id = " + cursor.valueBuffer("coddir"));
			if (!valor)
				valor = cursor.valueBuffer("provincia");
			break;
		}
		case "codpais": {
			valor = util.sqlSelect("dirclientes", "codpais", "id = " + cursor.valueBuffer("coddir"));
			if (!valor)
				valor = cursor.valueBuffer("codpais");
			break;
		}
	}
	return valor;
}

/** \D
Copia las l�neas de un pedido como l�neas de su albar�n asociado
@param idPresupuesto: Identificador del pedido
@param idPedido: Identificador del pedido
\end */
function oficial_copiaLineas(idPresupuesto:Number, idPedido:Number):Boolean
{
	var curLineaPresupuesto:FLSqlCursor = new FLSqlCursor("lineaspresupuestoscli");
	curLineaPresupuesto.select("idpresupuesto = " + idPresupuesto);
	while (curLineaPresupuesto.next()) {
		curLineaPresupuesto.setModeAccess(curLineaPresupuesto.Browse);
		curLineaPresupuesto.refreshBuffer();
		if (!this.iface.copiaLineaPresupuesto(curLineaPresupuesto, idPedido))
			return false;
	}
	return true;
}

function oficial_copiaLineaPresupuesto(curLineaPresupuesto:FLSqlCursor, idPedido:Number):Number
{
	if (!this.iface.curLineaPedido)
		this.iface.curLineaPedido = new FLSqlCursor("lineaspedidoscli");
	
	with (this.iface.curLineaPedido) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idpedido", idPedido);
	}
	
	if (!this.iface.datosLineaPedido(curLineaPresupuesto))
		return false;
		
	if (!this.iface.curLineaPedido.commitBuffer())
		return false;
	
	return this.iface.curLineaPedido.valueBuffer("idlinea");
}

/** \D Copia los datos de una l�nea de presupuesto en una l�nea de pedido
@param	curLineaPresupuesto: Cursor que contiene los datos a incluir en la l�nea de pedido
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean
{
	with (this.iface.curLineaPedido) {
		setValueBuffer("idlineapresupuesto", curLineaPresupuesto.valueBuffer("idlinea"));
		setValueBuffer("pvpunitario", curLineaPresupuesto.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaPresupuesto.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaPresupuesto.valueBuffer("pvptotal"));
		setValueBuffer("cantidad", curLineaPresupuesto.valueBuffer("cantidad"));
		setValueBuffer("referencia", curLineaPresupuesto.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaPresupuesto.valueBuffer("descripcion"));
		setValueBuffer("codimpuesto", curLineaPresupuesto.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaPresupuesto.valueBuffer("iva"));
		setValueBuffer("recargo", curLineaPresupuesto.valueBuffer("recargo"));
		setValueBuffer("dtolineal", curLineaPresupuesto.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaPresupuesto.valueBuffer("dtopor"));
	}
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
