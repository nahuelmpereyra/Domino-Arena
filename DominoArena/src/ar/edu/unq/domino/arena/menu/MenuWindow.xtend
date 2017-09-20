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
import org.uqbar.arena.widgets.Label

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
			layout = new VerticalLayout
		]

		new Label(panelPromos) => [
			text = "Promos"
			fontSize = 13
			alignLeft
		]

		val panelPromos2 = new Panel(panelPromos) => [
			layout = new HorizontalLayout
		]

		val tablePromos = new Table<Promocion>(panelPromos2, typeof(Promocion)) => [
			items <=> "menu.promociones"
		]

		this.crearTablaPromo(tablePromos)

		this.crearBotonesLaterales(panelPromos2)

		// Panel Ingredientes
		val panelIngredientes = new Panel(panel) => [
			layout = new VerticalLayout
		]

		new Label(panelIngredientes) => [
			text = "Ingredientes Disponibles"
			fontSize = 13
			alignLeft
		]

		val panelIngredientes2 = new Panel(panelIngredientes) => [
			layout = new HorizontalLayout
		]

		val tableIngredientes = new Table<Ingrediente>(panelIngredientes2, typeof(Ingrediente)) => [
			items <=> "menu.ingredientes"
		]

		this.crearTablaIngrediente(tableIngredientes)

		this.crearBotonesLaterales(panelIngredientes2)

		// Boton cerrar
		val botonCerrarPanel = new Panel(panel) => [
			layout = new VerticalLayout

		]

		new Button(botonCerrarPanel) => [
			caption = 'Cerrar'
			width = 75
			onClick([close])
		]

	}

	def crearBotonesLaterales(Panel panel) {
		// Panel botones laterales
		val botonesLateralesPanel = new Panel(panel) => [
			layout = new VerticalLayout
		]

		new Button(botonesLateralesPanel) => [
			caption = 'Crear'
			width = 75
		]

		new Button(botonesLateralesPanel) => [
			caption = 'Editar'
			width = 75
		]

		new Button(botonesLateralesPanel) => [
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
