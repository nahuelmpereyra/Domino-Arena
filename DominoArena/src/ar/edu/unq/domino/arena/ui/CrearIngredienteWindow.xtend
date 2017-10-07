package ar.edu.unq.domino.arena.ui

import ar.edu.unq.domino.Pizzas.Ingrediente
import org.uqbar.arena.windows.WindowOwner

class CrearIngredienteWindow extends EditarIngredienteWindow {

	new(WindowOwner parent) {
		super(parent, new Ingrediente)

	}

	override defaultTitle() {

		"Crear Ingrediente"
	}
	
	override executeTask() {
		repoIngredientes.create(modelObject)
		super.executeTask()
	}

}
