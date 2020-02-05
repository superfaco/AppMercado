//
//  AgregarEmpresaViewController.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 05/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class AgregarEmpresaViewController: UIViewController {

    
    @IBOutlet weak var tbxNombre: UITextField!
    @IBOutlet weak var tbxDireccion: UITextField!
    private var empresa:Empresa?;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnAgregarClick(_ sender: UIButton) {
        empresa = Empresa();
        empresa?.nombre = tbxNombre.text;
        empresa?.direccion = tbxDireccion.text;
        let rs = JsonParser.parse(metodo: "postEmpresa.php", parametros: "nombre=\((empresa?.nombre)!)&direccion=\((empresa?.direccion)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)");
        let o = rs[0] as! NSDictionary;
        if o["rs"] as? String == "1"{
            let alerta = UIAlertController(title: "Info", message: "Empresa agregada con éxito.", preferredStyle: .alert);
            alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                self.navigationController?.popViewController(animated: true);
            }));
            self.present(alerta, animated: true, completion: nil);
        }else{
            let alerta = UIAlertController(title: "Error", message: "Error al agregar la empresa.", preferredStyle: .alert);
            alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alerta, animated: true, completion: nil);
            empresa = nil;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
