package ar.edu.unq.domino.arena.menu


import org.uqbar.arena.widgets.Panel
import ar.edu.unq.domino.sistema.Sistema
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.tables.Table
import ar.edu.unq.domino.Pizzas.Pedido
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.Dialog

class PedidosCerradosWindow extends TransactionalDialog<Sistema>{
	
	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		
		// Panel principal
		val panel = new Panel(mainPanel) => [
			layout = new VerticalLayout
		]
		title = "Dominos Pizza"
		new Label(panel).text = "Pedidos cerrados"

		val table = new Table<Pedido>(panel, typeof(Pedido)) => [
			items <=> "pedidosCerrados"
		]

		this.crearTablaPedidosCerrados(table)


		// Panel botones inferiores
		val buttonPanel3 = new Panel(panel) => [
			layout = new HorizontalLayout
		]

		new Button(buttonPanel3) => [
			caption = 'Ver'
			width = 75
		]


		new Button(buttonPanel3) => [
			caption = 'Volver'
			width = 75
			//onClick [this.sistemaWindow]
		]
	}
	
	
	
	
	def crearTablaPedidosCerrados(Table<Pedido> table) {
		new Column(table) => [
			title = "Pedido"
			fixedSize = 100
			bindContentsToProperty("nombre")
		]

		new Column(table) => [
			title = "Estado"
			fixedSize = 100
			bindContentsToProperty("estado")
		]

		new Column(table) => [
			title = "Fecha"
			fixedSize = 100
			bindContentsToProperty("fecha")
		]

		new Column(table) => [
			title = "Tiempo de espera"
			fixedSize = 100
			bindContentsToProperty("tiempoEspera")
		]

	}
	
}