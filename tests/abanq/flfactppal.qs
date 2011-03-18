/***************************************************************************
                 flfactppal.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004-2006 by InfoSiAL S.L.
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
	function afterCommit_dirclientes(curDirCli:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_dirclientes(curDirCli);
	}
	function afterCommit_dirproveedores(curDirProv:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_dirproveedores(curDirProv);
	}
	function afterCommit_clientes(curCliente:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_clientes(curCliente);
	}
	function beforeCommit_clientes(curCliente:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_clientes(curCliente);
	}
	function afterCommit_proveedores(curProveedor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_proveedores(curProveedor);
	}
	function beforeCommit_proveedores(curProveedor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_proveedores(curProveedor);
	}
	function afterCommit_empresa(curEmpresa:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_empresa(curEmpresa);
	}
	function beforeCommit_cuentasbcocli(curCuenta:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_cuentasbcocli(curCuenta);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function msgNoDisponible(nombreModulo:String) {
		return this.ctx.oficial_msgNoDisponible(nombreModulo);
	}
	function ejecutarQry(tabla:String, campos:String, where:String, listaTablas:String):Array {
		return this.ctx.oficial_ejecutarQry(tabla, campos, where, listaTablas);
	}
	function valorDefectoEmpresa(fN:String):String {
		return this.ctx.oficial_valorDefectoEmpresa(fN);
	}
	function cerosIzquierda(numero:String, totalCifras:Number):String {
		return this.ctx.oficial_cerosIzquierda(numero, totalCifras);
	}
	function espaciosDerecha(texto:String, totalLongitud:Number):String {
		return this.ctx.oficial_espaciosDerecha(texto, totalLongitud);
	}
	function valoresIniciales() {
		return this.ctx.oficial_valoresIniciales();
	}
	function valorQuery(tablas:String, select:String, from:String, where:String):Array {
		return this.ctx.oficial_valorQuery(tablas, select, from, where);
	}
	function crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
		return this.ctx.oficial_crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
	}
	function borrarSubcuenta(idSubcuenta:String):Boolean {
		return this.ctx.oficial_borrarSubcuenta(idSubcuenta);
	}
	function ejercicioActual():String {
		return this.ctx.oficial_ejercicioActual();
	}
	function cambiarEjercicioActual(codEjercicio:String):Boolean {
		return this.ctx.oficial_cambiarEjercicioActual(codEjercicio);
	}
	function datosCtaCliente(codCliente:String, valoresDefecto:Array):Array {
		return this.ctx.oficial_datosCtaCliente(codCliente, valoresDefecto);
	}
	function datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array {
		return this.ctx.oficial_datosCtaProveedor(codProveedor, valoresDefecto);
	}
	function calcularIntervalo(codIntervalo:String):Array {
		return this.ctx.oficial_calcularIntervalo(codIntervalo);
	}
	function crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio);
	}
	function rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean {
		return this.ctx.oficial_rellenarSubcuentasCli(codCliente, codSubcuenta, nombre);
	}
	function crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio);
	}
	function rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean {
		return this.ctx.oficial_rellenarSubcuentasProv(codProveedor, codSubcuenta, nombre);
	}
	function automataActivado():Boolean {
		return this.ctx.oficial_automataActivado();
	}
	function clienteActivo(codCliente:String, fecha:String):Boolean {
		return this.ctx.oficial_clienteActivo(codCliente, fecha);
	}
	function obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String) {
		return this.ctx.oficial_obtenerProvincia(formulario, campoId, campoProvincia, campoPais);
	}
	function actualizarContactos20070525():Boolean {
		return this.ctx.oficial_actualizarContactos20070525();
	}
	function lanzarEvento(cursor:FLSqlCursor, evento:String):Boolean {
		return this.ctx.oficial_lanzarEvento(cursor, evento);
	}
	function actualizarContactosDeAgenda20070525(codCliente:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {
		return this.ctx.oficial_actualizarContactosDeAgenda20070525(codCliente,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)
	}
	function actualizarContactosProv20070702():Boolean {
		return this.ctx.oficial_actualizarContactosProv20070702();
	}
	function actualizarContactosDeAgendaProv20070702(codProveedor:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {
		return this.ctx.oficial_actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)
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
	function pub_msgNoDisponible(modulo:String) {
		return this.msgNoDisponible(modulo);
	}
	function pub_ejecutarQry(tabla:String, campos:String, where:String, listaTablas:String):Array {
		return this.ejecutarQry(tabla, campos, where, listaTablas);
	}
	function pub_valorDefectoEmpresa(fN:String):String {
		return this.valorDefectoEmpresa(fN);
	}
	function pub_valorQuery(tablas:String, select:String, from:String, where:String):String {
		return this.valorQuery(tablas, select, from, where);
	}
	function pub_cerosIzquierda(numero:String, totalCifras:Number):String {
		return this.cerosIzquierda(numero, totalCifras);
	}
	function pub_espaciosDerecha(texto:String, totalLongitud:Number):String {
		return this.espaciosDerecha(texto, totalLongitud);
	}
	function pub_ejercicioActual():String {
		return this.ejercicioActual();
	}
	function pub_cambiarEjercicioActual(codEjercicio:String):Boolean {
		return this.cambiarEjercicioActual(codEjercicio);
	}
	function pub_datosCtaCliente(codCliente:String, valoresDefecto:Array):Array {
		return this.datosCtaCliente(codCliente, valoresDefecto);
	}
	function pub_datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array {
		return this.datosCtaProveedor(codProveedor, valoresDefecto);
	}
	function pub_calcularIntervalo(codIntervalo:String):Array {
		return this.calcularIntervalo(codIntervalo);
	}
	function pub_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
		return this.crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
	}
	function pub_crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean {
		return this.crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio);
	}
	function pub_crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean {
		return this.crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio);
	}
	function pub_rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean {
		return this.rellenarSubcuentasCli(codCliente, codSubcuenta, nombre);
	}
	function pub_rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean {
		return this.rellenarSubcuentasProv(codProveedor, codSubcuenta, nombre);
	}
	function pub_automataActivado():Boolean {
		return this.automataActivado();
	}
	function pub_clienteActivo(codCliente:String, fecha:String):Boolean {
		return this.clienteActivo(codCliente, fecha);
	}
	function pub_obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String) {
		return this.obtenerProvincia(formulario, campoId, campoProvincia, campoPais);
	}
	function pub_lanzarEvento(cursor:FLSqlCursor, evento:String):Boolean {
		return this.lanzarEvento(cursor, evento);
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
function interna_init()
{
	var util:FLUtil = new FLUtil();

// -------------------------------- 20070525 -------------------------------------
	var condicion:String = util.sqlSelect("clientes", "codcliente", "(codcontacto = '' OR codcontacto IS NULL) AND (contacto <> '' AND contacto IS NOT NULL)");
	var condicionProv:String = util.sqlSelect("proveedores", "codproveedor", "(codcontacto = '' OR codcontacto IS NULL) AND (contacto <> '' AND contacto IS NOT NULL)");

	if (condicion) {
		var cursor:FLSqlCursor = new FLSqlCursor("clientes");
		cursor.transaction(false);
		try {
			if (this.iface.actualizarContactos20070525()) {
				cursor.commit();
			} else {
				cursor.rollback();
			}
		}
		catch (e) {
			cursor.rollback();
			MessageBox.warning(util.translate("scripts", "Hubo un error al actualizar los datos de contactos del m�dulo de Facturaci�n:\n" + e), MessageBox.Ok, MessageBox.NoButton);
		}
	}

	if (condicionProv) {
		var cursor:FLSqlCursor = new FLSqlCursor("proveedores");
		cursor.transaction(false);
		try {
			if (this.iface.actualizarContactosProv20070702()) {
				cursor.commit();
			} else {
				cursor.rollback();
			}
		}
		catch (e) {
			cursor.rollback();
			MessageBox.warning(util.translate("scripts", "Hubo un error al actualizar los datos de contactos del m�dulo de Facturaci�n:\n" + e), MessageBox.Ok, MessageBox.NoButton);
		}
	}
//-------------------------------- 20070525 -------------------------------------

	if (util.sqlSelect("empresa", "id", "1 = 1"))
		return;
	
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.select();
	if (!cursor.first()) {
		MessageBox.information(util.translate("scripts",
			"Se insertar� una empresa por defecto y algunos valores iniciales para empezar a trabajar."),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		this.iface.valoresIniciales();
		this.execMainScript("empresa");
	}
}

function interna_afterCommit_dirclientes(curDirCli:FLSqlCursor):Boolean
{
	if (curDirCli.modeAccess() == curDirCli.Del) {
		var domFact:String = curDirCli.valueBuffer("domfacturacion");
		var domEnv:String = curDirCli.valueBuffer("domenvio");
		if (domFact == true || domEnv == true) {
			var cursor:FLSqlCursor = new FLSqlCursor("dirclientes");
			cursor.select("codcliente = '" + curDirCli.valueBuffer("codcliente") + "' AND id <> " + curDirCli.valueBuffer("id"));
			if (cursor.first()) {
				cursor.setModeAccess(cursor.Edit);
				cursor.refreshBuffer();
				if (domFact == true)
					cursor.setValueBuffer("domfacturacion", domFact);
				if (domEnv == true)
					cursor.setValueBuffer("domenvio", domEnv);
				cursor.commitBuffer();
			}
		}
	}
	return true;
}

function interna_afterCommit_dirproveedores(curDirProv:FLSqlCursor):Boolean
{
	if (curDirProv.modeAccess() == curDirProv.Del) {
		var dirPpal:String = curDirProv.valueBuffer("direccionppal");
		if (dirPpal == true) {
			var cursor:FLSqlCursor = new FLSqlCursor("dirproveedores");
			cursor.select("codproveedor = '" + curDirProv.valueBuffer("codproveedor") + "' AND id <> " + curDirProv.valueBuffer("id"));
			if (cursor.first()) {
				cursor.setModeAccess(cursor.Edit);
				cursor.refreshBuffer();
				cursor.setValueBuffer("direccionppal", dirPpal);
				cursor.commitBuffer();
			}
		}
	}
	return true;
}

function interna_afterCommit_clientes(curCliente:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	var codSubcuenta:String = curCliente.valueBuffer("codsubcuenta");
	var idSubcuenta:Number = parseFloat(curCliente.valueBuffer("idsubcuenta"));
	var codCliente:String = curCliente.valueBuffer("codcliente");
	var idSubcuentaPrevia:Number = parseFloat(curCliente.valueBufferCopy("idsubcuenta"));
	
	switch(curCliente.modeAccess()) {
	/** \C Cuando el cliente se crea, se generan autom�ticamente las subcuentas para dicho cliente asociadas a los ejercicios con plan general contable creado.
	\end */
		case curCliente.Insert: {
			if (!this.iface.rellenarSubcuentasCli(codCliente, codSubcuenta, curCliente.valueBuffer("nombre")))
				return false;
			break;
		}
		/*
		case curCliente.Del: {
			if (!curCliente.isNull("idsubcuenta")) {
				if (!util.sqlSelect("clientes", "idsubcuenta", "idsubcuenta = " + idSubcuentaPrevia + " AND codcliente <> '" + codCliente + "'")) {
					if (!this.iface.borrarSubcuenta(idSubcuenta))
						return false;
				}
			}
			break;
		}
		*/
	}
	return true;
}

