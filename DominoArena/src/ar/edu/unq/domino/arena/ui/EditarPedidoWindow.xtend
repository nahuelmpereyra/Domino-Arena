package ar.edu.unq.domino.arena.ui

import ar.edu.unq.domino.EstadosDePedido.EstadoDePedido
import ar.edu.unq.domino.Pizzas.Pedido
import ar.edu.unq.domino.Pizzas.Plato
import ar.edu.unq.domino.repo.RepoEstados
import ar.edu.unq.domino.repo.RepoPedidos
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.applicationContext.ApplicationContext

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import ar.edu.unq.domino.appModel.Buscador

class EditarPedidoWindow extends TransactionalDialog<Buscador> {

	new(WindowOwner owner, Buscador model) {
		super(owner, model)
		modelObject.search
	}

	override def createMainTemplate(Panel mainPanel) {
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
			title = "Pedido " + modelObject.pedidoSeleccionado.numero
			alignLeft
			fontSize = 14
		]

		new Label(mainPanel) => [
			text = "Estado"
			alignLeft
			fontSize = 14
		]

		new Selector<EstadoDePedido>(mainPanel) => [
			allowNull(false)
			val propiedadEstados = bindItems(new ObservableProperty(repoEstados, "estados"))
			propiedadEstados.adaptWith(typeof(EstadoDePedido), "nombre")

		]

		new Label(mainPanel) => [
			text = "Platos"
			alignLeft
			fontSize = 14
		]

		val tablaPlatos = new Table<Plato>(mainPanel, typeof(Plato)) => [

			items <=> "pedidoSeleccionado.platos"
			value <=> "platoSeleccionado"
			numberVisibleRows = 4
		]
		this.describeResultsGridPlato(tablaPlatos)
	
		val actionsPanelPlato = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(actionsPanelPlato) => [
			caption = "Agregar"
			onClick([|this.agregarPlato])
		]
		
		// Deshabilitar los botones si no hay ningún elemento seleccionado en la grilla.
		val elementSelectedPlato = new NotNullObservable("platoSeleccionado")

		new Button(actionsPanelPlato) => [
			caption = "Editar"
			onClick([|this.modificarPlato])
			bindEnabled(elementSelectedPlato)
		]

		new Button(actionsPanelPlato) => [
			caption = "Eliminar"
			onClick([|modelObject.eliminarPlatoSeleccionado])
			bindEnabled(elementSelectedPlato)
		]

		new Label(mainPanel) => [
			text = "Aclaraciones"
			alignLeft
			fontSize = 14
		]

		new TextBox(mainPanel) => [
			height = 100
			value <=> "pedidoSeleccionado.aclaracion"
		]

		var panelDatos = new Panel(mainPanel).layout = new ColumnLayout(2)

		new Label(panelDatos) => [
			text = "Cliente"
			alignLeft
		]

		new Label(panelDatos) => [
			value <=> "clienteSeleccionado.nombre"
		]

		new Label(panelDatos) => [
			text = "Costo de envio"
			alignLeft
		]

		new Label(panelDatos) => [
			value <=> "pedidoSeleccionado.formaDeRetiro.costoEnvio"
		]

		new Label(panelDatos) => [
			text = "Monto total"
			alignLeft
		]

		new Label(panelDatos) => [
			value <=> "pedidoSeleccionado.montoFinal"
		]

		new Label(panelDatos) => [
			text = "Fecha"
			alignLeft
		]

		new Label(panelDatos) => [
			value <=> "pedidoSeleccionado.fecha"
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
		this.openDialog(new CrearPlatoWindow(this, modelObject))
	}
	
	def void modificarPlato() {
		this.openDialog(new EditarPlatoWindow(this, modelObject))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

	def getRepoEstados() {
		ApplicationContext.instance.getSingleton(typeof(EstadoDePedido)) as RepoEstados
	}

	def getRepoPedidos() {
		ApplicationContext.instance.getSingleton(typeof(Pedido)) as RepoPedidos
	}

}
