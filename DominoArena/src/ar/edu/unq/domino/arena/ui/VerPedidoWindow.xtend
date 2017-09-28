package ar.edu.unq.domino.arena.ui
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.awt.Color
import ar.edu.unq.domino.appModel.DominoAppModel

class VerPedidoWindow extends EditarPedidoWindow {

	new(WindowOwner owner, DominoAppModel model) {
		super(owner, model)
	}

	override defaultTitle() {
		"Ver Pedido" + modelObject.appModelPedidos.pedidoSeleccionado.numero
	}

	override protected createFormPanel(Panel mainPanel) {
		
		new Label(mainPanel) => [
			text = "Estado"
			alignLeft
			fontSize = 14
		]
			
		this.crearVistaEstado(mainPanel)
		this.crearPanelPlatos(mainPanel)
		this.crearVistaAclaraciones(mainPanel)
		this.crearPanelDatos(mainPanel)


	}


	// ********************************************************
	// ** Acciones
	// ********************************************************	
	
/*
	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

	def getRepoEstados() {
		ApplicationContext.instance.getSingleton(typeof(EstadoDePedido)) as RepoEstados
	}

	def getRepoPedidos() {
		ApplicationContext.instance.getSingleton(typeof(Pedido)) as RepoPedidos
	}

*/
	def crearVistaEstado(Panel panel){
			new Label(panel) => [
			value <=> "appModelPedidos.pedidoSeleccionado.estado"
			alignCenter
			fontSize = 12
			background = Color.RED.brighter
			
		]
	}
	
	def crearVistaAclaraciones(Panel panel){
		new Label(panel) => [
			text = "Aclaraciones"
			alignLeft
			fontSize = 14
		]

		new Label(panel) => [
			height = 100
			value <=> "appModelPedidos.pedidoSeleccionado.aclaracion"
		]
	}
	

}
