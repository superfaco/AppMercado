//
//  AgregarEditarUsuarioCorreoViewController.swift
//  AppMercado
//
//  Created by Usuario invitado on 4/6/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class AgregarEditarUsuarioCorreoViewController: UIViewController {

    public var correo:UsuarioCorreo?;
    
    @IBOutlet weak var btnAgregarEditarCorreo: UIButton!
    @IBOutlet weak var tbxCorreo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAgregarEditarCorreoClick(_ sender: UIButton) {
        if correo == nil{
            correo = UsuarioCorreo();
            correo?.correo = tbxCorreo.text;
            let rs = JsonParser.parse(metodo: "postUsuarioCorreo.php", parametros: "correo=\((correo?.correo)!)&usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)");
            let o = rs[0] as! NSDictionary;
            if o["rs"] as? String == "1"{
                let alerta = UIAlertController(title: "Info", message: "Correo agregado con éxito.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                    self.navigationController?.popViewController(animated: true);
                }));
                self.present(alerta, animated: true, completion: nil);
            }else{
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al guardar el correo.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alerta, animated: true, completion: nil);
                correo = nil;
            }
        }else{
            correo?.correo = tbxCorreo.text;
            let rs = JsonParser.parse(metodo: "putUsuarioCorreo.php", parametros: "correo=\((correo?.correo)!)&id=\((correo?.id)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)");
            let o = rs[0] as! NSDictionary;
            if o["rs"] as? String == "1"{
                let alerta = UIAlertController(title: "Info", message: "Correo modificado con éxito.", preferredStyle: .alert);
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
    override func viewWillAppear(_ animated: Bool) {
        if correo == nil{
            self.title = "Agregar Correo";
            btnAgregarEditarCorreo.setTitle("Agregar", for: .normal);
            
        }else{
            self.title = "Editar Correo";
            btnAgregarEditarCorreo.setTitle("Editar", for: .normal);
            tbxCorreo.text = correo?.correo;
        }
        super.viewWillAppear(true);
    }

}
