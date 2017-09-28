package ar.edu.unq.domino.arena.ui

import ar.edu.unq.domino.Pizzas.Pedido
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.windows.Dialog
import ar.edu.unq.domino.appModel.DominoAppModel

abstract class PedidoWindow extends TransactionalDialog<DominoAppModel> {

	public Panel panel1
	public Panel panel2
	public Label label1
	public Table<Pedido> tabla1
	public Column<Table<Pedido>> columna1
	public Column<Table<Pedido>> columna2
	public Column<Table<Pedido>> columna3
	public Column<Table<Pedido>> columna4
	public Button boton1
	public Button boton2

	new(WindowOwner owner) {
		super(owner, new DominoAppModel)
		modelObject.search

	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout

		// Panel principal
		panel1 = new Panel(mainPanel)
		panel1.layout = new VerticalLayout

		label1 = new Label(panel1)
		tabla1 = new Table<Pedido>(panel1, typeof(Pedido))
		this.crearTablaPedidosAbiertos(tabla1)

		// Panel botones inferiores
		panel2 = new Panel(panel1)
		panel2.layout = new HorizontalLayout

		boton1 = new Button(panel2)
		boton2 = new Button(panel2)
		boton1.caption = ''
		boton1.width = 100
		boton2.caption = ''
		boton2.width = 100

	}

	def menuWindow() {
		this.openDialog(new MenuWindow(this, modelObject.appModelMenu))
	}

	def pedidosCerradosWindow() {
		this.openDialog(new PedidosCerradosWindow(this))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

	def pedidosAbiertosWindow() {
		this.openDialog(new PedidosAbiertosWindow(this))
	}



	def crearTablaPedidosAbiertos(Table<Pedido> tabla1) {
		columna1 = new Column(tabla1)
		columna2 = new Column(tabla1)
		columna3 = new Column(tabla1)
		columna4 = new Column(tabla1)

		columna1.title = "Pedido"
		columna1.fixedSize = 100

		columna2.title = "Estado"
		columna2.fixedSize = 100

		columna3.title = "Monto"
		columna3.fixedSize = 100

		columna4.title = "Hora"
		columna4.fixedSize = 100

	}

}
