//
//  Fecha.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 01/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class Fecha: NSObject {
    public var dia:Int?;
    public var mes:Int?;
    public var año:Int?;
    public var hora:Int?;
    public var minuto:Int?;
    public var segundo:Int?;
    
    override init(){
        
    }
    
    convenience init(string: NSString){
        self.init();
        año = Int(string.substring(with: NSRange(location: 0, length: 4)));
        mes = Int(string.substring(with: NSRange(location: 5, length: 2)));
        dia = Int(string.substring(with: NSRange(location: 8, length: 2)));
        hora = Int(string.substring(with: NSRange(location: 11, length: 2)));
        minuto = Int(string.substring(with: NSRange(location: 14, length: 2)));
        segundo = Int(string.substring(with: NSRange(location: 17, length: 2)));
    }
    
    override var description: String{
        var h:String = "";
        var m:String = "";
        var s:String = "";
        if hora! < 10{
            h = "0";
        }
        if minuto! < 10{
            m = "0";
        }
        if segundo! < 10{
            s = "0";
        }
        return "\(año as Optional)-\(mes as Optional)-\(dia as Optional) \(h)\(hora as Optional):\(m)\(minuto as Optional):\(s)\(segundo as Optional)";
    }
    
}
