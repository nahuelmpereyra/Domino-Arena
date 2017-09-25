package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.windows.WindowOwner
import ar.edu.unq.domino.sistema.Sistema
import org.uqbar.arena.widgets.Panel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout

class PedidosAbiertosWindow extends PedidoWindow {

	Panel panelBotonesVerticales

	Panel panelHorizontal

	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)
	}

	override protected createFormPanel(Panel mainPanel) {
		super.createFormPanel(mainPanel)
		title = "Dominos Pizza"
		label1.text = "Pedidos Abiertos"
		label1.alignLeft
		tabla1.items <=> "pedidos"
		columna1.title = "Pedido"
		columna2.title = "Estado"
		columna3.title = "Monto"
		columna4.title = "Hora"

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
