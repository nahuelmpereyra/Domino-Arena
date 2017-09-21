package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.aop.windows.TransactionalDialog
import ar.edu.unq.domino.sistema.Sistema
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.RadioSelector

class CrearEditarPromoPizzaWindow extends TransactionalDialog<Sistema>{
	
	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		title = "Promo"
		
		mainPanel.layout = new VerticalLayout
		
		val panel1 = new Panel(mainPanel) => [
		layout = new HorizontalLayout
		]
		
		new Label(panel1).text = "Nombre"
		new TextBox(panel1) => [
			width = 150
		]
		
		val panel2 = new Panel(mainPanel) => [
		layout = new HorizontalLayout
		]
		
		new Label(panel2).text = "Precio"
		new TextBox(panel2) => [
			width = 150
		]
		
		val panel3 = new Panel(mainPanel).layout = new HorizontalLayout

		new CheckBox(panel3) => [

		]

		new Label(panel3).text = "Jamon"
		
		new RadioSelector(panel3) => [
			 								
		]

		val panel4 = new Panel(mainPanel).layout = new HorizontalLayout

		new CheckBox(panel4) => [

		]

		new Label(panel4).text = "Anana"

		new RadioSelector(panel4) => [
		
		]

		val panel5 = new Panel(mainPanel).layout = new HorizontalLayout

		new CheckBox(panel5) => [

		]

		new Label(panel5).text = "Morrones"

		new RadioSelector(panel5) => [

		]

		val panel6 = new Panel(mainPanel).layout = new HorizontalLayout

		new CheckBox(panel6) => [

		]

		new Label(panel6).text = "Queso"

		new RadioSelector(panel6) => [

		]
		
		val panel7 = new Panel(mainPanel) => [
		layout = new HorizontalLayout
		]
		
		new Button(panel7) => [
			caption = 'Aceptar'
			width = 75
		]

		new Button(panel7) => [
			caption = 'Cancelar'
			width = 75
			onClick([close])
		]
		
	}
	
}