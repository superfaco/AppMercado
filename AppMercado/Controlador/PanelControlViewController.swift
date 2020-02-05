//
//  PanelControlViewController.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 02/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

//Constantes de los identificadores de los segue
private let cerrarSesionSegue = "cerrarSesionSegue";
private let configuracionSegue = "configuracionSegue";

class PanelControlViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Método sobrecargado para controlar las transiciones..
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //Si el usuario desea cerrar sesión..
        if identifier == cerrarSesionSegue{
            //Si se pudo cerrar la sesión..
            if (DatosDeSesion.getInstance()?.sesion?.cerrarSesion())! {
                //Limpiamos datos del singleton y regresamos true..
                DatosDeSesion.getInstance()?.sesion = nil;
                DatosDeSesion.getInstance()?.usuario = nil;
                return true;
            }else{
                //Si no se pudo cerrar, lanzamos alerta y regresamos false..
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al cerrar la sesión.", preferredStyle: .alert);
                
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                
                self.present(alerta, animated: true, completion: nil);
                return false;
            }
        } else if identifier == configuracionSegue{
            //Si el usuario quiere configurar, regresamos true..
            return true;
        }
        return false;
    }

}
