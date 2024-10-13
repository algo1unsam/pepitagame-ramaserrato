import extras.*
import wollok.game.*

object pepita {

	var property energia = 100
	var property position = game.origin()

	method image() {
		return if (self.estaEnElNido()) 
			"pepita-grande.png" 
		else if (self.estaConSilvestre() or self.estaCansada())
			"pepita-gris.png"
		else "pepita.png"
	}

	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
		game.removeVisual(comida)
	}

	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		if(not self.estaCansada() && nuevaPosicion.x().between(0, 9) && nuevaPosicion.y().between(0, 9)){
			self.vola(position.distance(nuevaPosicion))
			position = nuevaPosicion
		}
		if (self.estaCansada()){
			game.removeTickEvent("GRAVEDAD")
			game.say(self, "PERDISTE! NOOO")
			game.schedule(2000, {game.stop()})
		}
	}

	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}
	
	
	method estaConSilvestre() {
		return position == silvestre.position()
	}

	method caer(altura){
		position = game.at(position.x(), 0.max(position.y() - altura))
	}
}

object energiaPepita{
	method position()=game.at(8,9)
	method text()= "Energia: "+pepita.energia()
	method textColor() = "FFFFFF"
}