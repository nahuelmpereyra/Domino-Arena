package ar.edu.unq.domino.arena.menu


import org.uqbar.arena.windows.WindowOwner
import ar.edu.unq.domino.sistema.Sistema
import org.uqbar.arena.widgets.Panel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class PedidosCerradosWindow extends PedidoWindow {

	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		super.createFormPanel(mainPanel)
		title = "Dominos Pizza"
		label1.text = "Pedidos cerrados"
		label1.alignLeft
		tabla1.items <=> "pedidos"
		columna1.title = "Pedido"
		columna2.title = "Estado"
		columna3.title = "Fecha"
		columna4.title = "Tiempo de espera"

		boton1.caption = 'Ver'
		boton2.caption = "Volver"
		
	}
	
}