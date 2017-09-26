package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import ar.edu.unq.domino.Pizzas.Pedido

class PedidosAbiertosWindow extends PedidoWindow {

	Panel panelBotonesVerticales

	Panel panelHorizontal

	new(WindowOwner parent) {
		super(parent)
	}

	override protected createFormPanel(Panel mainPanel) {
		super.createFormPanel(mainPanel)
		title = "Dominos Pizza"
		label1.text = "Pedidos Abiertos"
		label1.alignLeft
		tabla1.items <=> "resultadosPedidosAbiertos"
		tabla1.value <=> "pedidoSeleccionado"

		columna1.bindContentsToProperty("numero")
		columna2.bindContentsToProperty("estado")
		columna3.bindContentsToProperty("monto")
		columna4.bindContentsToProperty("fecha")

		panelBotonesVerticales = new Panel(mainPanel)
		panelBotonesVerticales.layout = new VerticalLayout
		panelHorizontal = new Panel(panelBotonesVerticales)
		panelHorizontal.layout = new HorizontalLayout
		new Button(panelHorizontal) => [
			caption = '<<<'
			
		]
		new Button(panelHorizontal) => [
			caption = '>>>'
		]
		new Button(panelBotonesVerticales) => [
			caption = 'Cancelar'
			width = 75
		]
		new Button(panelBotonesVerticales) => [
			caption = 'Editar'
			width = 75
		]

		boton1.caption = 'Menú'
		boton1.onClick[this.menuWindow]
		boton2.caption = 'Pedidos cerrados'
		boton2.onClick[this.pedidosCerradosWindow]
		new Button(panel2) => [
			caption = 'Salir'
			width = 100
			onClick [close]
		]

	}
	


}
