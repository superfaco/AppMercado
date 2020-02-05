//
//  DatosDeSesion.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 01/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

//Singleton para guardar los datos de sesion en toda la aplicacion.
class DatosDeSesion: NSObject {
    private static var instance:DatosDeSesion?;
    //Usuario en sesion (que ya viene dentro de la sesion).
    public var usuario:Usuario?;
    //La Sesión del usuario..
    public var sesion:Sesion?;
    //Constante del host y URL donde están los WebServices
    public let webServer = "http://192.168.1.70:8081/appmercado/";
    
    public static func getInstance() -> DatosDeSesion?{
        if instance == nil {
            instance = DatosDeSesion();
        }
        return instance;
    }
    
    private override init(){
        
    }
}
