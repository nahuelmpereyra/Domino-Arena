package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class PedidosCerradosWindow extends PedidoWindow {

	new(WindowOwner parent) {
		super(parent)
	}

	override protected createFormPanel(Panel mainPanel) {
		super.createFormPanel(mainPanel)
		title = "Dominos Pizza"
		label1.text = "Pedidos cerrados"
		label1.alignLeft

		tabla1.items <=> "resultadosPedidosCerrados"
		tabla1.value <=> "pedidoSeleccionado"

		columna3.title = "Fecha"
		columna3.fixedSize = 10
		 columna4.title = "Tiempo de espera"
		columna4.fixedSize = 100
		columna1.bindContentsToProperty("numero")
		columna2.bindContentsToProperty("estado")
		columna3.bindContentsToProperty("fecha")
		columna4.bindContentsToProperty("tiempoEspera")
		boton1.caption = 'Ver'
		boton2.caption = "Volver"
		boton2.onClick[close]

	}

}
