//
//  AgregarEditarPublicacionEmpresaViewController.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 09/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class AgregarEditarPublicacionEmpresaViewController: UIViewController {

    public var publicacion:Publicacion?;
    public var empresa:Empresa?;
    
    @IBOutlet weak var btnAgregarEditar: UIButton!
    @IBOutlet weak var tbxPrecio: UITextField!
    @IBOutlet weak var tbxTexto: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnAgregarEditarClick(_ sender: UIButton) {
        if publicacion == nil{
            publicacion = Publicacion();
            publicacion?.texto = tbxTexto.text;
            publicacion?.precio = (tbxPrecio.text! as NSString).doubleValue;
            let rs = JsonParser.parse(metodo: "postPublicacion.php", parametros: "texto=\((publicacion?.texto)!)&precio=\((publicacion?.precio)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)&empresa=\((empresa?.id)!)");
            let o = rs[0] as! NSDictionary;
            if o["rs"] as? String == "1"{
                let alerta = UIAlertController(title: "Info", message: "Publicación guardada exitosamente.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
                    self.navigationController?.popViewController(animated: true);
                }));
                self.present(alerta, animated: true, completion: nil);
            }else{
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al guardar la publicación.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alerta, animated: true, completion: nil);
                publicacion = nil;
            }
        }else{
            publicacion?.texto = tbxTexto.text;
            publicacion?.precio = (tbxPrecio.text! as NSString).doubleValue;
            let rs = JsonParser.parse(metodo: "putPublicacion.php", parametros: "texto=\((publicacion?.texto)!)&precio=\((publicacion?.precio)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)&id=\((publicacion?.id)!)");
            let o = rs[0] as! NSDictionary;
            if o["rs"] as? String == "1"{
                let alerta = UIAlertController(title: "Info", message: "Publicación editada exitosamente.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
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
        if  publicacion != nil{
            self.title = "Editar Publicación";
            btnAgregarEditar.setTitle("Editar", for: .normal);
            tbxTexto.text = publicacion?.texto;
            tbxPrecio.text = NSNumber(value: (publicacion?.precio)!).stringValue;
        }else{
            self.title = "Agregar Publicación";
            btnAgregarEditar.setTitle("Agregar", for: .normal);
        }
        super.viewWillAppear(true);
    }
    

}
