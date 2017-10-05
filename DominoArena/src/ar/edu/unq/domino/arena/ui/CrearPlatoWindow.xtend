package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.windows.WindowOwner
import ar.edu.unq.domino.appModel.PlatoAppModel
import ar.edu.unq.domino.Pizzas.Plato
import ar.edu.unq.domino.Pizzas.Pedido

class CrearPlatoWindow extends EditarPlatoWindow {

	new(WindowOwner parent,Pedido pedido) {
		super(parent, new Plato, pedido)

	}

	override def defaultTitle() {

		"Agregar nuevo plato"
	}

}
