package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.domino.repo.RepoIngredientes
import ar.edu.unq.domino.Pizzas.Ingrediente

class DominoBootstrap extends CollectionBasedBootstrap{
	
		new() {
		ApplicationContext.instance.configureSingleton(typeof(Ingrediente), new RepoIngredientes)
	}

	/**
	 * Inicialización del juego de datos del repositorio
	 * 
	 */
	override run() {
		val repoIngredientes = ApplicationContext.instance.getSingleton(typeof(Ingrediente)) as RepoIngredientes


		repoIngredientes => [
			create("Morrón", 10)
			create("Jamón", 15)
		]
		
	}
	
}