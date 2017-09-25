package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.Application
import ar.edu.unq.domino.sistema.Sistema
import org.uqbar.arena.windows.Window

class DominoApplication extends Application {
	
	new(DominoBootstrap bootstrap){
		
		super(bootstrap)
	}
	
	
	def static main(String[] args) {
		new DominoApplication(new DominoBootstrap).start
	}
	
	override protected Window<?> createMainWindow() {
		return new MenuWindow(this)
	}
}