package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import ar.edu.unq.domino.Pizzas.Ingrediente
import org.uqbar.arena.windows.Dialog
import ar.edu.unq.domino.repo.RepoIngredientes

class CrearIngredienteWindow extends Dialog<Ingrediente>{
	
	new(WindowOwner owner, Ingrediente ingrediente) {
		super(owner, ingrediente)
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
			value <=> "nombre"
		]
		
		
		val panel2 = new Panel(mainPanel) => [
		layout = new HorizontalLayout
		]
		
		new Label(panel2).text = "Precio"
		new TextBox(panel2) => [
			width = 150
			value <=> "precio"
		]
		
		val panel3 = new Panel(mainPanel) => [
		layout = new HorizontalLayout
		]
		
		
		new Button(panel3) => [
			caption = 'Aceptar'
			width = 75
			onClick[| this.accept]
			setAsDefault
			disableOnError
		]

		new Button(panel3) => [
			caption = 'Cancelar'
			width = 75
			onClick[| this.cancel]
		]
	}
	
	override accept(){
		RepoIngredientes.instance.actualizarIngrediente(this.modelObject)
		super.accept
	}
	

	
}