package ar.edu.unq.domino.arena.ui

import ar.edu.unq.domino.Pizzas.Ingrediente
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import ar.edu.unq.domino.Pizzas.Promocion
import ar.edu.unq.domino.appModel.Buscador

class MenuWindow extends SimpleWindow<Buscador> {

	new(WindowOwner parent) {
		super(parent, new Buscador)
		modelObject.search
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Dominos Pizza - Menú"

		super.createMainTemplate(mainPanel)

	}

	override protected addActions(Panel mainPanel) {
		new Button(mainPanel) => [
			caption = "Cerrar"
			onClick([|close])
		]
	}

	// *************************************************************************
	// ** RESULTADOS DE LA BUSQUEDA
	// *************************************************************************
	override def protected createFormPanel(Panel mainPanel) {

		val tablaPromos = new Table<Promocion>(mainPanel, typeof(Promocion)) => [

			items <=> "resultadosPromocion"
			value <=> "promoSeleccionada"
			numberVisibleRows = 4
		]
		this.describeResultsGridPromo(tablaPromos)

		// Deshabilitar los botones si no hay ningún elemento seleccionado en la grilla.
		val actionsPanelPromocion = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(actionsPanelPromocion) => [
			caption = "Crear"
			onClick([|this.crearPromo])
		]

		val elementSelectedPromo = new NotNullObservable("promoSeleccionada")

		new Button(actionsPanelPromocion) => [
			caption = "Editar"
			onClick([|this.modificarPromo])
			bindEnabled(elementSelectedPromo)
		]

		new Button(actionsPanelPromocion) => [
			caption = "Eliminar"
			onClick([|modelObject.eliminarPromocionSeleccionada])
			bindEnabled(elementSelectedPromo)
		]

		val tablaIngredientes = new Table<Ingrediente>(mainPanel, typeof(Ingrediente)) => [

			items <=> "resultadosIngrediente"
			value <=> "ingredienteSeleccionado"
			numberVisibleRows = 4
		]
		this.describeResultsGridIngrediente(tablaIngredientes)

		// Deshabilitar los botones si no hay ningún elemento seleccionado en la grilla.
		val actionsPanelIngrediente = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(actionsPanelIngrediente) => [
			caption = "Crear"
			onClick([|this.crearIngrediente])
		]

		val elementSelectedIngrediente = new NotNullObservable("ingredienteSeleccionado")

		new Button(actionsPanelIngrediente) => [
			caption = "Editar"
			onClick([|this.modificarIngrediente])
			bindEnabled(elementSelectedIngrediente)
		]

		new Button(actionsPanelIngrediente) => [
			caption = "Eliminar"
			onClick([|modelObject.eliminarIngredienteSeleccionado])
			bindEnabled(elementSelectedIngrediente)
		]

	}

	def void describeResultsGridIngrediente(Table<Ingrediente> table) {

		new Column<Ingrediente>(table) => [
			title = "Nombre"
			fixedSize = 250
			bindContentsToProperty("nombre")
		]

		new Column<Ingrediente>(table) => [
			title = "Precio"
			fixedSize = 100
			bindContentsToProperty("precio")
		]

	}

	def void describeResultsGridPromo(Table<Promocion> table) {
		new Column<Promocion>(table) => [
			title = "Nombre"
			fixedSize = 250
			bindContentsToProperty("nombrePromo")
		]

		new Column<Promocion>(table) => [
			title = "Precio"
			fixedSize = 100
			bindContentsToProperty("precioBase")
		]

	}

	// ********************************************************
	// ** Acciones
	// ********************************************************
	def void crearIngrediente() {
		this.openDialog(new CrearIngredienteWindow(this))
	}

	def void modificarIngrediente() {
		this.openDialog(new EditarIngredienteWindow(this, modelObject.ingredienteSeleccionado))
	}

	def void crearPromo() {
		this.openDialog(new CrearPromoWindow(this))
	}

	def void modificarPromo() {
		this.openDialog(new EditarPromoWindow(this, modelObject.promoSeleccionada))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

}
