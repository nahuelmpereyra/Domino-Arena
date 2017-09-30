package ar.edu.unq.domino.arena.runnable

import ar.edu.unq.domino.EstadosDePedido.EstadoDePedido
import ar.edu.unq.domino.Mailing.GMailSender
import ar.edu.unq.domino.Pizzas.Ingrediente
import ar.edu.unq.domino.Pizzas.IngredientesExtras
import ar.edu.unq.domino.Pizzas.Menu
import ar.edu.unq.domino.Pizzas.Pedido
import ar.edu.unq.domino.Pizzas.Plato
import ar.edu.unq.domino.Pizzas.Promocion
import ar.edu.unq.domino.TamanioPizzas.Grande
import ar.edu.unq.domino.TamanioPizzas.TamanioPromo
import ar.edu.unq.domino.distribuciones.DistribucionPizza
import ar.edu.unq.domino.formasDeEnvio.Delivery
import ar.edu.unq.domino.formasDeEnvio.RetiroLocal
import ar.edu.unq.domino.repo.RepoClientes
import ar.edu.unq.domino.repo.RepoDistribuciones
import ar.edu.unq.domino.repo.RepoEstados
import ar.edu.unq.domino.repo.RepoIngredientes
import ar.edu.unq.domino.repo.RepoPedidos
import ar.edu.unq.domino.repo.RepoPlatos
import ar.edu.unq.domino.repo.RepoPromociones
import ar.edu.unq.domino.repo.RepoTamanios
import ar.edu.unq.domino.sistema.Cliente
import java.util.List
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext

class DominoBootstrap extends CollectionBasedBootstrap {

	val List<Promocion> promosIniciales = newArrayList
	val List<Ingrediente> ingredientesIniciales = newArrayList
	
	new() {
		ApplicationContext.instance.configureSingleton(typeof(Ingrediente), new RepoIngredientes)
		ApplicationContext.instance.configureSingleton(typeof(Promocion), new RepoPromociones)
		ApplicationContext.instance.configureSingleton(typeof(Cliente), new RepoClientes)
		ApplicationContext.instance.configureSingleton(typeof(Pedido), new RepoPedidos)
		ApplicationContext.instance.configureSingleton(typeof(Plato), new RepoPlatos)
		ApplicationContext.instance.configureSingleton(typeof(EstadoDePedido), new RepoEstados)
		ApplicationContext.instance.configureSingleton(typeof(TamanioPromo), new RepoTamanios)
		ApplicationContext.instance.configureSingleton(typeof(DistribucionPizza), new RepoDistribuciones)
		

	}

	/**
	 * Inicialización del juego de datos del repositorio
	 * 
	 */
	override run() {
		val repoClientes = ApplicationContext.instance.getSingleton(typeof(Cliente)) as RepoClientes
		val repoPedidos = ApplicationContext.instance.getSingleton(typeof(Pedido)) as RepoPedidos
		val retiroLocal = new RetiroLocal
		val retiroDelivery = new Delivery
		val repoPlatos = ApplicationContext.instance.getSingleton(typeof(Plato)) as RepoPlatos
		val tamanio = new Grande
		val ingredientesExtra = new IngredientesExtras
		val repoEstados = ApplicationContext.instance.getSingleton(typeof(EstadoDePedido)) as RepoEstados
		val repoTamanios = ApplicationContext.instance.getSingleton(typeof(TamanioPromo)) as RepoTamanios
		val repoDistribuciones = ApplicationContext.instance.getSingleton(typeof(DistribucionPizza)) as RepoDistribuciones
		val menu = Menu.config(new Menu)
		GMailSender.config(new GMailSender("pruebasfacultadtpi@gmail.com", "unqui2017"))
		menu => [
			promociones = promosIniciales
			ingredientes = ingredientesIniciales
		]
		

		ingredientesIniciales => [
			add(new Ingrediente ("Jamón", 15))
			add(new Ingrediente("Ananá", 5))
			add(new Ingrediente ("Morrones", 5))
			add(new Ingrediente ("Queso", 5))
		]
		
		promosIniciales => [
			add(new Promocion ("Jamón y morron", 150, new IngredientesExtras))
			add(new Promocion ("Napolitana", 145, new IngredientesExtras))
			add(new Promocion ("Huevo", 500, new IngredientesExtras))
		]
		
		repoClientes => [
			create("Esteban", "Esthebam", "root", "nahuelmpereyra@gmail.com", "Av falsa 123")
			create("Ramiro", "Shamainco", "root", "nahuelmpereyra@gmail.com", "Av falsa 1234")

		]
		
		repoPlatos => [
			create("Napolitana", promosIniciales.get(0), tamanio, ingredientesExtra)
			create("Huevo", promosIniciales.get(2), tamanio, ingredientesExtra)
		]
		
		repoPedidos => [
			create((repoClientes.search("Esthebam").get(0)), retiroDelivery, "Delivery")
			create((repoClientes.search("Shamainco").get(0)), retiroDelivery, "Cliente nuevo")
			create2((repoClientes.search("Shamainco").get(0)), retiroLocal, "")
			buscarPedidosAbiertos.get(0).agregarPlato(repoPlatos.search("Napolitana").get(0))
			buscarPedidosAbiertos.get(0).agregarPlato(repoPlatos.search("Huevo").get(0))
			buscarPedidosAbiertos.get(1).agregarPlato(repoPlatos.search("Napolitana").get(0))
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

	}

}
