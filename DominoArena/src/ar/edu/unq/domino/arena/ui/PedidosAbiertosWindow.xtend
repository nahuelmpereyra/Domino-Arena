package ar.edu.unq.domino.arena.ui

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import ar.edu.unq.domino.Pizzas.Pedido
import org.uqbar.arena.bindings.NotNullObservable

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
		tabla1.items <=> "appModelPedidos.pedidosAbiertos"
		tabla1.value <=> "appModelPedidos.pedidoSeleccionado"

		columna1.bindContentsToProperty("numero")
		columna2.bindContentsToProperty("estado")
		columna3.bindContentsToProperty("montoFinal")
		columna4.bindContentsToProperty("fecha")
		columna4.fixedSize = 150

		panelBotonesVerticales = new Panel(mainPanel)
		panelBotonesVerticales.layout = new VerticalLayout
		panelHorizontal = new Panel(panelBotonesVerticales)
		panelHorizontal.layout = new HorizontalLayout

		val elementSelectedPedido = new NotNullObservable("appModelPedidos.pedidoSeleccionado")

		new Button(panelHorizontal) => [
			caption = '<<<'
			bindEnabledToProperty("appModelPedidos.pedidoSeleccionado.estado.tienePrevio")
			onClick[this.estadoAnterior(modelObject.appModelPedidos.pedidoSeleccionado)]
			bindEnabled(elementSelectedPedido)
		]
		new Button(panelHorizontal) => [
			caption = '>>>'
			bindEnabledToProperty("appModelPedidos.pedidoSeleccionado.estado.tieneSiguiente")
			onClick[this.estadoSiguiente(modelObject.appModelPedidos.pedidoSeleccionado)]
			disableOnError
			bindEnabled(elementSelectedPedido)
		]
		new Button(panelBotonesVerticales) => [
			caption = 'Cancelar'
			width = 75
			onClick[modelObject.appModelPedidos.cancelarPedido]
			bindEnabled(elementSelectedPedido)
		]
		new Button(panelBotonesVerticales) => [
			caption = 'Editar'
			width = 75
			onClick[this.editarPedido]
			bindEnabled(elementSelectedPedido)
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

	def editarPedido() {
		this.openDialog(new EditarPedidoWindow(this, modelObject))

	}

	def estadoSiguiente(Pedido pedido) {
		pedido.estado.siguiente(pedido)
	}

	def estadoAnterior(Pedido pedido) {
		pedido.estado.anterior(pedido)
	}

}
