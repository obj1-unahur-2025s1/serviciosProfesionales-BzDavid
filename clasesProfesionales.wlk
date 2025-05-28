class ProfesionalVinculado {
  const property universidad

  method initialize() {
    validacion.validarUniversidad_(universidad)
  }

  method honorarios() = universidad.honorarioRecomendado()

  method provincias() = [universidad.provincia()] 

  method puedeTrabajarEnProvincia_(unaProvincia) = self.provincias().contains(unaProvincia)

  method cobrarDinero(cantidadACobrar) {
    universidad.recibirDonacion(cantidadACobrar / 2)
  }
}

class ProfesionalLitoral {
  const property universidad

  const property provincias = ["Entre Rios", "Santa Fe", "Corrientes"]

  method initialize() {
    validacion.validarUniversidad_(universidad)
    validacion.validarListaDeProvincias_(provincias)
  }

  method honorarios () = 3000

  method puedeTrabajarEnProvincia_(unaProvincia) = provincias.contains(unaProvincia)

  method cobrarDinero(cantidadACobrar) {
    asociacionProfesionalesLitoral.recibirImporte(cantidadACobrar)
  }
}

class ProfesionalLibre {
  const property universidad

  const property honorarios

  const property provincias

  var totalRecaudado = 0

  method initialize() {
    validacion.validarUniversidad_(universidad)
    validacion.validarListaDeProvincias_(provincias)
    validacion.validarHonorarios_(honorarios)
  }

  method dinero() = totalRecaudado

  method puedeTrabajarEnProvincia_(unaProvincia) = provincias.contains(unaProvincia)

  method agregarProvincia(unaProvincia) {
    provincias.add(unaProvincia)
  }

  method quitarProvincia(unaProvincia) {
    provincias.remove(unaProvincia)
  }

  method cobrarDinero(cantidadACobrar) {
    totalRecaudado += cantidadACobrar
  }

  method pasarCantidad_DeDineroA_(cantidadAPasar, profesionalAPasar) {
    if (cantidadAPasar <= totalRecaudado) {
      profesionalAPasar.cobrarDinero(cantidadAPasar)
      totalRecaudado -= cantidadAPasar
    }
  }
}

class Universidad {
  const property provincia

  const property honorarioRecomendado

  var totalDeDonacionesRecibidas = 0

  method initialize() {
    validacion.validarListaDeProvincias_([provincia])
    validacion.validarHonorarios_(honorarioRecomendado)
  }

  method recibirDonacion(cantidadADonar) {
    totalDeDonacionesRecibidas += cantidadADonar 
  }

  method totalDeDonacionesRecibidas() = totalDeDonacionesRecibidas

  method esValida() = true
}

class EmpresaDeServicios {
  const property empleados = []

  const conjuntoDeClientes = #{} 

  const honorarioDeReferencia 

  method initialize() {
    validacion.validarHonorarios_(honorarioDeReferencia)
  }

  method contratarProfesional(unProfesional) {
    empleados.add(unProfesional)
  }

  method despedirProfesional(unProfesional) {
    empleados.remove(unProfesional)
  }

  method cuantosProfesionalesEstudiaronEn_(unaUniversidad) = empleados.count({empleado => empleado.universidad() == unaUniversidad}) 

  method conjuntoDeProfesionalesCaros() = empleados.filter({empleado => empleado.honorarios() > honorarioDeReferencia}).asSet()

  method conjuntoDeUniversidadesFormadoras() = empleados.map({empleado => empleado.universidad()}).asSet()

  method profesionalMasBarato() = empleados.min({empleado => empleado.honorarios()})

  method esDeGenteAcotada() = empleados.all({empleado => empleado.provincias().size() <= 3})

  method puedeSatisfacerAlCliente_(unCliente) = empleados.any({empleado => unCliente.puedeSerAtendidoPor_(empleado)})

  method listaDeEmpleadosQuePuedenSatisfacerA_(unCliente) = empleados.filter({empleado => unCliente.puedeSerAtendidoPor_(empleado)})

  method darServicio(unCliente) {
    if(self.puedeSatisfacerAlCliente_(unCliente)){
      const empleadoSeleccionado = self.listaDeEmpleadosQuePuedenSatisfacerA_(unCliente).anyOne()
      empleadoSeleccionado.cobrarDinero(empleadoSeleccionado.honorarios())
      conjuntoDeClientes.add(unCliente)
    }
  }

  method cantidadDeClientes() = conjuntoDeClientes.size()

