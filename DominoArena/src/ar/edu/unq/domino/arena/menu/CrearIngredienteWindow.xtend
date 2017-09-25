package ar.edu.unq.domino.arena.menu

import ar.edu.unq.domino.Pizzas.Ingrediente
import ar.edu.unq.domino.appModel.BuscadorIngredientes
import ar.edu.unq.domino.repo.RepoIngredientes
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CrearIngredienteWindow extends EditarIngredienteWindow{
	
	new(WindowOwner parent) {
		super(parent, new Ingrediente)
		
	}
	
	override defaultTitle(){
		
		"Crear Ingrediente"
	}
		
}