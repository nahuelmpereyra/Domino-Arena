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

class CrearIngredienteWindow extends TransactionalDialog<Sistema>{
	
	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		title = "Ingrediente"
		
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
		
		val panel3 = new Panel(mainPanel) => [
		layout = new HorizontalLayout
		]
		
		new Button(panel3) => [
			caption = 'Aceptar'
			width = 75
		]

		new Button(panel3) => [
			caption = 'Cancelar'
			width = 75
			onClick([close])
		]
	}
	

	
}