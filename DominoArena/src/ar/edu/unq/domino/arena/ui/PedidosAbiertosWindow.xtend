package ar.edu.unq.domino.arena.ui

import ar.edu.unq.domino.appModel.EditarPedidoAppModel
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.time.LocalDateTime

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
		tabla1.items <=> "pedidosAbiertos"
		tabla1.value <=> "pedidoAbiertoSeleccionado"

		columna1.bindContentsToProperty("numero")
		columna2.bindContentsToProperty("estado")
		columna3.bindContentsToProperty("montoFinal")
		columna4.bindContentsToProperty("fecha").transformer = [ LocalDateTime f |
				val dias = f.dayOfMonth
				val meses = f.monthValue
				val anios = f.year
				val hora = f.hour
				val min = f.minute
				val seg = f.second
				val res = dias.toString + "/" + meses.toString + "/" + anios.toString + " " + hora.toString + ":" + min.toString + ":" + seg.toString
				res
			]
		columna4.fixedSize = 150
		

		panelBotonesVerticales = new Panel(mainPanel)
		panelBotonesVerticales.layout = new VerticalLayout
		panelHorizontal = new Panel(panelBotonesVerticales)
		panelHorizontal.layout = new HorizontalLayout

		val elementSelectedPedido = new NotNullObservable("pedidoAbiertoSeleccionado")

		new Button(panelHorizontal) => [
			caption = '<<<'
			onClick[modelObject.pasarEstadoAnterior(modelObject.pedidoAbiertoSeleccionado)]
			bindEnabled(elementSelectedPedido)
		]
		new Button(panelHorizontal) => [
			caption = '>>>'
			onClick[modelObject.pasarEstadoSiguiente(modelObject.pedidoAbiertoSeleccionado)]
			bindEnabled(elementSelectedPedido)
		]
		new Button(panelBotonesVerticales) => [
			caption = 'Cancelar'
			width = 75
			onClick[modelObject.cancelarPedido]
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
		this.openDialog(new EditarPedidoWindow(this, new EditarPedidoAppModel(modelObject.pedidoAbiertoSeleccionado)))
	}

}
