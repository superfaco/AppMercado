//
//  SolicitudDeVenta.swift
//  AppMercado
//
//  Created by Usuario invitado on 3/6/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class SolicitudDeVenta: NSObject {
    public var id:Int?;
    public var fechaSolicitud:Fecha?;
    public var empresaSolicitante:Empresa?;
    public var empresaAutorizadora:Empresa?;
    public var precio: Double?;
    public var publicacion:Publicacion?;
    public var solicitudDeVentaAutorizada:SolicitudDeVentaAutorizada?;
}
