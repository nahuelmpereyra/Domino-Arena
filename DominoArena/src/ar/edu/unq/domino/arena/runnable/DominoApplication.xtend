package ar.edu.unq.domino.arena.runnable

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import ar.edu.unq.domino.arena.ui.PedidosAbiertosWindow


class DominoApplication extends Application {

	new(DominoBootstrap bootstrap) {

		super(bootstrap)
	}

	def static main(String[] args) {
		new DominoApplication(new DominoBootstrap).start
	}

	override protected Window<?> createMainWindow() {
		return new PedidosAbiertosWindow(this)
	}
}
