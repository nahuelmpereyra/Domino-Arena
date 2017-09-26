package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Button
import ar.edu.unq.domino.Pizzas.Promocion
import org.uqbar.arena.bindings.ObservableProperty
import ar.edu.unq.domino.appModel.Buscador
import ar.edu.unq.domino.repo.RepoPromociones
import ar.edu.unq.domino.TamanioPizzas.TamanioPromo
import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.domino.Pizzas.Ingrediente
import ar.edu.unq.domino.repo.RepoIngredientes
import ar.edu.unq.domino.repo.RepoTamanios
import ar.edu.unq.domino.distribuciones.DistribucionPizza
import ar.edu.unq.domino.repo.RepoDistribuciones
import ar.edu.unq.domino.Pizzas.Plato

class EditarPlatoWindow extends TransactionalDialog<Buscador> {

	new(WindowOwner owner, Buscador model) {
		super(owner, model)
		title = defaultTitle
	}

	def defaultTitle() {
		"Editar Plato"
	}

	override protected createFormPanel(Panel mainPanel) {

		val form = new Panel(mainPanel).layout = new ColumnLayout(2)

		new Label(form) => [
			text = "Pizza"
			alignLeft
			fontSize = 10
		]

		new Selector<Promocion>(form) => [
			allowNull(false)
			value <=> "promoSeleccionada"
			val propiedadPromociones = bindItems(new ObservableProperty(repoPromo, "promociones"))
			propiedadPromociones.adaptWith(typeof(Promocion), "nombrePromo") // No sé por qué no puedo hacer "nombrePromo" + "precioBase".toString
		]

		new Label(form) => [
			text = "Tamaño"
			alignLeft
			fontSize = 10
		]

		new Selector<TamanioPromo>(form) => [
			allowNull(false)
			value <=> "tamanioSeleccionado"
			val propiedadTamanio = bindItems(new ObservableProperty(repoTamanios, "tamanios"))
			propiedadTamanio.adaptWith(typeof(TamanioPromo), "nombre")
		]

		new Label(form) => [
			text = "Agregados"
			alignLeft
			fontSize = 11
		]

		this.mostrarIngredientes(mainPanel)
	}

	def mostrarIngredientes(Panel panel) {
		val formIng = new Panel(panel).layout = new ColumnLayout(3)
		var ingredientes = repoIngrediente.ingredientes

		for (ingrediente : ingredientes) {
			new CheckBox(formIng) => [
				
			]
			new Label(formIng) => [
				text = ingrediente.getNombre()
			]
			new Selector<DistribucionPizza>(formIng) => [
				allowNull(false)
				val propiedadDistribuciones = bindItems(new ObservableProperty(repoDistribuciones, "distribuciones"))
				propiedadDistribuciones.adaptWith(typeof(DistribucionPizza), "nombre")
			]
		}

	}

	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [|this.accept]
			setAsDefault
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [|this.cancel]
		]
	}

	// PRECIO
	// ********************************************************
	// ** Acciones
	// ********************************************************	
	def getRepoIngrediente() {
		ApplicationContext.instance.getSingleton(typeof(Ingrediente)) as RepoIngredientes
	}

	def getRepoPromo() {
		ApplicationContext.instance.getSingleton(typeof(Promocion)) as RepoPromociones
	}

	def getRepoTamanios() {
		ApplicationContext.instance.getSingleton(typeof(TamanioPromo)) as RepoTamanios
	}
	
	def getRepoDistribuciones() {
		ApplicationContext.instance.getSingleton(typeof(DistribucionPizza)) as RepoDistribuciones
	}

}
