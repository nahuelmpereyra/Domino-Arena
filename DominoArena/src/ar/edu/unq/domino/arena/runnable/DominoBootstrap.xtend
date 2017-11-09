package ar.edu.unq.domino.arena.runnable

import ar.edu.unq.domino.EstadosDePedido.EstadoDePedido
import ar.edu.unq.domino.Mailing.GMailSender
import ar.edu.unq.domino.Pizzas.Ingrediente
import ar.edu.unq.domino.Pizzas.IngredientesExtras
import ar.edu.unq.domino.Pizzas.Pedido
import ar.edu.unq.domino.Pizzas.Plato
import ar.edu.unq.domino.Pizzas.Promocion
import ar.edu.unq.domino.TamanioPizzas.Grande
import ar.edu.unq.domino.TamanioPizzas.TamanioPromo
import ar.edu.unq.domino.distribuciones.DistribucionPizza
import ar.edu.unq.domino.distribuciones.Toda
import ar.edu.unq.domino.formasDeEnvio.Delivery
import ar.edu.unq.domino.formasDeEnvio.RetiroLocal
import ar.edu.unq.domino.repo.RepoClientes
import ar.edu.unq.domino.repo.RepoDistribuciones
import ar.edu.unq.domino.repo.RepoEstados
import ar.edu.unq.domino.repo.RepoIngredientes
import ar.edu.unq.domino.repo.RepoPedidos
import ar.edu.unq.domino.repo.RepoPromociones
import ar.edu.unq.domino.repo.RepoTamanios
import ar.edu.unq.domino.sistema.Cliente
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext

class DominoBootstrap extends CollectionBasedBootstrap {


	Plato plato1
	Plato plato2

	new() {
		ApplicationContext.instance.configureSingleton(typeof(Ingrediente), new RepoIngredientes)
		ApplicationContext.instance.configureSingleton(typeof(Cliente), new RepoClientes)
		ApplicationContext.instance.configureSingleton(typeof(Promocion), new RepoPromociones)
		ApplicationContext.instance.configureSingleton(typeof(Pedido), new RepoPedidos)
		ApplicationContext.instance.configureSingleton(typeof(EstadoDePedido), new RepoEstados)
		ApplicationContext.instance.configureSingleton(typeof(TamanioPromo), new RepoTamanios)
		ApplicationContext.instance.configureSingleton(typeof(DistribucionPizza), new RepoDistribuciones)
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
		val retiroLocal = new RetiroLocal
		val retiroDelivery = new Delivery("Calle falsa 123")
		val tamanio = new Grande
		val ingredientesExtra = new IngredientesExtras
		val ingredientesJamonYMorron = new IngredientesExtras
		val ingredientesNapolitana = new IngredientesExtras
		val ingredientesHuevo = new IngredientesExtras
		val repoEstados = ApplicationContext.instance.getSingleton(typeof(EstadoDePedido)) as RepoEstados
		val repoTamanios = ApplicationContext.instance.getSingleton(typeof(TamanioPromo)) as RepoTamanios
		val repoDistribuciones = ApplicationContext.instance.getSingleton(typeof(DistribucionPizza)) as RepoDistribuciones

		GMailSender.config(new GMailSender("pruebasfacultadtpi@gmail.com", "unqui2017"))
		
		
		repoIngredientes => [
			create("Jamón", 15)
			create("Ananá", 5)
			create("Tomate", 5)
			create("Morrones", 10)
			create("Queso", 20)
			create("Huevo", 20)
		]
		
		ingredientesJamonYMorron.agregarIngrediente(repoIngredientes.searchByName("Jamón"), new Toda())
		ingredientesJamonYMorron.agregarIngrediente(repoIngredientes.searchByName("Morrones"), new Toda())
		ingredientesNapolitana.agregarIngrediente(repoIngredientes.searchByName("Tomate"), new Toda())
		ingredientesHuevo.agregarIngrediente(repoIngredientes.searchByName("Huevo"), new Toda())
		
		
		repoPromociones => [
			create("Jamón y morron", 150, ingredientesJamonYMorron )
			create("Napolitana", 145, ingredientesNapolitana)
			create("Huevo", 120, ingredientesHuevo)
			create("Armá tu pizza, con los ingredientes que mas te gusten", 70, ingredientesExtra)
		]

		plato1 = new Plato("Napolitana", repoPromociones.search("Napolitana").get(0), tamanio, ingredientesExtra)
		plato2 = new Plato("Jamón y Morrón",  repoPromociones.search("Huevo").get(0), tamanio, ingredientesExtra)

		repoClientes => [
			create("Esteban", "Esthebam", "root", "estebanmatas13@gmail.com", "Av falsa 123")
			create("Nahuel", "Nahuel", "root", "nahuelmpereyra@gmail.com", "Av falsa 1234")

		]

		repoPedidos => [
			create((repoClientes.search("Esthebam").get(0)), retiroDelivery, "Delivery")
			create((repoClientes.search("Nahuel").get(0)), retiroDelivery, "Cliente nuevo")
			create2((repoClientes.search("Nahuel").get(0)), retiroLocal, "")
			buscarPedidosAbiertos.get(0).agregarPlato(plato1)
			buscarPedidosAbiertos.get(0).agregarPlato(plato2)
			buscarPedidosAbiertos.get(1).agregarPlato(plato1)
		]

		// 1 Pedido  -->   1 o varios Platos  -->  1 Promo
		repoEstados => [
			createCancelado
			createEntregado
			createEnViaje
			createListoParaEnviar
			createPreparando
		]

		repoTamanios => [
			createChica
			createFamiliar
			createGrande
			createPorcion
		]

		repoDistribuciones => [
			createToda
			createMitadIzquierda
			createMitadDerecha
		]
		repoPromociones.allInstances.get(0).ingredientesBase.agregarIngrediente(repoIngredientes.search("Jamón").get(0), repoDistribuciones.allInstances.get(0)) 

	}

}
