// --------------------------------
// Cotizadores

object cotizadorPapa {
    method importeTotal(cant) = produccion.costo(cant) + impuesto.valorDeImpuesto(cant) + derechoDeExportacion.valorDerechoDeExportacion(cant)
}

object cotizadorBatata {
  var property costoDeProduccion = 100
  var property impuesto = impuestoCompuesto

  method importeTotal() = costoDeProduccion + impuesto.valorDeImpuesto()
}

object cotizadorZapallo {
  method importeTotal(cant) = produccionRegular.costo(cant) + derechoDeExportacion.valorDerechoDeExportacion(cant) / 2
}

// --------------------------------
// Producciones

object produccion {
  var tipoDeProduccion = produccionBuena
  //var property cant = 1

  method costo(cant) = tipoDeProduccion.costo(cant) 

  method cambioDeTipo(nuevoTipo) {
    tipoDeProduccion = nuevoTipo
  }
}

object produccionBuena {
  var property precioXUnidad = 3

  method costo(cant) = precioXUnidad * cant
}

object produccionRegular {

  method costo(cant) = pepe.importeUnitario()  * cant
}

object pepe {
  var property importeUnitario = 1
}

object produccionPremium {
  
  method costo(cant) = produccionBuena.precioXUnidad() * cant
}


// --------------------------------
// Impuestos

object impuesto {
    var tipoDeImpuesto = impuestoSimple

    method valorDeImpuesto(cant) = tipoDeImpuesto.valorDeImpuesto(cant)

    method cambioDeTipoImpuesto(nuevoImpuesto) {
        tipoDeImpuesto = nuevoImpuesto
    }
}

object impuestoSimple {
    var property porcentajeDeProduccion = 0.1

    method valorDeImpuesto(cant) = produccion.costo(cant) * porcentajeDeProduccion
}

object impuestoConGarantia {
    var property porcentajeDeProduccion = 0.05
  
    method valorDeImpuesto(cant) = (produccion.costo(cant) * porcentajeDeProduccion).min(100)
}

object impuestoDelPueblo {
    method valorDeImpuesto(cant) = 0
}

object impuestoCompuesto {
    const impuesto1 = impuestoSimple
    const impuesto2 = impuestoConGarantia

    method valorImpuesto(cant) = impuesto1.valorDeImpuesto(cant) + impuesto2.valorDeImpuesto(cant)
}

// --------------------------------
// DerechosDeExportacion

object derechoDeExportacion {
  var tipoDeDerecho = derechoEstatico

  method valorDerechoDeExportacion(cant) = tipoDeDerecho.valorDerechoDeExportacion(cant)

  method cambioDeDerecho(nuevoDerecho) {
    tipoDeDerecho = nuevoDerecho
  }
}

object derechoEstatico {
  
  method valorDerechoDeExportacion(cant) {
    if(produccion.costo(cant) > 1000) {
        return 200
    }
    else {
        return 300
    }
  }
}

object derechoPrivatizador {
  const montoBasico = 50
  const valorAdicional = 1

  method valorDerechoDeExportacion(cant) = montoBasico + valorAdicional * self.multiplicidadCultivada(cant)

  method multiplicidadCultivada(cant) = cant.div(10) 
}

object derechoDemagogico {
    var property valor = 100

    method valorDerechoDeExportacion(cant) = valor
}

object derechoNulo {
  method valorDerechoDeExportacion(cant) = 0
}