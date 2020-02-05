//
//  JsonParser.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 03/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class JsonParser: NSObject {
    private override init(){}
    
    public static func parse(metodo: String, parametros: String) -> NSArray{
        let urlStr:String = (DatosDeSesion.getInstance()?.webServer)! + metodo + "?" + parametros.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!;
        let url = URL(string: (urlStr));
        var data:Data;
        var json:NSArray = NSArray();
        do{
            data = try Data(contentsOf: url!);
            json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray;
        }catch let error1 as NSError{
            print(error1);
        }
        return json;
    }
}
