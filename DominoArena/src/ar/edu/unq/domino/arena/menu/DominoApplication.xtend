package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.Application
import ar.edu.unq.domino.sistema.Sistema
import ar.edu.unq.domino.Pizzas.Plato

class DominoApplication extends Application {
	
	override protected createMainWindow() {
		new PedidosCerradosWindow(this, new Sistema())
	}
	
	def static main(String[] args) {
		new DominoApplication().start
	}
	
}