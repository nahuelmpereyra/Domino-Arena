package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.windows.WindowOwner

import ar.edu.unq.domino.Pizzas.Promocion

class CrearPromoWindow extends EditarPromoWindow {

	new(WindowOwner parent) {
		super(parent, new Promocion)

	}

	override defaultTitle() {

		"Crear Promoción"
	}

}
