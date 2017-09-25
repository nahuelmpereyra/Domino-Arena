package ar.edu.unq.domino.arena.menu

import ar.edu.unq.domino.Pizzas.Ingrediente
import ar.edu.unq.domino.appModel.BuscadorIngredientes
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

class MenuWindow extends SimpleWindow<BuscadorIngredientes> {

	new(WindowOwner parent) {
		super(parent, new BuscadorIngredientes)
		modelObject.search
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Dominos Pizza - Menú"

		super.createMainTemplate(mainPanel)
		

	}

	override protected addActions(Panel mainPanel) {

		// Deshabilitar los botones si no hay ningún elemento seleccionado en la grilla.
		val actionsPanel = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(actionsPanel) => [
			caption = "Crear"
			onClick([|this.crearIngrediente])
		]
		
		val elementSelected = new NotNullObservable("ingredienteSeleccionado")
		

		new Button(actionsPanel) => [
			caption = "Editar"
			onClick([|this.modificarIngrediente])
			bindEnabled(elementSelected)
		]

		new Button(actionsPanel) => [
			caption = "Eliminar"
			onClick([|modelObject.eliminarIngredienteSeleccionado])
		    bindEnabled(elementSelected)
		]
		


	}

	// *************************************************************************
	// ** RESULTADOS DE LA BUSQUEDA
	// *************************************************************************
	override def protected createFormPanel(Panel mainPanel) {
		val table = new Table<Ingrediente>(mainPanel, typeof(Ingrediente)) => [

			items <=> "resultados"
			value <=> "ingredienteSeleccionado"
			numberVisibleRows = 4
		]
		this.describeResultsGrid(table)
	}

	def void describeResultsGrid(Table<Ingrediente> table) {
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

	// ********************************************************
	// ** Acciones
	// ********************************************************
	def void crearIngrediente() {
		this.openDialog(new CrearIngredienteWindow(this))
	}

	def void modificarIngrediente() {
		this.openDialog(new EditarIngredienteWindow(this, modelObject.ingredienteSeleccionado))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

}
