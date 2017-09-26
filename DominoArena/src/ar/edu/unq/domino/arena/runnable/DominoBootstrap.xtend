package ar.edu.unq.domino.arena.runnable

import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.domino.repo.RepoIngredientes
import ar.edu.unq.domino.Pizzas.Ingrediente
import ar.edu.unq.domino.Pizzas.Promocion
import ar.edu.unq.domino.repo.RepoPromociones
import ar.edu.unq.domino.repo.RepoPedidos
import ar.edu.unq.domino.repo.RepoClientes

import ar.edu.unq.domino.sistema.Cliente
import ar.edu.unq.domino.Pizzas.Pedido
import ar.edu.unq.domino.formasDeEnvio.RetiroLocal
import ar.edu.unq.domino.formasDeEnvio.FormaDeRetiro

class DominoBootstrap extends CollectionBasedBootstrap {
	FormaDeRetiro formaDeRetiro

	new() {
		ApplicationContext.instance.configureSingleton(typeof(Ingrediente), new RepoIngredientes)
		ApplicationContext.instance.configureSingleton(typeof(Promocion), new RepoPromociones)
		ApplicationContext.instance.configureSingleton(typeof(Cliente), new RepoClientes)
		ApplicationContext.instance.configureSingleton(typeof(Pedido), new RepoPedidos)

	}

	/**
	 * Inicialización del juego de datos del repositorio
	 * 
	 */
	override run() {
		val repoIngredientes = ApplicationContext.instance.getSingleton(typeof(Ingrediente)) as RepoIngredientes
		val repoPromociones = ApplicationContext.instance.getSingleton(typeof(Promocion)) as RepoPromociones
		val repoClientes = ApplicationContext.instance.getSingleton(typeof(Cliente)) as RepoClientes
		val repoPedidos = ApplicationContext.instance.getSingleton(typeof(Pedido)) as RepoPedidos
		val formaDeRetiro = new RetiroLocal

		repoIngredientes => [
			create("Morrón", 10)
			create("Jamón", 15)
		]

		repoPromociones => [
			create("Jamón y morron", 150)
			create("Napolitana", 145)
		]
		repoClientes => [
			create("Esteban", "Esthebam", "root", "estebanmatas13@gmail.com", "Av falsa 123")
			create("Ramiro", "Shamainco", "root", "Shamainco@gmail.com", "Av falsa 1234")

		]
		repoPedidos => [
			create((repoClientes.search("Esthebam").get(0)), formaDeRetiro, "")
			create((repoClientes.search("Shamainco").get(0)), formaDeRetiro, "")
		 	create2((repoClientes.search("Shamainco").get(0)), formaDeRetiro, "")
		]


 
	
	}

}
