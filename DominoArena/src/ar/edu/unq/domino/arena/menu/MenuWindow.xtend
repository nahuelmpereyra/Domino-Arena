package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout
import ar.edu.unq.domino.sistema.Sistema
import org.uqbar.arena.widgets.tables.Table
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import ar.edu.unq.domino.Pizzas.Promocion
import ar.edu.unq.domino.Pizzas.Ingrediente
import org.uqbar.arena.layout.HorizontalLayout

class MenuWindow extends TransactionalDialog<Sistema> {

	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)
	}

	override protected createFormPanel(Panel mainPanel) {

		mainPanel.layout = new VerticalLayout

		// Panel principal
		
		val panel = new Panel(mainPanel) => [
			layout = new VerticalLayout
		]
		title = 'Dominos Pizza - Menú'
		
		// Panel Promos
		
		val panelPromos = new Panel(panel) => [
			layout = new HorizontalLayout
		]

		val tablePromos = new Table<Promocion>(panelPromos, typeof(Promocion)) => [
			items <=> "menu.promociones"
		]

		this.crearTablaPromo(tablePromos)

		this.crearBotonesLaterales(panelPromos)
		
		
		// Panel Ingredientes
		
		val panelIngredientes = new Panel(panel) => [
			layout = new HorizontalLayout
		]

		val tableIngredientes = new Table<Ingrediente>(panelIngredientes, typeof(Ingrediente)) => [
			items <=> "menu.ingredientes"
		]

		this.crearTablaIngrediente(tableIngredientes)

		this.crearBotonesLaterales(panelIngredientes)

	}
	
	def crearBotonesLaterales(Panel panel){
		// Panel botones laterales de Ingredientes
		val botonesLaterales = new Panel(panel) => [
			layout = new VerticalLayout
		]


		new Button(botonesLaterales) => [
			caption = 'Crear'
			width = 75
		]

		new Button(botonesLaterales) => [
			caption = 'Editar'
			width = 75
		]

		new Button(botonesLaterales) => [
			caption = 'Eliminar'
			width = 75
		]
	}


	// Creación de tablas
	
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
