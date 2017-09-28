package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.windows.WindowOwner
import ar.edu.unq.domino.appModel.MenuAppModel

class CrearPlatoWindow extends EditarPlatoWindow {

	new(WindowOwner parent, MenuAppModel model) {
		super(parent, model)

	}

	override def defaultTitle() {

		"Agregar plato"
	}

}
