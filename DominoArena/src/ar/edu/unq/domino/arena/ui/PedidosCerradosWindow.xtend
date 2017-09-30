package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.bindings.NotNullObservable
import ar.edu.unq.domino.appModel.EditarPedidoAppModel

class PedidosCerradosWindow extends PedidoWindow {

	new(WindowOwner parent) {
		super(parent)
	}

	override protected createFormPanel(Panel mainPanel) {
		super.createFormPanel(mainPanel)
		title = "Dominos Pizza"
		label1.text = "Pedidos cerrados"
		label1.alignLeft

		tabla1.items <=> "pedidosCerrados"
		tabla1.value <=> "pedidoCerradoSeleccionado"

		columna3.title = "Fecha"
		columna3.fixedSize = 150
		columna4.title = "Tiempo de espera"
		columna4.fixedSize = 150
		columna1.bindContentsToProperty("numero")
		columna2.bindContentsToProperty("estado")
		columna3.bindContentsToProperty("fecha")
		columna4.bindContentsToProperty("tiempoEspera")

		boton1.caption = "Volver"
		boton1.onClick[close]
		val elementSelectedPedido = new NotNullObservable("pedidoCerradoSeleccionado")
		boton2.caption = 'Ver'
		boton2.bindEnabled(elementSelectedPedido)
		boton2.onClick[|this.verPedido]

	}
	
	// ********************************************************
	// ** Acciones
	// ********************************************************
	
	def verPedido() {
		this.openDialog(new VerPedidoWindow(this, new EditarPedidoAppModel(modelObject.pedidoCerradoSeleccionado)))
	}

}
