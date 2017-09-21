package ar.edu.unq.domino.arena.menu

import org.uqbar.arena.widgets.Panel
import ar.edu.unq.domino.sistema.Sistema
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.tables.Table
import ar.edu.unq.domino.Pizzas.Pedido
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.aop.windows.TransactionalDialog

abstract class PedidoWindow extends TransactionalDialog<Sistema> {
	
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

	new(WindowOwner owner, Sistema sistema) {
		super(owner, sistema)

	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout

		// Panel principal
		panel1 = new Panel(mainPanel)
		panel1.layout = new VerticalLayout

		title = ""
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
		this.openDialog(new MenuWindow(this, modelObject))
	}

	def pedidosCerradosWindow() {
		this.openDialog(new PedidosCerradosWindow(this, modelObject))
	}
	

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
	
	def pedidosAbiertosWindow() {
		this.openDialog(new PedidosAbiertosWindow(this, modelObject))
	}

	def crearTablaPedidosAbiertos(Table<Pedido> table) {
		columna1 = new Column(tabla1)
		columna2 = new Column(tabla1)
		columna3 = new Column(tabla1)
		columna4 = new Column(tabla1)
		
		columna1.title = ""
		columna1.fixedSize = 100
		columna1.bindContentsToProperty("estado")
		// CORREGIR!!!!!!!!
		
		columna2.title = ""
		columna2.fixedSize = 100
		columna2.bindContentsToProperty("estado")
		
		
		columna3.title = ""
		columna3.fixedSize = 100
		columna3.bindContentsToProperty("monto")
		
		
		columna4.title = ""
		columna4.fixedSize = 100
		columna4.bindContentsToProperty("fecha")
		

	}

}
