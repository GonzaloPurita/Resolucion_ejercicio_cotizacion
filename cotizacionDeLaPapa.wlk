// --------------------------------
// Cotizadores

object cotizadorPapa {
  method importeTotal(cant) = produccion.costo(cant) + impuesto.valorDeImpuesto(cant) + derechoDeExportacion.valorDerechoDeExportacion(cant)
}

object cotizadorBatata {
  var property costoDeProduccion = 100
  var property impuesto = impuestoCompuesto

  method importeTotal(cant) = costoDeProduccion + impuesto.valorDeImpuesto(cant)
}

object cotizadorZapallo {
  method importeTotal(cant) = pepe.importeUnitario() * cant + derechoDeExportacion.valorDerechoDeExportacion(cant) / 2
}

// --------------------------------
// Producciones

object produccion {
  var tipoDeProduccion = produccionBuena
  //var property cant = 1

  method costo(cant) = tipoDeProduccion.importeUnitario() * cant

  method cambioDeTipo(nuevoTipo) {
    tipoDeProduccion = nuevoTipo
  }
}

object produccionBuena {
  method importeUnitario() = 3
}

object produccionRegular {
  method importeUnitario() = pepe.importeUnitario()
}

object pepe {
  method importeUnitario() = 1
}

object produccionPremium {
  method importeUnitario() = produccionBuena.importeUnitario() * 1.5
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

    method valorDeImpuesto(cant) = impuesto1.valorDeImpuesto(cant) + impuesto2.valorDeImpuesto(cant)
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