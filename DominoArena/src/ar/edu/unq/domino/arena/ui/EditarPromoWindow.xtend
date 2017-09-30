package ar.edu.unq.domino.arena.ui

import ar.edu.unq.domino.Pizzas.Menu
import ar.edu.unq.domino.Pizzas.Promocion
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarPromoWindow extends TransactionalDialog<Promocion> {

	new(WindowOwner owner, Promocion model) {
		super(owner, model)
		title = defaultTitle
	}

	def defaultTitle() {
		"Editar Promoción"
	}

	override protected createFormPanel(Panel mainPanel) {
		val form = new Panel(mainPanel).layout = new ColumnLayout(2)

		new Label(form).text = "Nombre"

		new TextBox(form) => [
			value <=> "nombrePromo"
			width = 200
		]

		new Label(form).text = "Precio"

		new NumericField(form) => [
			value <=> "precioBase"
			width = 200
		]
	}

	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [|this.accept]
			setAsDefault
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [|this.cancel]
		]
	}



	override executeTask() {
		if (modelObject.isNew && modelObject.validar) {
			Menu.instance.agregarPromo(modelObject)
		} else {
			Menu.instance.modificarPromo(modelObject)
		}
		super.executeTask()
	}

}
