package ar.edu.unq.domino.arena.ui

import ar.edu.unq.domino.Pizzas.Promocion
import org.uqbar.arena.windows.WindowOwner

class CrearPromoWindow extends EditarPromoWindow {

	new(WindowOwner parent) {
		super(parent, new Promocion)

	}

	override defaultTitle() {

		"Crear Promoción"
	}
	override executeTask() {
		repoPromociones.create(modelObject)
		super.executeTask()
	}

}
