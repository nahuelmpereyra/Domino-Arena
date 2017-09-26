package ar.edu.unq.domino.arena.runnable

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import ar.edu.unq.domino.arena.ui.MenuWindow
import ar.edu.unq.domino.arena.ui.PedidosAbiertosWindow
import ar.edu.unq.domino.arena.ui.PedidoWindow

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
