//
//  AgregarEditarUsuarioTelefonoViewController.swift
//  AppMercado
//
//  Created by Usuario invitado on 4/6/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class AgregarEditarUsuarioTelefonoViewController: UIViewController {

    public var telefono:UsuarioTelefono?;
    
    @IBOutlet weak var btnAgregarEditar: UIButton!
    @IBOutlet weak var tbxTelefono: UITextField!
    
    @IBAction func btnAgregarEditarClick(_ sender: UIButton) {
        if telefono == nil{
            telefono = UsuarioTelefono();
            telefono?.telefono = tbxTelefono.text;
            let rs = JsonParser.parse(metodo: "postUsuarioTelefono.php", parametros: "telefono=\((telefono?.telefono)!)&usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)");
            let o = rs[0] as! NSDictionary;
            if o["rs"] as? String == "1"{
                let alerta = UIAlertController(title: "Info", message: "Teléfono agregado con éxito.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                    self.navigationController?.popViewController(animated: true);
                }));
                self.present(alerta, animated: true, completion: nil);
            }else{
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al guardar el teléfono.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alerta, animated: true, completion: nil);
                telefono = nil;
            }
        }else{
            telefono?.telefono = tbxTelefono.text;
            let rs = JsonParser.parse(metodo: "putUsuarioTelefono.php", parametros: "telefono=\((telefono?.telefono)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)&id=\((telefono?.id)!)");
            let o = rs[0] as! NSDictionary;
            if o["rs"] as? String == "1"{
                let alerta = UIAlertController(title: "Info", message: "Teléfono modificado con éxito.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                    self.navigationController?.popViewController(animated: true);
                }));
                self.present(alerta, animated: true, completion: nil);
            }else{
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al guardar los cambios.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alerta, animated: true, completion: nil);
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if telefono == nil{
            self.title = "Agregar Teléfono";
            btnAgregarEditar.setTitle("Agregar", for: .normal);
        }else{
            self.title = "Editar Teléfono";
            btnAgregarEditar.setTitle("Editar", for: .normal);
            tbxTelefono.text = telefono?.telefono;
        }
        super.viewWillAppear(true);
    }

}
