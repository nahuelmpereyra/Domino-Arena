package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.RadioSelector
import org.uqbar.arena.widgets.Button
import ar.edu.unq.domino.Pizzas.Promocion
import org.uqbar.arena.bindings.ObservableProperty
import ar.edu.unq.domino.appModel.Buscador
import ar.edu.unq.domino.repo.RepoPromociones
import ar.edu.unq.domino.Pizzas.Plato
import ar.edu.unq.domino.TamanioPizzas.TamanioPromo
import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.domino.Pizzas.Ingrediente
import ar.edu.unq.domino.repo.RepoIngredientes
import ar.edu.unq.domino.Pizzas.DistribucionPizza
import ar.edu.unq.domino.repo.RepoTamanios

class EditarPlatoWindow extends TransactionalDialog<Buscador> {

	new(WindowOwner owner) {
		super(owner, new Buscador)
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

	/*
	 * 
	 * 

	 * val panel2 = new Panel(mainPanel) => [
	 * 	layout = new VerticalLayout
	 * ]

	 * val panel3 = new Panel(panel2).layout = new HorizontalLayout

	 * new CheckBox(panel3) => []

	 * new Label(panel3).text = "Jamon"

	 * new RadioSelector(panel3) => [
	 * 	// Fijarse como utilizar esto bien.	 								
	 * ]

	 * val panel4 = new Panel(panel2).layout = new HorizontalLayout

	 * new CheckBox(panel4) => []

	 * new Label(panel4).text = "Anana"

	 * new RadioSelector(panel4) => [
	 * 	// Fijarse como utilizar esto bien.
	 * ]

	 * val panel5 = new Panel(panel2).layout = new HorizontalLayout

	 * new CheckBox(panel5) => []

	 * new Label(panel5).text = "Morrones"

	 * new RadioSelector(panel5) => []

	 * val panel6 = new Panel(panel2).layout = new HorizontalLayout

	 * new CheckBox(panel6) => []

	 * new Label(panel6).text = "Queso"

	 * new RadioSelector(panel6) => []

	 * val panelPrecio = new Panel(mainPanel).layout = new HorizontalLayout

	 * new Label(panelPrecio).text = "Precio"

	 * val panelFinal = new Panel(mainPanel).layout = new HorizontalLayout

	 * new Button(panelFinal) => [
	 * 	caption = 'Aceptar'
	 * 	width = 60
	 * 	onClick[]
	 * ]

	 * new Button(panelFinal) => [
	 * 	caption = 'Cancelar'
	 * 	width = 60
	 * 	onClick[close]
	 * ]

	 * }

	 */
	}

	def mostrarIngredientes(Panel panel) {
		val formIng = new Panel(panel).layout = new ColumnLayout(3)
		var ingredientes = repoIngrediente.ingredientes

		for (ingrediente : ingredientes) {
			new CheckBox(formIng) => []
			new Label(formIng) => [
				text = ingrediente.getNombre()
			]
			new Selector<DistribucionPizza>(formIng) => [

				allowNull(false)
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

}