  method tieneCliente_(unCliente) = conjuntoDeClientes.contains(unCliente)

  method puedeCubrirALaProvincia_(unaProvincia) = empleados.any({empleado => empleado.puedeTrabajarEnProvincia_(unaProvincia)})

  method listaDeEmpleadosQuePuedenTrabajarEnProvincia_(unaProvincia) = empleados.filter({empleado => empleado.puedeTrabajarEnProvincia_(unaProvincia)})

  method costoDeServicioMasBajoEnProvincia_(unaProvincia) = self.listaDeEmpleadosQuePuedenTrabajarEnProvincia_(unaProvincia).map({empleado => empleado.honorarios()}).min()

  method esProfesional_PocoAtractivo(unProfesional) = unProfesional.provincias().all({provincia => self.puedeCubrirALaProvincia_(provincia) and unProfesional.honorarios() > self.costoDeServicioMasBajoEnProvincia_(provincia)})

  /*
  Voy a anotar cómo lo hice. (Alt + z en vscode)
  Primero, al profesional que recibo por parámetro le saco las provincias en las que puede trabajar. Luego, por cada provincia le ejecuto el bloque de código. Este bloque de código me devuelve un booleano, que es el resultado de dos métodos que incluye la empresa. El primero es el método puedeCubrirALaProvincia_(unaProvincia), que me dice si la empresa puede cubrir la provincia que le pase por parámetro. El segundo es el método costoDeServicioMasBajoEnProvincia_(unaProvincia), que me dice cúal es el costo más bajo de la empresa en una provincia que se le pase por parámetro. Acá hay dos cosas importantes: Primero: La provincia debe estar cubierta por la empresa. Por este motivo fue que puse primero el método puedeCubrirALaProvincia_(unaProvincia), ya que si este da false, no se ejecuta el segundo método, que fallaría si no se pudiera cubrir la provincia. Segundo: El método costoDeServicioMasBajoEnProvincia_() lo puse con un comparador ">" con respecto a los honorarios del trabajador que se recibe ya que a mí parecer, si estos llegasen a cobrar lo mismo, no cobra "más barato" al cobrar lo mismo. */
}

class PersonaSolicitante {
  const property provincia

  method initialize() {
    validacion.validarListaDeProvincias_([provincia])
  }

  method puedeSerAtendidoPor_(unProfesional) = unProfesional.puedeTrabajarEnProvincia_(provincia)
}

class Institucion {
  const property universidadesReconocidas 

  method initialize() {
    validacion.validarUniversidades_(universidadesReconocidas)
  }

  method puedeSerAtendidoPor_(unProfesional) = universidadesReconocidas.any({universidad => universidad == unProfesional.universidad()})
}

class Club {
  const property provincias

  method initialize() {
    validacion.validarListaDeProvincias_(provincias)
  }

  method puedeSerAtendidoPor_(unProfesional) = provincias.any({provincia => unProfesional.puedeTrabajarEnProvincia_(provincia)})
}

object asociacionProfesionalesLitoral {
  var totalRecaudado = 0

  method totalRecaudado() = totalRecaudado

  method recibirImporte(cantidadACobrar) {
    totalRecaudado += cantidadACobrar
  }
}

//Provincias
object provincias {
  method esValida_(unaProvincia) = self.lista().contains(unaProvincia) 

  method esValidaLaLista_(listaDeProvincias) = listaDeProvincias.all({provincia => self.esValida_(provincia)})

  method lista() = ["Buenos Aires", "Corrientes", "Entre Rios", "La Rioja", "Cordoba", "Santa Fe", "San Juan", "San Luis", "Mendoza", "Tucuman", "Catamarca", "Santiago del Estero", "Chaco", "Formosa", "Misiones", "Jujuy", "Salta", "Neuquen"]
}

object validacion {
  method validarUniversidad_(unaUniversidad) {
    if(not unaUniversidad.esValida()) {
      self.error("La universidad no es válida")
    }
  }

  method validarListaDeProvincias_(listaDeProvincias) {
    if(not provincias.esValidaLaLista_(listaDeProvincias)) {
      self.error("Algunas de las provincias no son válidas")
    }
  }

  method validarHonorarios_(unHonorario) {
    if(unHonorario <= 1000) {
      self.error("El honorario debe ser mayor a 1000")
    }
  }

  method validarUniversidades_(listaDeUniversidades) {
    if(listaDeUniversidades.any({universidad => not universidad.esValida()})) {
      self.error("Algunas de las universidades no son válidas")
    }
  } 
}