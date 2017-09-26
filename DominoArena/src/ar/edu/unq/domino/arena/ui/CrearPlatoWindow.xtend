package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.windows.WindowOwner
import ar.edu.unq.domino.appModel.Buscador
import ar.edu.unq.domino.Pizzas.Plato

class CrearPlatoWindow extends EditarPlatoWindow {

	new(WindowOwner parent) {
		super(parent)

	}

	override def defaultTitle() {

		"Agregar plato"
	}

}
