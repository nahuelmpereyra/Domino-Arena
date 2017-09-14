package ar.edu.unq.domino.arena.menu

import ar.edu.unq.domino.Pizzas.Menu
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout
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

import ar.edu.unq.domino.Pizzas.Promocion
import org.uqbar.arena.widgets.GroupPanel
import ar.edu.unq.domino.Pizzas.Ingrediente

class MenuWindow extends TransactionalDialog<Sistema> {

	new(WindowOwner owner, Sistema model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
		mainPanel.layout = new VerticalLayout
		crearPanelDePromociones(it)
		crearPanelDeIngredientesExtras(it)
		title = "Dominos Pizza-Menu"
		]
	}

	def crearPanelDeIngredientesExtras(Panel mainPanel) {

		new Panel(mainPanel) => [
			new Label(it) => [
				text = "Ingredientes Disponibles"
				fontSize = 18
			]
			val table = new Table<Ingrediente>(mainPanel, typeof(Ingrediente)) => [
				items <=> "ingredientes"
			]

			this.crearTablaIngrediente(table)

			// Panel botones laterales
			val buttonPanel = new Panel(mainPanel) => [
				layout = new VerticalLayout
			]
			new Button(buttonPanel) => [
				caption = 'Crear'
				width = 75
			]

			new Button(buttonPanel) => [
				caption = 'Editar'
				width = 75

			]
			new Button(buttonPanel) => [
				caption = 'Eliminar'
				width = 75
			]
		]
	}

	def crearPanelDePromociones(Panel mainPanel) {

		new Panel(mainPanel) => [
			new Label(it) => [
				text = "Promociones"
				fontSize = 18
			]
			val table = new Table<Promocion>(mainPanel, typeof(Promocion)) => [
				items <=> "promos"
			]

			this.crearTablaPromo(table)

			// Panel botones laterales
			val buttonPanel = new Panel(mainPanel) => [
				layout = new VerticalLayout
			]
			new Button(buttonPanel) => [
				caption = 'Crear'
				width = 75
			]

			new Button(buttonPanel) => [
				caption = 'Editar'
				width = 75

			]
			new Button(buttonPanel) => [
				caption = 'Eliminar'
				width = 75
			]
		]
	}
//creacion de tablas
	def crearTablaPromo(Table<Promocion> table) {
		new Column(table) => [
			title = "Nombre"
			fixedSize = 300
			bindContentsToProperty("nombrePromo")
		]

		new Column(table) => [
			title = "Precio"
			fixedSize = 120
			bindContentsToProperty("precioBase")
		]

	}

	def crearTablaIngrediente(Table<Ingrediente> table) {
		new Column(table) => [
			title = "Nombre"
			fixedSize = 300
			bindContentsToProperty("nombre")
		]

		new Column(table) => [
			title = "Precio"
			fixedSize = 120
			bindContentsToProperty("precio")
		]
	}

}
