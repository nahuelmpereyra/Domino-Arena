package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel
import ar.edu.unq.domino.sistema.Sistema
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.tables.Table
import ar.edu.unq.domino.Pizzas.Pedido
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CrearDominoPizzaWindow extends SimpleWindow<Sistema>{
	
	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)
		title = "Dominos Pizza"
		taskDescription = "Pedidos abiertos"
	}
	
	override protected addActions(Panel actionsPanel) {
		
	}
	
	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		
		val panel = new Panel(mainPanel) => [
			layout = new VerticalLayout
		]
		
		val table = new Table<Pedido>(panel, typeof(Pedido)) => [
			items <=> "pedidos"
		]
	}
	
}