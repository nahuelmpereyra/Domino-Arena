package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.bindings.NotNullObservable
import java.time.LocalDateTime

class PedidosCerradosWindow extends PedidoWindow {

	new(WindowOwner parent) {
		super(parent)
	}

	override protected createFormPanel(Panel mainPanel) {
		super.createFormPanel(mainPanel)
		title = "Dominos Pizza"
		label1.text = "Pedidos cerrados"
		label1.alignLeft

		tabla1.items <=> "appModelPedidos.pedidosCerrados"
		tabla1.value <=> "appModelPedidos.pedidoSeleccionado"

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
		val elementSelectedPedido = new NotNullObservable("appModelPedidos.pedidoSeleccionado")
		boton2.caption = 'Ver'
		boton2.bindEnabled(elementSelectedPedido)
		boton2.onClick[|this.verPedido]

	}
	
	// ********************************************************
	// ** Acciones
	// ********************************************************
	
	def verPedido() {
		this.openDialog(new VerPedidoWindow(this, modelObject))
	}

}
