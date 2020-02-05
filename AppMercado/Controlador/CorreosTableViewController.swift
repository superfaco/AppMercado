//
//  CorreosTableViewController.swift
//  AppMercado
//
//  Created by Usuario invitado on 3/6/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

private let agregarCorreoSegue = "agregarCorreoSegue";
private let editarCorreoSegue = "editarCorreoSegue";
private let reuseIdentifier = "cell";

class CorreosTableViewController: UITableViewController {

    private var correosList:NSMutableArray?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier);
        correosList = NSMutableArray();
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (correosList?.count)!;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath);
        cell.textLabel?.text = (correosList?.object(at: indexPath.row) as! UsuarioCorreo).correo;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: editarCorreoSegue, sender: tableView.cellForRow(at: indexPath));
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == editarCorreoSegue{
            let dest = segue.destination as! AgregarEditarUsuarioCorreoViewController;
            dest.correo = (correosList?.object(at: tableView.indexPath(for: sender as! UITableViewCell)!.row) as! UsuarioCorreo);
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let rs = JsonParser.parse(metodo: "deleteUsuarioCorreo.php", parametros: "id=\(((correosList?.object(at: indexPath.row) as! UsuarioCorreo).id)!)");
            let o = rs[0] as! NSDictionary;
            if o["rs"] as? String == "1"{
                correosList?.removeObject(at: indexPath.row);
                tableView.reloadData();
            }else{
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al eliminar el correo.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alerta, animated: true, completion: nil);
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rs = JsonParser.parse(metodo: "getUsuariosCorreos.php", parametros: "usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)");
        correosList?.removeAllObjects();
        for i in 0 ..< rs.count{
            let o = rs[i] as! NSDictionary;
            let correo:UsuarioCorreo = UsuarioCorreo();
            correo.id = Int((o["id"] as? String)!)!;
            correo.correo = o["correo"] as? String;
            correo.fecha = Fecha(string: o["fecha"] as! NSString);
            correo.sesion = Sesion();
            correo.sesion?.id = Int((o["sesion"] as? String)!)!;
            correo.usuario = DatosDeSesion.getInstance()?.usuario;
            correosList?.add(correo);
        }
        tableView.reloadData();
        super.viewWillAppear(true);
    }

}
