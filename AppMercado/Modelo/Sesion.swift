//
//  Sesion.swift
//  AppMercado
//
//  Created by Usuario invitado on 3/6/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class Sesion: NSObject {
    public var id:Int?;
    public var inicio:Fecha?;
    public var fin:Fecha?;
    public var usuario:Usuario?;
    
    //Método para cerrar esta sesion.
    public func cerrarSesion() -> Bool{
        //Llamamos el webservice
        let rs = JsonParser.parse(metodo: "putSesion.php", parametros: "id=\((DatosDeSesion.getInstance()?.sesion?.id)!)");
        //Obtenemos el json que nos da (arreglo de jsons), obtenemos el primero
        let o = rs[0] as! NSDictionary;
        //Verificamos si pudo actualizar la sesion o no.
        if o["rs"] as? String == "0"{
            return false;
        }
        return true;
    }
}
