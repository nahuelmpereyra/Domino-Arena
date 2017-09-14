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
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Label

class SistemaWindow extends SimpleWindow<Sistema> {

	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)

	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		
		// Panel principal
		val panel = new Panel(mainPanel) => [
			layout = new VerticalLayout
		]
		title = "Dominos Pizza"
		new Label(panel).text = "Pedidos abiertos"

		val table = new Table<Pedido>(panel, typeof(Pedido)) => [
			items <=> "pedidos"
		]

		this.crearTablaPedidosAbiertos(table)

		// Panel botones verticales
		val buttonMainPanel = new Panel(mainPanel) => [
			layout = new VerticalLayout
		]

		val buttonPanel = new Panel(buttonMainPanel) => [
			layout = new HorizontalLayout
		]

		new Button(buttonPanel) => [
			caption = '<<<'
		]

		new Button(buttonPanel) => [
			caption = '>>>'
		]

		// Panel botones verticales 2
		// Cancelar y Editar
		val buttonPanel2 = new Panel(buttonMainPanel) => [
			layout = new VerticalLayout
		]

		new Button(buttonPanel2) => [
			caption = 'Cancelar'
			width = 75
		]

		new Button(buttonPanel2) => [
			caption = 'Editar'
			width = 75
		]

		// Panel botones inferiores
		val buttonPanel3 = new Panel(panel) => [
			layout = new HorizontalLayout
		]

		new Button(buttonPanel3) => [
			caption = 'Menú'
			width = 75
			onClick [this.menuWindow]
		]
		

		new Button(buttonPanel3) => [
			caption = 'Pedidos cerrados'
			width = 100
			onClick [this.pedidosCerradosWindow]
		]

		new Button(buttonPanel3) => [
			caption = 'Salir'
			width = 75
			onClick [close]
		]
	}
	
	def menuWindow() {
		this.openDialog(new MenuWindow(this, modelObject))
	}
	
		def pedidosCerradosWindow() {
		this.openDialog(new PedidosCerradosWindow(this, modelObject))
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
	


	def crearTablaPedidosAbiertos(Table<Pedido> table) {
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
			title = "Monto"
			fixedSize = 100
			bindContentsToProperty("monto")
		]

		new Column(table) => [
			title = "Hora"
			fixedSize = 100
			bindContentsToProperty("fecha")
		]

	}

}
