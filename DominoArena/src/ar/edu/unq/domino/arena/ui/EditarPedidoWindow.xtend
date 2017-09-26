package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Table
import ar.edu.unq.domino.Pizzas.Plato
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout
import ar.edu.unq.domino.appModel.Buscador
import org.uqbar.arena.widgets.Selector
import ar.edu.unq.domino.EstadosDePedido.EstadoDePedido
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.windows.Dialog
import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.domino.repo.RepoEstados

class EditarPedidoWindow extends TransactionalDialog<Buscador> {
	
	new(WindowOwner owner, Buscador model) {
		super(owner, model)
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Editar Pedido"
		super.createMainTemplate(mainPanel)
	}
	
	override protected addActions(Panel mainPanel) {
		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick [|this.accept]
			setAsDefault
			disableOnError
		]

		new Button(mainPanel) => [
			caption = "Cancelar"
			onClick [|this.cancel]
		]
	}


override protected createFormPanel(Panel mainPanel) {
		
		new Label(mainPanel) => [
			text = "Estado"
			alignLeft
			fontSize = 14
		]
		
		new Selector<EstadoDePedido>(mainPanel) => [
			allowNull(false)
			value <=> "pedidoSeleccionado.estado"
			val propiedadEstados = bindItems(new ObservableProperty(repoEstados, "estados"))
			propiedadEstados.adaptWith(typeof(EstadoDePedido),"nombre")
					
			//bindItems(new ObservableProperty(modelObject.repoEstados, "estados"))
		]

		new Label(mainPanel) => [
			text = "Platos"
			alignLeft
			fontSize = 14
		]

	val tablaPlatos = new Table<Plato>(mainPanel, typeof(Plato)) => [

			items <=> "resultadosPlato"
			value <=> "platoSeleccionado"
			numberVisibleRows = 4
		]
		this.describeResultsGridPlato(tablaPlatos)
		
		// Deshabilitar los botones si no hay ningún elemento seleccionado en la grilla.
		val actionsPanelPlato = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(actionsPanelPlato) => [
			caption = "Agregar"
			onClick([|this.agregarPlato])
		]

		val elementSelectedPlato = new NotNullObservable("platoSeleccionado")

		new Button(actionsPanelPlato) => [
			caption = "Editar"
			//onClick([|this.modificarPlato])
			bindEnabled(elementSelectedPlato)
		]

		new Button(actionsPanelPlato) => [
			caption = "Eliminar"
			//onClick([|modelObject.eliminarPlatoSeleccionado])
			bindEnabled(elementSelectedPlato)
		]
		
}
		
def void describeResultsGridPlato(Table<Plato> table) {

		new Column<Plato>(table) => [
			title = "Nombre"
			fixedSize = 250
			bindContentsToProperty("nombre")
		]
		
		new Column<Plato>(table) => [
			title = "Tamaño"
			fixedSize = 100
			bindContentsToProperty("tamanio")
		]

		new Column<Plato>(table) => [
			title = "Precio"
			fixedSize = 100
			bindContentsToProperty("precio")
		]

	}
	
	
	// ********************************************************
	// ** Acciones
	// ********************************************************	
		
	def agregarPlato() {
		this.openDialog(new CrearPlatoWindow(this))
	}
		
	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

	def getRepoEstados() {
		ApplicationContext.instance.getSingleton(typeof(EstadoDePedido)) as RepoEstados
	}
}