function interna_afterCommit_proveedores(curProveedor:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	var codSubcuenta:String = curProveedor.valueBuffer("codsubcuenta");
	var idSubcuenta:Number = parseFloat(curProveedor.valueBuffer("idsubcuenta"));
	var codProveedor:String = curProveedor.valueBuffer("codproveedor");
	var idSubcuentaPrevia:Number = parseFloat(curProveedor.valueBufferCopy("idsubcuenta"));

	switch(curProveedor.modeAccess()) {
		/** \C Cuando el proveedor se crea, se generan autom�ticamente las subcuentas para dicho proveedor asociadas a los ejercicios con plan general contable creado.
		\end */
		case curProveedor.Insert: {
			if (!this.iface.rellenarSubcuentasProv(codProveedor, codSubcuenta, curProveedor.valueBuffer("nombre")))
				return false;
			break;
		}
		/*
		case curProveedor.Del: {
			if (!curProveedor.isNull("idsubcuenta")) {
				if (!util.sqlSelect("proveedores", "idsubcuenta", "idsubcuenta = " + idSubcuentaPrevia + " AND codcliente <> '" + codProveedor + "'")) {
					if (!this.iface.borrarSubcuenta(idSubcuenta))
						return false;
				}
			}
			break;
		}
		*/
	}
	return true;
}

function interna_beforeCommit_proveedores(curProveedor:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	switch(curProveedor.modeAccess()) {
		/** \C Cuando el proveedor se borra, se borran las subcuentas asociadas si �stas no tienen partidas asociadas ni est�n vinculadas con otro proveedor
		\end */
		case curProveedor.Del: {
			var qrySubcuentas:FLSqlQuery = new FLSqlQuery();
			qrySubcuentas.setTablesList("co_subcuentasprov,co_subcuentas");
			qrySubcuentas.setSelect("s.codsubcuenta,s.descripcion,s.codejercicio,s.saldo,s.idsubcuenta");
			qrySubcuentas.setFrom("co_subcuentasprov sp INNER JOIN co_subcuentas s ON sp.idsubcuenta = s.idsubcuenta")
			qrySubcuentas.setWhere("sp.codproveedor = '" + curProveedor.valueBuffer("codproveedor") + "'");
			try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}
			if (!qrySubcuentas.exec())
				return false;

			var idSubcuenta:String;
			while (qrySubcuentas.next()) {
				idSubcuenta = qrySubcuentas.value("s.idsubcuenta"); 
				if (parseFloat(qrySubcuentas.value("s.saldo")) != 0)
					continue; 
				if (util.sqlSelect("co_partidas", "idpartida", "idsubcuenta = " + idSubcuenta))
					continue;
				if (util.sqlSelect("co_subcuentasprov", "idsubcuenta", "idsubcuenta = " + idSubcuenta + " AND codproveedor <> '" + curProveedor.valueBuffer("codproveedor") + "'"))
					continue;
				if (!util.sqlDelete("co_subcuentas", "idsubcuenta = " + idSubcuenta))
					return false;
			}
		}
	}
	return true;
}

function interna_beforeCommit_clientes(curCliente:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	switch(curCliente.modeAccess()) {
		/** \C Cuando el cliente se borra, se borran las subcuentas asociadas si �stas no tienen partidas asociadas ni est�n vinculadas con otro cliente
		\end */
		case curCliente.Del: {
			var qrySubcuentas:FLSqlQuery = new FLSqlQuery();
			qrySubcuentas.setTablesList("co_subcuentascli,co_subcuentas");
			qrySubcuentas.setSelect("s.codsubcuenta,s.descripcion,s.codejercicio,s.saldo,s.idsubcuenta");
			qrySubcuentas.setFrom("co_subcuentascli sc INNER JOIN co_subcuentas s ON sc.idsubcuenta = s.idsubcuenta")
			qrySubcuentas.setWhere("sc.codcliente = '" + curCliente.valueBuffer("codcliente") + "'");
			try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}
			if (!qrySubcuentas.exec())
				return false;
			
			var idSubcuenta:String;
			while (qrySubcuentas.next()) {
				idSubcuenta = qrySubcuentas.value("s.idsubcuenta"); 
				if (parseFloat(qrySubcuentas.value("s.saldo")) != 0)
					continue; 
				if (util.sqlSelect("co_partidas", "idpartida", "idsubcuenta = " + idSubcuenta))
					continue;
				if (util.sqlSelect("co_subcuentascli", "idsubcuenta", "idsubcuenta = " + idSubcuenta + " AND codcliente <> '" + curCliente.valueBuffer("codcliente") + "'"))
					continue;
				if (!util.sqlDelete("co_subcuentas", "idsubcuenta = " + idSubcuenta))
					return false;
			}
		}
	}
	return true;
}

/** \C Cuando cambia el ejercicio actual se establece el t�tulo de las ventanas principales con
el nombre del ejercicio seleccionado
\end */
/** \D Cuando cambia el ejercicio actual se establece una variable global (ver FLVar) con el c�digo
del ejercicio seleccionado. El nombre de esta variable est� fomado por el literal "ejerUsr_" seguido
del nombre del usuario actual obtenido con la funci�n sys.nameUser(). Esto significa que por cada usuario
se almacena el ejercicio en el que se encuentra.
\end */
function interna_afterCommit_empresa(curEmpresa:FLSqlCursor):Boolean {
	/*
	var util:FLUtil = new FLUtil();
	var codejercicio:String = curEmpresa.valueBuffer( "codejercicio" );
	var nombreEjercicio:String = util.sqlSelect( "ejercicios", "nombre", "codejercicio='" + codejercicio + "'" );
	sys.setCaptionMainWidget( nombreEjercicio );

	var ejerUsr:FLVar = new FLVar();
	var idVar:String = "ejerUsr_" + sys.nameUser();
	ejerUsr.set( idVar, codejercicio );
	*/
}

