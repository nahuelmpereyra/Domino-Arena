package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.Application
import ar.edu.unq.domino.sistema.Sistema

class DominoApplication extends Application {
	
	override protected createMainWindow() {
		new SistemaWindow(this, new Sistema)
	}
	
	def static main(String[] args) {
		new DominoApplication().start
	}
	
}