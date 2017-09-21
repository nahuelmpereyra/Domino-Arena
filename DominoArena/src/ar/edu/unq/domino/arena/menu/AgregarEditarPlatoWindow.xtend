package ar.edu.unq.domino.arena.menu


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
import ar.edu.unq.domino.sistema.Sistema

class AgregarEditarPlatoWindow extends TransactionalDialog<Sistema> {

	new(WindowOwner owner, Sistema model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		
		title = "Plato"
		
		val panel = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]

		new Label(panel).text = "Pizza"
		
		new Selector(panel) => [
				width = 100
		]

		new Label(panel).text = "Tamaño"
		
		new Selector(panel) => [
			width=100
		]

		new Label(mainPanel).text = "Agregados"
		
		val panel2 = new Panel(mainPanel) => [
			layout = new VerticalLayout
		]

		val panel3 = new Panel(panel2).layout = new HorizontalLayout

		new CheckBox(panel3) => [

		]

		new Label(panel3).text = "Jamon"
		
		new RadioSelector(panel3) => [
		// Fijarse como utilizar esto bien.	 								
		]

		val panel4 = new Panel(panel2).layout = new HorizontalLayout

		new CheckBox(panel4) => [

		]

		new Label(panel4).text = "Anana"

		new RadioSelector(panel4) => [
		// Fijarse como utilizar esto bien.
		]

		val panel5 = new Panel(panel2).layout = new HorizontalLayout

		new CheckBox(panel5) => [

		]

		new Label(panel5).text = "Morrones"

		new RadioSelector(panel5) => [

		]

		val panel6 = new Panel(panel2).layout = new HorizontalLayout

		new CheckBox(panel6) => [

		]

		new Label(panel6).text = "Queso"

		new RadioSelector(panel6) => [

		]

		val panelPrecio = new Panel(mainPanel).layout = new HorizontalLayout

		new Label(panelPrecio).text = "Precio" 

		val panelFinal = new Panel(mainPanel).layout = new HorizontalLayout
		
		new Button(panelFinal) => [
			caption = 'Aceptar'
			width = 60
			onClick[ ]
		]
		
		new Button(panelFinal) => [
			caption = 'Cancelar'
			width = 60
			onClick[close]
		]	
		
		}
}