function interna_beforeCommit_cuentasbcocli(curCuenta:FLSqlCursor):Boolean
{
	/** \C No se permite borrar la cuenta de un cliente si tiene recibos pendientes de pago asociados a dicha cuenta
	\end */
	switch(curCuenta.modeAccess()) {
	
		case curCuenta.Del:
			var util:FLUtil = new FLUtil;
			var codRecibo:String = util.sqlSelect("reciboscli", "codigo", "codcliente = '" + curCuenta.valueBuffer("codcliente") + "' AND codcuenta = '" + curCuenta.valueBuffer("codcuenta") + "' AND estado <> 'Pagado'");
			if (codRecibo && codRecibo != "") {
				MessageBox.warning(util.translate("scripts", "No puede eliminar la cuenta del cliente porque hay al menos un recibo (%1) pendiente de pago asociado a esta cuenta.\nDebe cambiar la cuenta de los recibos pendientes de este cliente antes de borrarla.").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		break;
	}
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_msgNoDisponible(nombreModulo:String)
{
	var util:FLUtil = new FLUtil();
	MessageBox.information(util.translate("scripts", "El m�dulo '") +
		nombreModulo + util.translate("scripts",
		"' s�lo est� disponible a trav�s de suscripci�n.\n\nSi ha probado AbanQ y considera que puede serle �til, tiene\nla opci�n de suscribirse mediante una peque�a aportaci�n para tener\nacceso a la zona de descargas (www.abanq.org), adem�s de a un\nforo de soporte.\n\nCon su suscripci�n obtiene una aplicaci�n estable\ny dispone del soporte de InfoSiAL (www.infosial.com), al tiempo\nque ayuda a seguir desarrollando y mejorando este software libre."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

/** \D Ejecuta la query especificada y devuelve un array con los datos de los campos seleccionados. Devuelve un campo extra 'result' que es 1 = Ok, 0 = Error, -1 No encontrado
@param	tabla: Nombre de la tabla
@param	campos: Nombre de los campos, separados por comas
@param	where: Cl�usula where
@param	listaTablas: Lista de las tablas empleadas en la consulta. Este par�metro es opcional y se usa si la consulta afecta a m�s de una tabla.
@return	Array con los valores de los campos solicitados, m�s el campo result.
\end */
function oficial_ejecutarQry(tabla:String, campos:String, where:String, listaTablas:String):Array
{
	var util:FLUtil = new FLUtil;
	var campo:Array = campos.split(",");
	var valor:Array = [];
	valor["result"] = 1;
	var query:FLSqlQuery = new FLSqlQuery();
	if (listaTablas)
		query.setTablesList(listaTablas);
	else
		query.setTablesList(tabla);
	try { query.setForwardOnly( true ); } catch (e) {}
	query.setSelect(campo);
	query.setFrom(tabla);
	query.setWhere(where);
	if (query.exec()) {
		if (query.next()) {
			for (var i:Number = 0; i < campo.length; i++) {
				valor[campo[i]] = query.value(i);
			}
		} else {
			valor.result = -1;
		}
	} else {
		MessageBox.critical(util.translate("scripts", "Fall� la consulta") + query.sql(),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		valor.result = 0;
	}

	return valor;
}

function oficial_valorDefectoEmpresa(fN:String):String
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList( "empresa" );
	try { query.setForwardOnly( true ); } catch (e) {}
	query.setSelect( fN );
	query.setFrom( "empresa" );
	if ( query.exec() )
		if ( query.next() )
			return query.value( 0 );

	return "";
}

/** \D Devuelve el ejercicio actual para el usuario conectado
@return	codEjercicio: C�digo del ejercicio actual
\end */
function oficial_ejercicioActual():String
{
	var util:FLUtil = new FLUtil;
	var codEjercicio:String 
	try {
		var settingKey:String = "ejerUsr_" + sys.nameUser();
		codEjercicio = util.readDBSettingEntry(settingKey);
		/*if (!codEjercicio)
			codEjercicio = this.iface.cambiarEjercicioActual(this.iface.valorDefectoEmpresa("codejercicio"));*/
	}
	catch ( e ) {}
	
	if (!codEjercicio)
		codEjercicio = this.iface.valorDefectoEmpresa("codejercicio");
	
	return codEjercicio;
}

/** \D Establece el ejercicio actual para el usuario conectado
Cuando cambia el ejercicio actual se establece un setting de base de datos (tabla flsettings) con el c�digo
del ejercicio seleccionado. El nombre de esta variable est� fomado por el literal "ejerUsr_" seguido
del nombre del usuario actual obtenido con la funci�n sys.nameUser(). Esto significa que por cada usuario
se almacena el ejercicio en el que se encuentra.

@param	codEjercicio: C�digo del ejercicio actual
@return	true si la asignaci�n del ejercicio se realiz� correctamente, false en caso contrario
\end */
function oficial_cambiarEjercicioActual(codEjercicio:String):Boolean
{
	var util:FLUtil = new FLUtil();
	var ok:Boolean = false;
	
	try {
		var settingKey:String = "ejerUsr_" + sys.nameUser();
		ok = util.writeDBSettingEntry(settingKey, codEjercicio);
	}
	catch (e) {}
	
	return ok;
}

function oficial_cerosIzquierda(numero:String, totalCifras:Number):String
{
	var ret:String = numero.toString();
	var numCeros:Number = totalCifras - ret.length;
	for ( ; numCeros > 0 ; --numCeros)
		ret = "0" + ret;
	return ret;
}

function oficial_espaciosDerecha(texto:String, totalLongitud:Number):String
{
	var ret:String = texto.toString();
	var numEspacios:Number = totalLongitud - ret.length;
	for ( ; numEspacios > 0 ; --numEspacios)
		ret += " ";
	return ret;
}

function oficial_valoresIniciales()
{
	var cursor:FLSqlCursor = new FLSqlCursor("bancos");
	var bancos:Array =
		[["0030", "BANESTO"],["0112", "BANCO URQUIJO"],
		["2085", "IBERCAJA"],["0093", "BANCO DE VALENCIA"],
		["2059", "CAIXA SABADELL"],["2073", "CAIXA TARRAGONA"],
		["2038", "CAJA MADRID"],["2091", "CAIXA GALICIA"],
		["0019", "DEUTSCHE BANK"],["0081", "BANCO DE SABADELL"],
		["0049", "BANCO SANTANDER CENTRAL HISPANO"],["0072", "BANCO PASTOR"],
		["0075", "BANCO POPULAR"],["0182","BANCO BILBAO VIZCAYA ARGENTARIA"],
		["0128", "BANKINTER"],["2090", "C.A.M."],["2100", "LA CAIXA"],
		["2077", "BANCAJA"],["0008", "BANCO ATLANTICO"],
		["0061", "BANCA MARCH"],["0065", "BARCLAYS BANK"],
		["0073", "PATAGON INTERNET BANK"],["0103", "BANCO ZARAGOZANO"],
		["2013", "CAIXA CATALUNYA"],["2043","CAJA MURCIA"],
		["2103", "UNICAJA"],["2105", "CAJA DE CASTILLA LA MANCHA"],
		["0042", "BANCO GUIPUZCOANO"],["0138", "BANKOA"],
		["3056", "CAJA RURAL DE ALBACETE"]];
	for (var i:Number = 0; i < bancos.length; i++) {
		with(cursor) {
			setModeAccess(cursor.Insert);
			refreshBuffer();
			setValueBuffer("entidad", bancos[i][0]);
			setValueBuffer("nombre", bancos[i][1]);
			commitBuffer();
		}
	}
	delete cursor;

	cursor = new FLSqlCursor("impuestos");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "IVA16");
		setValueBuffer("descripcion", "I.V.A. 16%");
		setValueBuffer("iva", "16");
		setValueBuffer("recargo", "4");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "IVA7");
		setValueBuffer("descripcion", "I.V.A. 7%");
		setValueBuffer("iva", "7");
		setValueBuffer("recargo", "1");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "IVA4");
		setValueBuffer("descripcion", "I.V.A. 4%");
		setValueBuffer("iva", "4");
		setValueBuffer("recargo", "0.5");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("paises");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpais", "ESP");
		setValueBuffer("nombre", "ESPA�A");
		setValueBuffer("bandera", "/* XPM */\nstatic char * esp_xpm[] = {\n\"30 16 16 1\",\n\"	c #6C1E04\",\n\".	c #B78B19\",\n\"+	c #E4D31A\",\n\"@	c #8E4F09\",\n\"#	c #FBFC05\",\n\"$	c #EF0406\",\n\"%	c #F9978D\",\n\"&	c #FCFA36\",\n\"*	c #FC595C\",\n\"=	c #E1B025\",\n\"-	c #FB3634\",\n\";	c #E67559\",\n\">	c #A26E13\",\n\",	c #FCACAC\",\n\"'	c #B29F19\",\n\")	c #9D0204\",\n\",,%%%%%%%%%%%%%%%%%%%%%%%%%%;$\",\n\";;**************************$)\",\n\"--$$$$$$$$$$$$$$$$$$$$$$$$$$$)\",\n\"--$$$$$$$$$$$$$$$$$$$$$$$$$$$)\",\n\"&&####&#&++&################+'\",\"&&####&=.>..&###############+'\",\n\"&&####@=@@@=>=##############+'\",\n\"&&####='>;>%=+&#############+'\",\n\"&&####@@@ @>>.##############+'\",\n\"&&####.=>@;;#;##############+'\",\"&&+###>..>..>=##############+'\",\n\"&&####.+===+.+&#############+.\",\n\"--$$$$$$$$$$$$$$$$$$$$$$$$$$$)\",\n\"--$$$$$$$$$$$$$$$$$$$$$$$$$$$)\",\n\"$$$)$)$)$))$)$)$)$)$)$)$)$)$))\",\n\"))))))))))))))))))))))))))))))\"};\n");
		setValueBuffer("codiso", "ES");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("divisas");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "EUR");
		setValueBuffer("descripcion", "EUROS");
		setValueBuffer("tasaconv", "1");
		setValueBuffer("codiso", "978");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "USD");
		setValueBuffer("descripcion", "D�LARES USA");
		setValueBuffer("tasaconv", "0.845");
		setValueBuffer("codiso", "849");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "GBP");
		setValueBuffer("descripcion", "LIBRAS ESTERLINAS");
		setValueBuffer("tasaconv", "1.48");
		setValueBuffer("codiso", "826");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "CHF");
		setValueBuffer("descripcion", "FRANCOS SUIZOS");
		setValueBuffer("tasaconv", "0.648");
		setValueBuffer("codiso", "756");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "SEK");
		setValueBuffer("descripcion", "CORONAS SUECAS");
		setValueBuffer("tasaconv", "0.106");
		setValueBuffer("codiso", "752");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "NOK");
		setValueBuffer("descripcion", "CORONAS NORUEGAS");
		setValueBuffer("tasaconv", "0.126");
		setValueBuffer("codiso", "578");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "NZD");
		setValueBuffer("descripcion", "D�LARES NEOZELANDESES");
		setValueBuffer("tasaconv", "0.608");
		setValueBuffer("codiso", "554");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "JPY");
		setValueBuffer("descripcion", "YENES JAPONESES");
		setValueBuffer("tasaconv", "0.007");
		setValueBuffer("codiso", "392");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "DKK");
		setValueBuffer("descripcion", "CORONAS DANESAS");
		setValueBuffer("tasaconv", "0.134");
		setValueBuffer("codiso", "208");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "CAD");
		setValueBuffer("descripcion", "D�LARES CANADIENSES");
		setValueBuffer("tasaconv", "0.735");
		setValueBuffer("codiso", "124");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "AUD");
		setValueBuffer("descripcion", "D�LARES AUSTRALIANOS");
		setValueBuffer("tasaconv", "0.639");
		setValueBuffer("codiso", "036");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("formaspago");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CONT");
		setValueBuffer("descripcion", "CONTADO");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("plazos");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CONT");
		setValueBuffer("dias", "0");
		setValueBuffer("aplazado", "100");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("ejercicios");
	var hoy:Date = new Date()
	var fechaInicio:Date = new Date(hoy.getYear(), 1, 1);
	var fechaFin:Date = new Date(hoy.getYear(), 12, 31);
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codejercicio", "0001");
		setValueBuffer("nombre", "EJERCICIO 1");
		setValueBuffer("fechainicio", fechaInicio);
		setValueBuffer("fechafin", fechaFin);
		setValueBuffer("estado", "ABIERTO");
		commitBuffer();
	}
	delete cursor;

	this.iface.cambiarEjercicioActual( "0001" );

	cursor = new FLSqlCursor("series");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "A");
		setValueBuffer("descripcion", "SERIE A");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("secuenciasejercicios");
	var idSec:Number;
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "A");
		setValueBuffer("codejercicio", "0001");
		idSec = valueBuffer( "id" );
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("secuencias");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec);
		setValueBuffer("nombre", "nfacturacli");
		setValueBuffer("valor", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec);
		setValueBuffer("nombre", "nfacturaprov");
		setValueBuffer("valor", 1);
		commitBuffer();
	}
	delete cursor;
	
	cursor = new FLSqlCursor("empresa");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("nombre", "InfoSiAL, S.L. - Creadores de AbanQ - http://www.infosial.com");
		setValueBuffer("cifnif", "B02352961");
		setValueBuffer("administrador", "FEDERICO ALBUJER ZORNOZA");
		setValueBuffer("direccion", "C/. SAN ANTONIO, 88");
		setValueBuffer("codejercicio", "0001");
		setValueBuffer("coddivisa", "EUR");
		setValueBuffer("codpago", "CONT");
		setValueBuffer("codserie", "A");
		setValueBuffer("codpostal", "02640");
		setValueBuffer("ciudad", "ALMANSA");
		setValueBuffer("provincia", "ALBACETE");
		setValueBuffer("telefono", "967 345 174");
		setValueBuffer("email", "mail@infosial.com");
		setValueBuffer("codpais", "ESP");
		setValueBuffer("logo", "/* XPM */\n static char * minilogoinfosial_xpm[] = {\n \"125 43 392 2\",\n \"  	c None\",\n \". 	c #5172B6\",\n \"+ 	c #5D7CBB\",\n \"@ 	c #8CA2CF\",\n \"# 	c #93A7D2\",\n \"$ 	c #BAC7E2\",\n \"% 	c #FDFDFE\",\n \"& 	c #FCFCFE\",\n \"* 	c #FBFCFD\",\n \"= 	c #FCFDFE\",\n \"- 	c #FFFFFF\",\n \"; 	c #FEFEFE\",\n \"> 	c #CED7EA\",\n \", 	c #AABADB\",\n \"' 	c #5676B8\",\n \") 	c #6381BE\",\n \"! 	c #E1E7F2\",\n \"~ 	c #748FC5\",\n \"{ 	c #B9C6E1\",\n \"] 	c #738DC4\",\n \"^ 	c #B7C5E1\",\n \"/ 	c #F7F1ED\",\n \"( 	c #E1CABB\",\n \"_ 	c #E4CFC2\",\n \": 	c #FCFAF8\",\n \"< 	c #F1E6DE\",\n \"[ 	c #A76135\",\n \"} 	c #923C05\",\n \"| 	c #933E08\",\n \"1 	c #B57A55\",\n \"2 	c #FBF8F6\",\n \"3 	c #F2E8E1\",\n \"4 	c #D1AC95\",\n \"5 	c #D7B7A3\",\n \"6 	c #FAF6F4\",\n \"7 	c #B7C4E0\",\n \"8 	c #BC8866\",\n \"9 	c #903800\",\n \"0 	c #913A03\",\n \"a 	c #D5B49F\",\n \"b 	c #F5EDE8\",\n \"c 	c #A15627\",\n \"d 	c #903801\",\n \"e 	c #913902\",\n \"f 	c #B67C57\",\n \"g 	c #B5C1DC\",\n \"h 	c #AF6F47\",\n \"i 	c #C79A7E\",\n \"j 	c #D9BCA9\",\n \"k 	c #CCA48A\",\n \"l 	c #913A02\",\n \"m 	c #95400B\",\n \"n 	c #E2CBBC\",\n \"o 	c #E7D3C7\",\n \"p 	c #933E07\",\n \"q 	c #9C4E1C\",\n \"r 	c #556FAC\",\n \"s 	c #636182\",\n \"t 	c #64617F\",\n \"u 	c #576DA5\",\n \"v 	c #F9F5F2\",\n \"w 	c #C59779\",\n \"x 	c #A25829\",\n \"y 	c #A55E31\",\n \"z 	c #D4B29D\",\n \"A 	c #FEFDFC\",\n \"B 	c #FDFCFB\",\n \"C 	c #A45C2E\",\n \"D 	c #A9653A\",\n \"E 	c #E0C8B8\",\n \"F 	c #586BA1\",\n \"G 	c #834424\",\n \"H 	c #8F3903\",\n \"I 	c #8F3902\",\n \"J 	c #874019\",\n \"K 	c #5F658D\",\n \"L 	c #FEFDFD\",\n \"M 	c #F8F2EF\",\n \"N 	c #F9F4F1\",\n \"O 	c #FBF7F5\",\n \"P 	c #E8D5CA\",\n \"Q 	c #5370AF\",\n \"R 	c #616388\",\n \"S 	c #6E5863\",\n \"T 	c #715458\",\n \"U 	c #6A5B6E\",\n \"V 	c #566DA8\",\n \"W 	c #794D42\",\n \"X 	c #834426\",\n \"Y 	c #5271B2\",\n \"Z 	c #F4F6FB\",\n \"` 	c #DBE2F0\",\n \" .	c #CBD4E9\",\n \"..	c #C1CDE5\",\n \"+.	c #E0E6F2\",\n \"@.	c #F7F8FB\",\n \"#.	c #FDFEFE\",\n \"$.	c #E1C8B9\",\n \"%.	c #9B4C19\",\n \"&.	c #923B04\",\n \"*.	c #A3592B\",\n \"=.	c #EFE2DA\",\n \"-.	c #F4F6FA\",\n \";.	c #F6F8FB\",\n \">.	c #F5F7FB\",\n \",.	c #5271B3\",\n \"'.	c #5F658E\",\n \").	c #626284\",\n \"!.	c #616387\",\n \"~.	c #546FAD\",\n \"{.	c #5D6794\",\n \"].	c #824528\",\n \"^.	c #8E3905\",\n \"/.	c #626385\",\n \"(.	c #5470AE\",\n \"_.	c #E7ECF5\",\n \":.	c #95A9D3\",\n \"<.	c #5F7DBC\",\n \"[.	c #617FBD\",\n \"}.	c #A5B6DA\",\n \"|.	c #FCFAF9\",\n \"1.	c #AD6D44\",\n \"2.	c #C29273\",\n \"3.	c #C4CFE6\",\n \"4.	c #B1C0DF\",\n \"5.	c #758FC5\",\n \"6.	c #5B7ABA\",\n \"7.	c #546FAC\",\n \"8.	c #844322\",\n \"9.	c #8D3B09\",\n \"0.	c #5C6896\",\n \"a.	c #556EAA\",\n \"b.	c #87411B\",\n \"c.	c #8E3A07\",\n \"d.	c #7D4936\",\n \"e.	c #5370B1\",\n \"f.	c #D3DBEC\",\n \"g.	c #6582BE\",\n \"h.	c #5374B7\",\n \"i.	c #6B87C1\",\n \"j.	c #7C95C8\",\n \"k.	c #7D96C8\",\n \"l.	c #7992C7\",\n \"m.	c #6683BF\",\n \"n.	c #5273B7\",\n \"o.	c #A2B4D8\",\n \"p.	c #FEFEFF\",\n \"q.	c #AE6F46\",\n \"r.	c #C39375\",\n \"s.	c #8299CA\",\n \"t.	c #F9FAFC\",\n \"u.	c #6C5967\",\n \"v.	c #8D3A08\",\n \"w.	c #7D4A38\",\n \"x.	c #7A4C3F\",\n \"y.	c #5A6A9D\",\n \"z.	c #5D6792\",\n \"A.	c #8A3E12\",\n \"B.	c #8C3C0B\",\n \"C.	c #675E78\",\n \"D.	c #F0F3F9\",\n \"E.	c #708BC3\",\n \"F.	c #5978B9\",\n \"G.	c #B5C3E0\",\n \"H.	c #F1F4F9\",\n \"I.	c #ECF0F7\",\n \"J.	c #C6D1E7\",\n \"K.	c #E6EBF5\",\n \"L.	c #E2CABC\",\n \"M.	c #F0E4DD\",\n \"N.	c #E5EAF4\",\n \"O.	c #5273B6\",\n \"P.	c #5373B7\",\n \"Q.	c #D6DEEE\",\n \"R.	c #80472E\",\n \"S.	c #6B5A6C\",\n \"T.	c #5271B4\",\n \"U.	c #5172B5\",\n \"V.	c #596B9E\",\n \"W.	c #6C5968\",\n \"X.	c #5C6895\",\n \"Y.	c #C4D0E6\",\n \"Z.	c #9AADD4\",\n \"`.	c #FFFEFE\",\n \" +	c #F6EEEA\",\n \".+	c #ECDDD4\",\n \"++	c #F9F3F0\",\n \"@+	c #A7B8DA\",\n \"#+	c #5C7BBB\",\n \"$+	c #C5D0E7\",\n \"%+	c #5777B9\",\n \"&+	c #97AAD3\",\n \"*+	c #8C3C0C\",\n \"=+	c #596B9F\",\n \"-+	c #B6C4E0\",\n \";+	c #C0CCE4\",\n \">+	c #6C88C1\",\n \",+	c #7B94C8\",\n \"'+	c #F8F9FC\",\n \")+	c #7791C6\",\n \"!+	c #F7F8FC\",\n \"~+	c #6A5A6C\",\n \"{+	c #655F7C\",\n \"]+	c #576DA6\",\n \"^+	c #76504B\",\n \"/+	c #75504D\",\n \"(+	c #685D74\",\n \"_+	c #556EA9\",\n \":+	c #626386\",\n \"<+	c #8E3A06\",\n \"[+	c #8D3B08\",\n \"}+	c #6F565F\",\n \"|+	c #6B5A6A\",\n \"1+	c #794D43\",\n \"2+	c #725355\",\n \"3+	c #566EA9\",\n \"4+	c #BFCBE4\",\n \"5+	c #5272B6\",\n \"6+	c #8DA2CF\",\n \"7+	c #8199CA\",\n \"8+	c #6A86C1\",\n \"9+	c #CAD4E9\",\n \"0+	c #5575B8\",\n \"a+	c #B9C6E2\",\n \"b+	c #ACBCDC\",\n \"c+	c #774F49\",\n \"d+	c #636181\",\n \"e+	c #86411E\",\n \"f+	c #745150\",\n \"g+	c #774F48\",\n \"h+	c #8F3904\",\n \"i+	c #864525\",\n \"j+	c #814B35\",\n \"k+	c #874421\",\n \"l+	c #844321\",\n \"m+	c #64607E\",\n \"n+	c #E9EDF6\",\n \"o+	c #5475B7\",\n \"p+	c #9AADD5\",\n \"q+	c #EAEEF6\",\n \"r+	c #FEFFFF\",\n \"s+	c #8DA3CF\",\n \"t+	c #E4E9F4\",\n \"u+	c #75514F\",\n \"v+	c #8C3B0B\",\n \"w+	c #8B3D10\",\n \"x+	c #7D4A37\",\n \"y+	c #80472F\",\n \"z+	c #8D3C0B\",\n \"A+	c #6D667D\",\n \"B+	c #5E7AB6\",\n \"C+	c #5B7EC0\",\n \"D+	c #5E79B3\",\n \"E+	c #745D67\",\n \"F+	c #8C3B0A\",\n \"G+	c #665F7A\",\n \"H+	c #CBD5E9\",\n \"I+	c #6482BE\",\n \"J+	c #98ACD4\",\n \"K+	c #D4DCED\",\n \"L+	c #FBFCFE\",\n \"M+	c #8EA4D0\",\n \"N+	c #89A0CE\",\n \"O+	c #5877B9\",\n \"P+	c #DBE1F0\",\n \"Q+	c #893E14\",\n \"R+	c #7A4C3E\",\n \"S+	c #87401A\",\n \"T+	c #675E76\",\n \"U+	c #735354\",\n \"V+	c #8E3A05\",\n \"W+	c #76504A\",\n \"X+	c #64607F\",\n \"Y+	c #725458\",\n \"Z+	c #735F6A\",\n \"`+	c #5C7DBD\",\n \" @	c #7B544C\",\n \".@	c #883F17\",\n \"+@	c #576CA4\",\n \"@@	c #DAE0EF\",\n \"#@	c #BBC8E3\",\n \"$@	c #B0BFDE\",\n \"%@	c #D2DBEC\",\n \"&@	c #C9D3E8\",\n \"*@	c #5474B7\",\n \"=@	c #9DB0D6\",\n \"-@	c #85421F\",\n \";@	c #576CA5\",\n \">@	c #566EA8\",\n \",@	c #6A5B6F\",\n \"'@	c #8B3C0D\",\n \")@	c #596BA0\",\n \"!@	c #586CA2\",\n \"~@	c #5F78B1\",\n \"{@	c #666F97\",\n \"]@	c #6B5A6B\",\n \"^@	c #8FA4D0\",\n \"/@	c #6280BD\",\n \"(@	c #7891C6\",\n \"_@	c #E2E8F3\",\n \":@	c #FAFBFD\",\n \"<@	c #F0F2F9\",\n \"[@	c #6F5660\",\n \"}@	c #71555A\",\n \"|@	c #616489\",\n \"1@	c #65719C\",\n \"2@	c #7B4B3D\",\n \"3@	c #5272B4\",\n \"4@	c #F2F4F9\",\n \"5@	c #BAC8E2\",\n \"6@	c #EFF2F8\",\n \"7@	c #D4DDED\",\n \"8@	c #718CC3\",\n \"9@	c #A1B3D7\",\n \"0@	c #A1B3D8\",\n \"a@	c #6F8BC3\",\n \"b@	c #C0CCE5\",\n \"c@	c #6C5969\",\n \"d@	c #6E5761\",\n \"e@	c #725357\",\n \"f@	c #695C70\",\n \"g@	c #6D667F\",\n \"h@	c #5B7EBF\",\n \"i@	c #745E67\",\n \"j@	c #EDF0F7\",\n \"k@	c #829ACB\",\n \"l@	c #894119\",\n \"m@	c #65719D\",\n \"n@	c #696C8E\",\n \"o@	c #8C3D0F\",\n \"p@	c #824529\",\n \"q@	c #D0D9EB\",\n \"r@	c #F3F5FA\",\n \"s@	c #BCC9E3\",\n \"t@	c #BCC8E3\",\n \"u@	c #6885C0\",\n \"v@	c #636283\",\n \"w@	c #8D3C0C\",\n \"x@	c #7E5042\",\n \"y@	c #77595B\",\n \"z@	c #804E3B\",\n \"A@	c #8BA2CF\",\n \"B@	c #ABBBDC\",\n \"C@	c #A4B5D9\",\n \"D@	c #596A9E\",\n \"E@	c #8B3D0E\",\n \"F@	c #B3C2DF\",\n \"G@	c #A9BADB\",\n \"H@	c #E3E8F3\",\n \"I@	c #5878B9\",\n \"J@	c #6B88C1\",\n \"K@	c #784E46\",\n \"L@	c #CDD6EA\",\n \"M@	c #DAE1EF\",\n \"N@	c #F3F6FA\",\n \"O@	c #5E7CBB\",\n \"P@	c #607EBC\",\n \"Q@	c #E8ECF5\",\n \"R@	c #DCE3F0\",\n \"S@	c #859CCC\",\n \"T@	c #889ECD\",\n \"U@	c #5979BA\",\n \"V@	c #ECEFF7\",\n \"W@	c #8AA0CE\",\n \"X@	c #6D89C2\",\n \"Y@	c #7D96C9\",\n \"Z@	c #889FCD\",\n \"`@	c #839ACB\",\n \" #	c #5A699B\",\n \".#	c #7F4730\",\n \"+#	c #646181\",\n \"@#	c #5A7ABA\",\n \"##	c #DDE3F1\",\n \"$#	c #6481BE\",\n \"%#	c #F1F3F9\",\n \"&#	c #6A5B6D\",\n \"*#	c #70555C\",\n \"=#	c #6F5761\",\n \"-#	c #566DA6\",\n \";#	c #5E6690\",\n \">#	c #60658C\",\n \",#	c #6E5763\",\n \"'#	c #556FAB\",\n \")#	c #735353\",\n \"!#	c #7C4A39\",\n \"~#	c #7E4934\",\n \"{#	c #76504C\",\n \"]#	c #D3DCED\",\n \"^#	c #F9FAFD\",\n \"/#	c #F8FAFC\",\n \"(#	c #869DCC\",\n \"_#	c #E2E7F3\",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . + @ # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # @ + . . \",\n \". . $ % & * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * = - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ; $ . . \",\n \". . > , ' . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ) ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ~ . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ - / ( _ : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ < [ } | 1 2 - - - - 3 4 5 6 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7 8 9 9 9 0 a - - - b c d e f ; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . g h 9 9 9 9 i - - - j 9 9 9 d / - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ k l 9 9 m n - - - o p 9 9 q : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . r s t u . . ^ v w x y z A - - - B k C D E - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . F G H I J K . ^ - L M v - - - - - - ; N O - - - - / P 2 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Q R S T U V . . . . . . . W 9 9 9 9 X Y ^ - - - - ; Z `  ...> +.@.#.- - - $.%.&.*.=.- - - - - - - - % -.-.-.& - - - - - - - - - ;.-.>.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . ,.'.).).!.~.. . . . . . . . . . . . . . . . . . . {.].9 9 9 ^./.. . . . . . . J 9 9 9 9 H (.^ - - - _.:.<.. . . . . [.}.& - |.1.9 9 9 2.- - - - - - - - 3.. . . 4.- - - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . . . . . . . . . . . . . . . . . a.b.9 9 9 9 c.K . . . . . . . d.9 9 9 9 b.e.^ - - f.g.. h.i.j.k.l.m.n.o.p.- : q.9 9 9 r.- - - - - - - - s.. . . 5.t.- - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . . . . . . . . . . . . . . . . . u.9 9 9 v.w.x.y.. . . . . . . z.A.9 9 B.C.. ^ - D.E.. F.G.H.p.- = I.J.K.- - - L.q 9 C M.- - - - - - - N.F.O.5.. P.Q.- - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . . . . . . . . . . . . . . . . . R.9 9 9 S.T.T.U.. . . . . . . . V.W.S X.U.. ^ - Y.P.. Z.; - - - - - - - - - - `. +.+++- - - - - - - - @+. #+$+%+. &+- - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . . . . . . . . . . . . . . . . . A.9 9 *+=+. . . . . . . . . . . . . . . . . ^ - -+. O.;+- - - - - - - - - - - - ;.-.>.- - - - - - - ;.>+. ,+'+)+. F.!+- - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . ).~+~+{+,.]+U ^+/+(+_+. . . :+~+<+9 9 [+}+~+K . . . T.0.|+^+1+2+t 3+. . . . ^ - 4+5+. 6+* - - - - - - - - - - - 7+[.8+- - - - - - - 9+0+5+a+- b+. . $ - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . c+9 9 8.d+e+9 9 9 9 X =+. . x.9 9 9 9 9 9 9 f+. . ]+g+9.h+i+j+k+d l+m+T.. . ^ - n+m.. o+p+q+r+- - - - - - - - - 5.. 6.- - - - - - % s+. 6.D.- t+<.. l.% - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 v+w+9 9 9 9 9 9 x+. . x.9 9 9 9 9 9 9 f+. V y+d z+A+B+C+D+E+H F+G+. . ^ - - H+6.. O.I+J+K+L+- - - - - - - 5.. 6.- - - - - - K.<.. M+- - p.N+. O+P+- - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 9 Q+R+S+9 9 9 <+0.. T+U+V+9 9 <+W+U+X+. Y+d 9 Z+C+C+C+C+`+ @9 .@+@. ^ - - - @@)+O.. . ' E.#@t.- - - - - 5.. 6.- - - - - - $@. . %@- - - &@*@. =@- - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 -@;@. >@8.9 9 9 ,@. . . v+9 9 '@)@. . !@Q+9 9 ~@C+C+C+C+C+{@9 9 ]@. ^ - - - - % %@^@/@P.. . (@_@- - - - 5.. 6.- - - - - @.5.. E.t.- - - :@8+. m.<@- - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 [@. . . 2+9 9 9 }@. . . v+9 9 '@)@. . |@9 9 9 B+C+C+C+C+C+1@9 9 2@3@^ - - - - - - - 4@5@>+. . E.6@- - - 5.. 6.- - - - - 7@h.. 8@9@0@0@0@0@a@. n.b@- - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . f@9 9 9 g@C+C+C+C+h@i@9 9 ].Y ^ - - - - - - - - - j@j.. . $@- - - 5.. 6.- - - - p.:.. . . . . . . . . . . k@:@- - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . ]@9 9 9 l@m@C+C+C+n@o@9 9 p@Y ^ - - - - - - - - - - q@. . s+- - - 5.. 6.- - - - r@6.. >+a+s@s@s@s@s@t@u@. 6.! - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . v@9 9 9 9 w@x@y@z@<+9 9 9 x.U.^ - - - - - - - - - - _@' . A@- - - 5.. 6.- - - - { . . b+- - - - - - - B@. . C@- - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . D@E@9 9 9 9 9 9 9 9 9 9 9 f@. ^ - #.p.- - - - - - p.F@. . G@- - - 5.. 6.- - - p.)+. + H@- - - - - - - n+I@. J@-.- - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . ,.K@9 9 9 9 9 9 9 9 9 9 J +@. ^ - L@=@M@N@- - - D.$ O@. P@Q@- - - 5.. 6.- - - R@0+. S@= - - - - - - - & T@. . &@- - - 5.. U@V@V@V@V@V@V@V@V@6@p.- - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . . D@e+9 9 9 9 9 9 9 9 [+G+. . ^ #.W@. %+X@Y@6+7+8+O.. O@3.p.- - - 5.. 6.- - - =@. h...- - - - - - - - - J.O.. Z@p.- - 5.. O.g.g.g.g.g.g.g.g.`@:@- - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . . .  #.#9 9 9 9 9 9 S++#T.. . ^ #.s@l.o+. . . . . @#6+##p.- - - - 5.. 6.- - 4@m.. $#H.- - - - - - - - - %#i.. 0+I.- - 5.. . . . . . . . . . ] t.- - > . . \",\n \". . > ] . . . . . . . . . . . . . e.&#*#*#=#-#. . v@*#*#*#;#. . . >#*#*#*#!.. . . d@*#*#,#'#. . . . . ,.!.)#!#~#{#G+~.. . . . ^ - - & D.]#;+s@b@Q.-.#.- - - - - - ^#'+'+- - p./#'+t.- - - - - - - - - - - ^#'+'+#.- - ^#'+'+'+'+'+'+'+'+'+'+^#- - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > 5.. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . a+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . H+G./@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@E._.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - H+. . \",\n \". . (#P+_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#P+(#. . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \"};\n ");
		commitBuffer();
	}
}

