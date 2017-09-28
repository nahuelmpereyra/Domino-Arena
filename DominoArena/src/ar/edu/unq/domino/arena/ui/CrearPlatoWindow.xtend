package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.windows.WindowOwner
import ar.edu.unq.domino.appModel.DominoAppModel

class CrearPlatoWindow extends EditarPlatoWindow {

	new(WindowOwner parent, DominoAppModel model) {
		super(parent, model)

	}

	override def defaultTitle() {

		"Agregar plato"
	}

}
