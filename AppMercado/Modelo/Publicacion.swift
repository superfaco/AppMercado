//
//  Publicacion.swift
//  AppMercado
//
//  Created by Usuario invitado on 3/6/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class Publicacion: NSObject {
    public var id:Int?;
    public var texto:String?;
    public var precio:Double?;
    public var borrado:Bool?;
    public var fecha:Fecha?;
    public var empresa:Empresa?;
    public var sesion:Sesion?;
}