function oficial_valorQuery(tablas:String, select:String, from:String, where:String):String
{
	var qry:FLSqlQuery = new FLSqlQuery();
	try { qry.setForwardOnly( true ); } catch (e) {}
	qry.setTablesList(tablas);
	qry.setSelect(select);
	qry.setFrom(from);
	qry.setWhere(where);
	qry.exec();
	if (qry.next())
		return qry.value(0);
	else
		return "";
}

/** \D
Crea una subcuenta contable, si no existe ya la combinaci�n C�digo de subcuenta - Ejercicio actual
@param	codSubcuenta: C�digo de la subcuenta a crear
@param	descripcion: Descripci�n de la subcuenta a crear
@param	idCuentaEsp: Indicador del tipo de cuenta especial (CLIENT = cliente, PROVEE = proveedor)
@param	codEjercicio: C�digo del ejercicio en el que se va a crear la subcuenta
@return	id de la subcuenta creada o ya existente.
\end */
function oficial_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number
{
	var util:FLUtil = new FLUtil();

	var datosEmpresa:Array;
	if (!codEjercicio)
		datosEmpresa["codejercicio"] = this.iface.ejercicioActual();
	else
		datosEmpresa["codejercicio"] = codEjercicio;
	datosEmpresa["coddivisa"] = this.iface.valorDefectoEmpresa("coddivisa");
	
	var idSubcuenta:String = util.sqlSelect("co_subcuentas", "idsubcuenta","codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + datosEmpresa.codejercicio + "'");
	if (idSubcuenta)
		return idSubcuenta;

	var codCuenta:String = codSubcuenta.left(codSubcuenta.find("0"));
	var datosCuenta:Array = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta",
		"idcuentaesp = '" + idCuentaEsp + "'" +
		" AND codcuenta LIKE '" + codCuenta + "%'" + 
		" AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");

	if (datosCuenta.result == -1) 
		return true;

	var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	with (curSubcuenta) {
		setModeAccess(curSubcuenta.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("descripcion", descripcion);
		setValueBuffer("idcuenta", datosCuenta.idcuenta);
		setValueBuffer("codcuenta", datosCuenta.codcuenta);
		setValueBuffer("coddivisa", datosEmpresa.coddivisa);
		setValueBuffer("codejercicio", datosEmpresa.codejercicio);
	}
	if (!curSubcuenta.commitBuffer())
		return false;

	return curSubcuenta.valueBuffer("idsubcuenta");
}

/** \D Borra una subcuenta contable en el caso de que no existan partidas asociadas
@param	idSubcuenta: Identificador de la subcuenta a borrar
@return	True si no hay error, False en otro caso
\end */
function oficial_borrarSubcuenta(idSubcuenta:Number):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!util.sqlSelect("co_partidas", "idpartida",
		"idsubcuenta = " + idSubcuenta)) {
		var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
		curSubcuenta.select("idsubcuenta = " + idSubcuenta);
		curSubcuenta.first();
		curSubcuenta.setModeAccess(curSubcuenta.Del);
		curSubcuenta.refreshBuffer();
		if (!curSubcuenta.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/* \D Devuelve el c�digo e id de la subcuenta de cliente seg�n su c�digo
@param codCliente: C�digo del cliente
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: C�digo de la subcuenta
\end */
function oficial_datosCtaCliente(codCliente:String, valoresDefecto:Array):Array
{
	/* \C En caso de que el c�digo de cliente sea vac�o, la subcuenta de clientes ser� la primera que depende de la cuenta especial de clientes (generalmente 430...0)
	\end */
	if ( !codCliente || codCliente == "" )
		return flfacturac.iface.pub_datosCtaEspecial("CLIENT", valoresDefecto.codejercicio);

	var util:FLUtil = new FLUtil();
	var ctaCliente:Array = [];
	ctaCliente["codsubcuenta"] = "";
	ctaCliente["idsubcuenta"] = "";
	if (!codCliente.toString().isEmpty()) {
		var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
		try { qrySubcuenta.setForwardOnly( true ); } catch (e) {}
		qrySubcuenta.setTablesList("co_subcuentascli");
		qrySubcuenta.setSelect("idsubcuenta, codsubcuenta");
		qrySubcuenta.setFrom("co_subcuentascli");
		qrySubcuenta.setWhere("codcliente = '" + codCliente + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!qrySubcuenta.exec()) {
			ctaCliente.error = 2;
			return ctaCliente;
		}
		if (!qrySubcuenta.first()) {
			MessageBox.critical(util.translate("scripts", "No hay ninguna subcuenta asociada al cliente ") + codCliente + util.translate("scripts", " para el ejercicio ") + valoresDefecto.codejercicio + ".\n" + util.translate("scripts", "Debe crear la subcuenta en el formulario de clientes."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			ctaCliente.error = 1;
			return ctaCliente;
		}
		ctaCliente.idsubcuenta = qrySubcuenta.value(0);
		ctaCliente.codsubcuenta = qrySubcuenta.value(1);
	}
	ctaCliente.error = 0;
	return ctaCliente;
}

/* \D Devuelve el c�digo e id de la subcuenta de proveedor seg�n su c�digo
@param codProveedor: C�digo del proveedor
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: C�digo de la subcuenta
\end */
function oficial_datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array
{
	/* \C En caso de que el c�digo de proveedor sea vac�o, la subcuenta de proveedores ser� la primera que depende de la cuenta especial de proveedores (generalmente 400...0)
	\end */
	if ( !codProveedor || codProveedor == "" )
		return flfacturac.iface.pub_datosCtaEspecial("PROVEE", valoresDefecto.codejercicio);

	var util:FLUtil = new FLUtil();
	var ctaProveedor:Array = [];
	ctaProveedor["codsubcuenta"] = "";
	ctaProveedor["idsubcuenta"] = "";
	if (!codProveedor.toString().isEmpty()) {
		var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
		qrySubcuenta.setTablesList("co_subcuentasprov");
		qrySubcuenta.setSelect("idsubcuenta, codsubcuenta");
		qrySubcuenta.setFrom("co_subcuentasprov");
		qrySubcuenta.setWhere("codproveedor = '" + codProveedor + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!qrySubcuenta.exec()) {
			ctaProveedor.error = 1;
			return ctaProveedor;
		}
		if (!qrySubcuenta.first()) {
			MessageBox.critical(util.translate("scripts", "No hay ninguna subcuenta asociada al proveedor ") + codProveedor + util.translate("scripts", " para el ejercicio ") + valoresDefecto.codejercicio + ".\n" + util.translate("scripts", "Debe crear la subcuenta en el formulario de proveedores."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			ctaProveedor.error = 1;
			return ctaProveedor;
		}
		ctaProveedor.idsubcuenta = qrySubcuenta.value(0);
		ctaProveedor.codsubcuenta = qrySubcuenta.value(1);
	}
	ctaProveedor.error = 0;
	return ctaProveedor;
}

/** \D Calcula la fecha inicial y la fecha final del intervalo
@param	codIntervalo: c�digo del intervalo.
@return	 intervalo: array con las fechas inicial y final del intervalo
\end */
function oficial_calcularIntervalo(codIntervalo:String):Array 
{
	var util:FLUtil = new FLUtil();
	var intervalo:Array = [];

	var textoFun:String = util.sqlSelect("intervalos", "funcionintervalo", "codigo = '" + codIntervalo + "'");

	var funcionVal = new Function(textoFun);
	var resultado = funcionVal();
	if (resultado)
		return resultado;

	intervalo["desde"] = false;
	intervalo["hasta"] = false;

	var fechaDesde:Date = new Date();
	var fechaHasta:Date = new Date();
	var mes:Number;
	var anio:Number;
	
	switch(codIntervalo) {
		case "000001": {
			intervalo.desde = fechaDesde;
			intervalo.hasta = fechaHasta;
			break;
		}

		case "000002": {
			intervalo.desde = util.addDays(fechaDesde,-1);
			intervalo.hasta = util.addDays(fechaHasta,-1);
			break;
		}
		
		case "000003": {
			var dias:Number = fechaDesde.getDay() -1;
			dias = dias * -1;
			intervalo.desde = util.addDays(fechaDesde, dias);
			intervalo.hasta = util.addDays(intervalo.desde,6);
			break;
		}
		
		case "000004": {
			var dias:Number = fechaHasta.getDay() -1;
			dias = dias * -1;
			intervalo.hasta = util.addDays(fechaHasta, dias -1);
			intervalo.desde = util.addDays(intervalo.hasta,-6);
			break;
		}
			
		case "000005": {
			mes = fechaDesde.getMonth();
			fechaDesde.setDate(1);
			intervalo.desde = fechaDesde;
			fechaHasta.setDate(1);
			fechaHasta = util.addMonths(fechaHasta, 1);;
			fechaHasta = util.addDays(fechaHasta,-1);
			intervalo.hasta = fechaHasta;
			break;
		}
		
		case "000006": {
			fechaDesde.setDate(1);
			fechaDesde = util.addMonths(fechaDesde, -1);
			intervalo.desde = fechaDesde;
			fechaHasta.setDate(1);
			fechaHasta = util.addDays(fechaHasta,-1);
			intervalo.hasta = fechaHasta;
			break;
		}
		
		case "000007": {
			fechaDesde.setDate(1);
			fechaDesde.setMonth(1);
			intervalo.desde = fechaDesde;
			fechaHasta.setMonth(12)
			fechaHasta.setDate(31);
			intervalo.hasta = fechaHasta;
			break;
		}
		
		case "000008": {
			anio = fechaDesde.getYear() - 1;
			fechaDesde.setDate(1);
			fechaDesde.setMonth(1);
			fechaDesde.setYear(anio);
			intervalo.desde = fechaDesde;
			fechaHasta.setDate(31);
			fechaHasta.setMonth(12)
			fechaHasta.setYear(anio);
			intervalo.hasta = fechaHasta;
			break;
		}
		
		case "000009": {
			intervalo.desde = "1970-01-01";
			intervalo.hasta = "3000-01-01";
			break;
		}
		
		case "000010": {
			intervalo.desde = "1970-01-01";
			intervalo.hasta = fechaHasta;
			break;
		}
	}

	return intervalo;
}

/** \D
Crea una subcuenta contable, si no existe ya la combinaci�n C�digo de subcuenta - Ejercicio actual
@param	codSubcuenta: C�digo de la subcuenta a crear
@param	idSubcuenta: Identificador de la subcuenta a crear
@param	codCliente: Cliente para el que se crea la subcuenta
@param	codEjercicio: C�digo del ejercicio en el que se va a crear la subcuenta
@return	Verdadero si no hay error, Falso en otro caso
\end */
function oficial_crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean
{
	var curSubcuentaCli:FLSqlCursor = new FLSqlCursor("co_subcuentascli");
	with (curSubcuentaCli) {
		setModeAccess(curSubcuentaCli.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("idSubcuenta", idSubcuenta);
		setValueBuffer("codcliente", codCliente);
		setValueBuffer("codejercicio", codEjercicio);
	}
	if (!curSubcuentaCli.commitBuffer())
		return false;

	return true;
}

/** \D
Crea una subcuenta contable, si no existe ya la combinaci�n C�digo de subcuenta - Ejercicio actual
@param	codSubcuenta: C�digo de la subcuenta a crear
@param	idSubcuenta: Identificador de la subcuenta a crear
@param	codProveedor: Proveedor para el que se crea la subcuenta
@param	codEjercicio: C�digo del ejercicio en el que se va a crear la subcuenta
@return	Verdadero si no hay error, Falso en otro caso
\end */
function oficial_crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean
{
	var curSubcuentaProv:FLSqlCursor = new FLSqlCursor("co_subcuentasprov");
	with (curSubcuentaProv) {
		setModeAccess(curSubcuentaProv.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("idSubcuenta", idSubcuenta);
		setValueBuffer("codproveedor", codProveedor);
		setValueBuffer("codejercicio", codEjercicio);
	}
	if (!curSubcuentaProv.commitBuffer())
		return false;

	return true;
}

/** \D Crea las subcuentas  asociadas a un cliente que todav�a no existen en los ejercicios con plan general contable 
@param codCliente: C�digo de cliente
@param codSubcuenta: C�digo de subcuenta
@param nombre: Nombre del cliente
@return True si la generaci�n de subcuentas finaliza correctamente, falso en caso contrario
*/
function oficial_rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean
{
	if (!sys.isLoadedModule("flcontppal"))
		return true;
	if (!codSubcuenta)
		return true;
	
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("ejercicios,co_subcuentascli");
	qry.setSelect("e.codejercicio");
	qry.setFrom("ejercicios e LEFT OUTER JOIN co_subcuentascli s ON e.codejercicio = s.codejercicio AND s.codcliente = '" + codCliente + "'");
	qry.setWhere("s.id IS NULL");
	if (!qry.exec())
		return false;
	
	var idSubcuenta:Number;
	var codEjercicio:String;
	while (qry.next()) {
		codEjercicio = qry.value(0);
		if (!util.sqlSelect("co_epigrafes", "codepigrafe", "codejercicio = '" + codEjercicio + "'"))
			continue;
		idSubcuenta = this.iface.crearSubcuenta(codSubcuenta, nombre, "CLIENT", codEjercicio);
		if (!idSubcuenta)
			return false;
		
		if (idSubcuenta == true)
			continue;
		
		if (!this.iface.crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio))
			return false;
	}
	
	return true;
}

/** \D Crea las subcuentas  asociadas a un proveedor que todav�a no existen en los ejercicios con plan general contable 
@param codProveedor: C�digo de proveedor
@param codSubcuenta: C�digo de subcuenta
@param nombre: Nombre del proveedor
@return True si la generaci�n de subcuentas finaliza correctamente, falso en caso contrario
*/
function oficial_rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean
{
	if (!sys.isLoadedModule("flcontppal"))
		return;
	
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("ejercicios,co_subcuentasprov");
	qry.setSelect("e.codejercicio");
	qry.setFrom("ejercicios e LEFT OUTER JOIN co_subcuentasprov s ON e.codejercicio = s.codejercicio AND s.codproveedor = '" + codProveedor + "'");
	qry.setWhere("s.id IS NULL");
	if (!qry.exec())
		return false;
	
	var idSubcuenta:Number;
	var codEjercicio:String;
	while (qry.next()) {
		codEjercicio = qry.value(0);
		if (!util.sqlSelect("co_epigrafes", "codepigrafe", "codejercicio = '" + codEjercicio + "'"))
			continue;
		idSubcuenta = this.iface.crearSubcuenta(codSubcuenta, nombre, "PROVEE", codEjercicio);
		if (!idSubcuenta)
			return false;
		
		if (idSubcuenta == true) 
			continue;
		
		if (!this.iface.crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio))
			return false;
	}
	
	return true;
}

/** \D Indica si el m�dulo de aut�mata est� instalado y activado
@return	true si est� activado, false en caso contrario
\end */
function oficial_automataActivado():Boolean
{
	if (!sys.isLoadedModule("flautomata"))
		return false;
	
	if (formau_automata.iface.pub_activado())
		return true;
	
	return false;
}


/** \D Indica si el cliente est� activo (no est� de baja) para la fecha especificada
@param	codCliente: C�digo de cliente
@param	fecha: Fecha a considerar
@return	true si est� activo, false en caso contrario o si hay error
\end */
function oficial_clienteActivo(codCliente:String, fecha:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!codCliente || codCliente == "")
		return true;
	
	var qryBaja:FLSqlQuery = new FLSqlQuery();
	qryBaja.setTablesList("clientes");
	qryBaja.setSelect("debaja, fechabaja");
	qryBaja.setFrom("clientes");
	qryBaja.setWhere("codcliente = '" + codCliente + "'");
	qryBaja.setForwardOnly(true);
	if (!qryBaja.exec())
		return false;
	
	if (!qryBaja.first())
		return false;
	
	if (!qryBaja.value("debaja"))
		return true;
		
	if (util.daysTo(fecha, qryBaja.value("fechabaja")) <= 0) {
		if (!this.iface.automataActivado()) {
			var fechaDdMmAaaa:String = util.dateAMDtoDMA(fecha);
			MessageBox.warning(util.translate("scripts", "El cliente est� de baja para la fecha especificada (%1)").arg(fechaDdMmAaaa), MessageBox.Ok, MessageBox.NoButton);
		}
		return false;
	}
	return true;
}

/** \D Autocompleta la provincia cuando el usuario pulsa . u ofrece la lista de provincias que comienzan por el valor actual del campo para que el usuario elija
@param	formulario	Formulario que contiene el campo de provincia
@param	campoId Campo del id de provincia en base de datos
@param	campoProvincia Campo del valor de la provincia en base de datos
@param	campoPais Campo del c�digo de pa�s en base de datos
\end */
function oficial_obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String)
{
	var util:FLUtil = new FLUtil;
	if (!campoId)
		campoId = "idprovincia";

	if (!campoProvincia)
		campoProvincia = "provincia";

	if (!campoPais)
		campoPais = "codpais";

	formulario.cursor().setNull(campoId);
	var provincia:String = formulario.cursor().valueBuffer(campoProvincia);
	if (!provincia || provincia == "")
		return;
		
	if (provincia.endsWith(".")) {
		//provincia = util.utf8(provincia);

		provincia = provincia.left(provincia.length - 1);
		provincia = provincia.toUpperCase();
		
		var where:String = "UPPER(provincia) LIKE '" + provincia + "%'";
		var codPais:String = formulario.cursor().valueBuffer(campoPais);
		if (codPais && codPais != "")
			where += " AND codpais = '" + codPais + "'";
		
		var qryProvincia:FLSqlQuery = new FLSqlQuery;
		with (qryProvincia) {
			setTablesList("provincias");
			setSelect("idprovincia");
			setFrom("provincias");
			setForwardOnly(true);
		}
		qryProvincia.setWhere(where);

		if (!qryProvincia.exec())
			return false;

		switch (qryProvincia.size()) {
			case 0: {
				return;
			}
			case 1: {
				if (!qryProvincia.first())
					return false;
				formulario.cursor().setValueBuffer(campoId, qryProvincia.value("idprovincia"));
				break;
			}
			default: {
				var listaProvincias:String = "";
				while (qryProvincia.next()) {
					if (listaProvincias != "")
						listaProvincias += ", ";
					listaProvincias += qryProvincia.value("idprovincia");
				}
				var f:Object = new FLFormSearchDB("provincias");
				var curProvincias:FLSqlCursor = f.cursor();
				curProvincias.setMainFilter("idprovincia IN (" + listaProvincias + ")");
	
				f.setMainWidget();
				var idProvincia:String = f.exec("idprovincia");

				if (idProvincia)
					formulario.cursor().setValueBuffer(campoId, idProvincia);
				break;
			}
		}
	}
}


function oficial_actualizarContactos20070525():Boolean
{
	var util:FLUtil;

	var qryClientes:FLSqlQuery = new FLSqlQuery();
	qryClientes.setTablesList("clientes");
	qryClientes.setFrom("clientes");
	qryClientes.setSelect("codcliente,codcontacto,contacto");
	qryClientes.setWhere("");
	if (!qryClientes.exec()) 
		return false;

	util.createProgressDialog(util.translate("scripts", "Reorganizando Contactos"), qryClientes.size());
	util.setProgress(0);

	var cont:Number = 1;
	
	while (qryClientes.next()) {
		util.setProgress(cont);
		cont += 1;
		var codCliente:String = qryClientes.value("codcliente");
		
		if(!codCliente) {
			util.destroyProgressDialog();
			return false;
		}
			
		var qryAgenda:FLSqlQuery = new FLSqlQuery();
		qryAgenda.setTablesList("contactosclientes");
		qryAgenda.setFrom("contactosclientes");
		qryAgenda.setSelect("contacto,cargo,telefono,fax,email,id,codcliente");
		qryAgenda.setWhere("codcliente = '" + codCliente + "'");
		if (!qryAgenda.exec()) {
			util.destroyProgressDialog();
			return false;
		}

		if (sys.isLoadedModule("flcrm_ppal")) {
			var qryClientesContactos:FLSqlQuery = new FLSqlQuery();
			qryClientesContactos.setTablesList("crm_clientescontactos");
			qryClientesContactos.setFrom("crm_clientescontactos");
			qryClientesContactos.setSelect("codcontacto");
			qryClientesContactos.setWhere("codcliente = '" + codCliente + "' AND codcontacto NOT IN(SELECT codcontacto FROM contactosclientes WHERE codcliente = '" + codCliente + "')");
			if (!qryClientesContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}
				
	
			while (qryClientesContactos.next())
				this.iface.actualizarContactosDeAgenda20070525(codCliente,qryClientesContactos.value("codcontacto"));
		}

		while (qryAgenda.next()) {
			var nombreCon:String = qryAgenda.value("contacto");
			var cargoCon:String = qryAgenda.value("cargo");
			var telefonoCon:String = qryAgenda.value("telefono");
			var faxCon:String = qryAgenda.value("fax");
			var emailCon:String = qryAgenda.value("email");
			var idAgenda:Number = qryAgenda.value("id");
			if (!idAgenda || idAgenda == 0) {
				util.destroyProgressDialog();
				return false;
			}
			
			var qryContactos:FLSqlQuery = new FLSqlQuery();
			qryContactos.setTablesList("crm_contactos,contactosclientes");
			qryContactos.setFrom("crm_contactos INNER JOIN contactosclientes ON crm_contactos.codcontacto = contactosclientes.codcontacto");
			qryContactos.setSelect("crm_contactos.codcontacto");
			qryContactos.setWhere("crm_contactos.nombre = '" + nombreCon + "' AND (contactosclientes.codcliente = '" + codCliente + "' AND (crm_contactos.email = '" + emailCon + "' AND crm_contactos.telefono1 = '" + telefonoCon + "'))");
			if (!qryContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}
			
			var codContacto:String = "";

			if (qryContactos.first())
				codContacto = qryContactos.value("crm_contactos.codcontacto");

			if(!this.iface.actualizarContactosDeAgenda20070525(codCliente,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)) {
				util.destroyProgressDialog();
				return false;
			}
		}

		if ((qryClientes.value("contacto") && qryClientes.value("contacto") != "") && (!qryClientes.value("codcontacto") || qryClientes.value("codcontacto") == "")) {
				codContacto = util.sqlSelect("crm_contactos", "codcontacto", "nombre = '" + qryClientes.value("contacto") + "'");
				if (codContacto)
					this.iface.actualizarContactosDeAgenda20070525(codCliente,codContacto,qryClientes.value("contacto"));
				else
					codContacto = this.iface.actualizarContactosDeAgenda20070525(codCliente,"",qryClientes.value("contacto"));

				if(!codContacto) {
					util.destroyProgressDialog();
					return false;
				}
			
				var curCliente:FLSqlCursor = new FLSqlCursor("clientes");
				curCliente.select("codcliente = '" + codCliente + "'");
				curCliente.setModeAccess(curCliente.Edit);
				if (!curCliente.first()) {
					util.destroyProgressDialog();
					return false;
				}
				curCliente.refreshBuffer();
				curCliente.setValueBuffer("codcontacto", codContacto);
			
				if (!curCliente.commitBuffer()) {
					util.destroyProgressDialog();
					return false;
				}
		}
	}
	util.setProgress(qryClientes.size());
	util.destroyProgressDialog();
	return true;
}

function oficial_actualizarContactosProv20070702():Boolean
{
	var util:FLUtil;

	var qryProveedores:FLSqlQuery = new FLSqlQuery();
	qryProveedores.setTablesList("proveedores");
	qryProveedores.setFrom("proveedores");
	qryProveedores.setSelect("codproveedor,codcontacto,contacto");
	qryProveedores.setWhere("");
	if (!qryProveedores.exec()) 
		return false;

	util.createProgressDialog(util.translate("scripts", "Reorganizando Contactos"), qryProveedores.size());
	util.setProgress(0);

	var cont:Number = 1;
	
	while (qryProveedores.next()) {
		util.setProgress(cont);
		cont += 1;
		var codProveedor:String = qryProveedores.value("codproveedor");
		
		if(!codProveedor) {
			util.destroyProgressDialog();
			return false;
		}
			
		var qryAgenda:FLSqlQuery = new FLSqlQuery();
		qryAgenda.setTablesList("contactosproveedores");
		qryAgenda.setFrom("contactosproveedores");
		qryAgenda.setSelect("contacto,cargo,telefono,fax,email,id,codproveedor");
		qryAgenda.setWhere("codproveedor = '" + codProveedor + "'");
		if (!qryAgenda.exec()) {
			util.destroyProgressDialog();
			return false;
		}

		while (qryAgenda.next()) {
			var nombreCon:String = qryAgenda.value("contacto");
			var cargoCon:String = qryAgenda.value("cargo");
			var telefonoCon:String = qryAgenda.value("telefono");
			var faxCon:String = qryAgenda.value("fax");
			var emailCon:String = qryAgenda.value("email");
			var idAgenda:Number = qryAgenda.value("id");
			if (!idAgenda || idAgenda == 0) {
				util.destroyProgressDialog();
				return false;
			}
			
			var qryContactos:FLSqlQuery = new FLSqlQuery();
			qryContactos.setTablesList("crm_contactos,contactosproveedores");
			qryContactos.setFrom("crm_contactos INNER JOIN contactosproveedores ON crm_contactos.codcontacto = contactosproveedores.codcontacto");
			qryContactos.setSelect("crm_contactos.codcontacto");
			qryContactos.setWhere("crm_contactos.nombre = '" + nombreCon + "' AND (contactosproveedores.codproveedor = '" + codProveedor + "' AND (crm_contactos.email = '" + emailCon + "' AND crm_contactos.telefono1 = '" + telefonoCon + "'))");
			if (!qryContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}
			
			var codContacto:String = "";

			if (qryContactos.first())
				codContacto = qryContactos.value("crm_contactos.codcontacto");

			if(!this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)) {
				util.destroyProgressDialog();
				return false;
			}
		}

		if ((qryProveedores.value("contacto") && qryProveedores.value("contacto") != "") && (!qryProveedores.value("codcontacto") || qryProveedores.value("codcontacto") == "")) {
				codContacto = util.sqlSelect("crm_contactos", "codcontacto", "nombre = '" + qryProveedores.value("contacto") + "'");
				if (codContacto)
					this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,qryProveedores.value("contacto"));
				else
					codContacto = this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,"",qryProveedores.value("contacto"));

				if(!codContacto) {
					util.destroyProgressDialog();
					return false;
				}
			
				var curProveedor:FLSqlCursor = new FLSqlCursor("proveedores");
				curProveedor.select("codproveedor = '" + codProveedor + "'");
				curProveedor.setModeAccess(curProveedor.Edit);
				if (!curProveedor.first()) {
					util.destroyProgressDialog();
					return false;
				}
				curProveedor.refreshBuffer();
				curProveedor.setValueBuffer("codcontacto", codContacto);
			
				if (!curProveedor.commitBuffer()) {
					util.destroyProgressDialog();
					return false;
				}
		}
	}
	util.setProgress(qryProveedores.size());
	util.destroyProgressDialog();
	return true;
}

function oficial_actualizarContactosDeAgenda20070525(codCliente:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {

	var util:FLUtil;
	var curContactos:FLSqlCursor = new FLSqlCursor("crm_contactos");
	var curAgenda:FLSqlCursor = new FLSqlCursor("contactosclientes");

	if (codContacto && codContacto != "") {
		curContactos.select("codcontacto = '" + codContacto + "'");
		if (!curContactos.first())
			return false;
		curContactos.setModeAccess(curContactos.Edit);
		curContactos.refreshBuffer();
		if (!curContactos.valueBuffer("cargo") || curContactos.valueBuffer("cargo") == "") {
			curContactos.setValueBuffer("cargo", cargoCon);
		}
		
		if (!curContactos.valueBuffer("telefono1") || curContactos.valueBuffer("telefono1") == "") {
			curContactos.setValueBuffer("telefono1", telefonoCon);
		}
		else {
			if (!curContactos.valueBuffer("telefono2") || 		curContactos.valueBuffer("telefono2") == "") {
				curContactos.setValueBuffer("telefono2", telefonoCon);
			}
		}
		if (!curContactos.valueBuffer("fax") || curContactos.valueBuffer("fax") == "") {
			curContactos.setValueBuffer("fax", faxCon);
		}
		if (!curContactos.valueBuffer("email") || curContactos.valueBuffer("email") == "") {
			curContactos.setValueBuffer("email", emailCon);
		}
	}
	else {
		with (curContactos) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codcontacto", util.nextCounter("codcontacto", this));
			setValueBuffer("nombre",nombreCon);
			setValueBuffer("email",emailCon);
			setValueBuffer("telefono1",telefonoCon);
			setValueBuffer("cargo",cargoCon);
			setValueBuffer("fax",faxCon);
		}
	
		if (!curContactos.commitBuffer())
			return false;

		codContacto = curContactos.valueBuffer("codcontacto");
		if(!codContacto)
			return false;
	}
	if (!idAgenda || idAgenda == 0) {
		if (!util.sqlSelect("contactosclientes","id","codcontacto = '" + codContacto + "' AND codcliente = '" + codCliente + "'")) {
			curAgenda.setModeAccess(curAgenda.Insert);
			curAgenda.refreshBuffer();
			curAgenda.setValueBuffer("codcliente",codCliente);
			curAgenda.setValueBuffer("codcontacto",codContacto);
			if (!curAgenda.commitBuffer())
				return false;
		}
	}
	else {
		curAgenda.select("id = " + idAgenda);
		if (!curAgenda.first())
			return false;
		curAgenda.setModeAccess(curAgenda.Edit);
		curAgenda.refreshBuffer();
		curAgenda.setValueBuffer("codcontacto",codContacto);
		if (!curAgenda.commitBuffer())
			return false;
	}

	

	return codContacto;
}

function oficial_lanzarEvento(cursor:FLSqlCursor, evento:String):Boolean
{
	var datosEvento:Array = [];
	datosEvento["tipoobjeto"] = cursor.table();
	datosEvento["idobjeto"] = cursor.valueBuffer(cursor.primaryKey());
	datosEvento["evento"] = evento;
	if (!flcolaproc.iface.pub_procesarEvento(datosEvento))
		return false;

	return true;
}

function oficial_actualizarContactosDeAgendaProv20070702(codProveedor:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String 
{
	var util:FLUtil;
	var curContactos:FLSqlCursor = new FLSqlCursor("crm_contactos");
	var curAgenda:FLSqlCursor = new FLSqlCursor("contactosproveedores");

	if (codContacto && codContacto != "") {
		curContactos.select("codcontacto = '" + codContacto + "'");
		if (!curContactos.first())
			return false;
		curContactos.setModeAccess(curContactos.Edit);
		curContactos.refreshBuffer();
		if (!curContactos.valueBuffer("cargo") || curContactos.valueBuffer("cargo") == "") {
			curContactos.setValueBuffer("cargo", cargoCon);
		}
		
		if (!curContactos.valueBuffer("telefono1") || curContactos.valueBuffer("telefono1") == "") {
			curContactos.setValueBuffer("telefono1", telefonoCon);
		}
		else {
			if (!curContactos.valueBuffer("telefono2") || 		curContactos.valueBuffer("telefono2") == "") {
				curContactos.setValueBuffer("telefono2", telefonoCon);
			}
		}
		if (!curContactos.valueBuffer("fax") || curContactos.valueBuffer("fax") == "") {
			curContactos.setValueBuffer("fax", faxCon);
		}
		if (!curContactos.valueBuffer("email") || curContactos.valueBuffer("email") == "") {
			curContactos.setValueBuffer("email", emailCon);
		}
	}
	else {
		with (curContactos) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codcontacto", util.nextCounter("codcontacto", this));
			setValueBuffer("nombre",nombreCon);
			setValueBuffer("email",emailCon);
			setValueBuffer("telefono1",telefonoCon);
			setValueBuffer("cargo",cargoCon);
			setValueBuffer("fax",faxCon);
		}
	
		if (!curContactos.commitBuffer())
			return false;

		codContacto = curContactos.valueBuffer("codcontacto");
		if(!codContacto)
			return false;
	}
	if (!idAgenda || idAgenda == 0) {
		if (!util.sqlSelect("contactosproveedores","id","codcontacto = '" + codContacto + "' AND codproveedor = '" + codProveedor + "'")) {
			curAgenda.setModeAccess(curAgenda.Insert);
			curAgenda.refreshBuffer();
			curAgenda.setValueBuffer("codproveedor",codProveedor);
			curAgenda.setValueBuffer("codcontacto",codContacto);
			if (!curAgenda.commitBuffer())
				return false;
		}
	}
	else {
		curAgenda.select("id = " + idAgenda);
		if (!curAgenda.first())
			return false;
		curAgenda.setModeAccess(curAgenda.Edit);
		curAgenda.refreshBuffer();
		curAgenda.setValueBuffer("codcontacto",codContacto);
		if (!curAgenda.commitBuffer())
			return false;
	}

	

	return codContacto;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
