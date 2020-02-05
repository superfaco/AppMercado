//
//  ConfiguracionViewController.swift
//  AppMercado
//
//  Created by Usuario invitado on 3/6/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class ConfiguracionViewController: UIViewController {

    //Outlets de la vista..
    @IBOutlet weak var tbxNombre: UITextField!
    @IBOutlet weak var btnEditar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    //Funcion click del botón de editar nombre..
    @IBAction func btnEditarClick(_ sender: UIButton) {
        //Se niega la bandera..
        tbxNombre.isEnabled = !tbxNombre.isEnabled;
        //Si está habilitada..
        if tbxNombre.isEnabled{
            //Hacemos focus
            tbxNombre.becomeFirstResponder();
            //Cambiamos la imagen del botón.
            btnEditar.setBackgroundImage(UIImage(named: "check"), for: .normal);
        }else{
            //Si no está..
            //Cambiamos la imagen del botón.
            btnEditar.setBackgroundImage(UIImage(named: "pencil"), for: .normal);
            //Obtenemos el nuevo nombre
            let nombre = tbxNombre.text;
            //Llamamos al webservice para actualizarlo
            let rs = JsonParser.parse(metodo: "putUsuario.php", parametros: "id=\((DatosDeSesion.getInstance()?.usuario?.id)!)&nombre=\((nombre)!)");
            let o = rs[0] as! NSDictionary;

            //Si se actualizó con éxito..
            if o["rs"] as? String == "1"{
                //Mandamos alerta informativa y actualizamos el nombre en el usuario
                //En sesion..
                let alerta = UIAlertController(title: "Info", message: "Nombre actualizado con éxito.", preferredStyle: .alert);
                
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                
                self.present(alerta, animated: true, completion: nil);
                DatosDeSesion.getInstance()?.usuario?.nombre = nombre;
            }else{
                //Si no se pudo actualizar con éxito..
                //Mandamos alerta y restauramos el nombre en sesión.
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al actualizar el nombre.", preferredStyle: .alert);
                
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                
                self.present(alerta, animated: true, completion: nil);
                tbxNombre.text = DatosDeSesion.getInstance()?.usuario?.nombre;
            }
        }
    }
    
    //Cuando vaya a aparecer la vista, establecemos el texto
    //del textbox al del usuario en sesión.
    override func viewWillAppear(_ animated: Bool) {
        tbxNombre.text = DatosDeSesion.getInstance()?.usuario?.nombre;
        super.viewWillAppear(true);
    }
    
}
