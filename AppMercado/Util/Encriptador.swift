//
//  Encriptador.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 03/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class Encriptador: NSObject {
    private override init(){}
    
    public static func encriptar(cadena: NSString) -> String{
        var s:String = "";
        for i in 0 ..< cadena.length{
            s += "\(((cadena.character(at: i) + 70) % 100) + 97)";
        }
        return s;
    }
}
