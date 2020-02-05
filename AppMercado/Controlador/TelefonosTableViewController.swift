//
//  TelefonosTableViewController.swift
//  AppMercado
//
//  Created by Usuario invitado on 3/6/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

//Identificadores de los segue y de la celda reusable.
private let reuseIdentifier = "cell";
private let agregarTelefonoSegue = "agregarTelefonoSegue";
private let editarTelefonoSegue = "editarTelefonoSegue";

class TelefonosTableViewController: UITableViewController {

    private var telefonosList:NSMutableArray?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Registramos el prototipo de celda que está en la vista
        //para poder usarla más adelante..
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier);
        //Inicializamos el array de teléfonos..
        telefonosList = NSMutableArray();
    }

    //Solo va a tener 1 sección..
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    //El número de renglones = número de elementos en el array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (telefonosList?.count)!;
    }
    
    //Si seleccionan una celda, se realiza el segue de edición.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: editarTelefonoSegue, sender: tableView.cellForRow(at: indexPath));
    }
    
    //Función que prepara acciones antes de realizar la transición
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Si el segue es el de editar..
        if segue.identifier == editarTelefonoSegue{
            //Casteamos el destino y le mandamos el teléfono que seleccionó el usuario.
            let dest = segue.destination as! AgregarEditarUsuarioTelefonoViewController;
            dest.telefono = telefonosList?.object(at: tableView.indexPath(for: sender as! UITableViewCell)!.row) as? UsuarioTelefono;
        }
    }
    
    //Función que crea celdas para un indexPath dado..
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Desencolamos la celda..
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath);
        //La llenamos
        cell.textLabel?.text = (telefonosList?.object(at: indexPath.row) as! UsuarioTelefono).telefono;
        //La regresamos..
        return cell;
    }
    
    //Función que atrapa gestos para la tabla..
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //Si el gesto fue el de borrar..
        if editingStyle == .delete{
            //Llamamos el webservice para borrar al telefono.
            let rs = JsonParser.parse(metodo: "deleteUsuarioTelefono.php", parametros: "id=\(((telefonosList?.object(at: indexPath.row) as! UsuarioTelefono).id)!)");
            let o = rs[0] as! NSDictionary;
            //Si se pudo borrar con éxito..
            if o["rs"] as? String == "1"{
                //Lo borramos de la memoria
                telefonosList?.removeObject(at: indexPath.row);
                //Recargamos la tabla..
                tableView.reloadData();
            }else{
                //Si no se pudo borrar, mandamos alerta.
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al borrar el teléfono.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alerta, animated: true, completion: nil);
            }
        }
    }
    
    //Cuando la forma vaya a cargar..
    override func viewWillAppear(_ animated: Bool) {
        //Llamamos webservice para obtener teléfonos de los usuarios..
        let rs = JsonParser.parse(metodo: "getUsuariosTelefonos.php", parametros: "usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)");
        //Limpiamos todos los elemenots del array.
        telefonosList?.removeAllObjects();
        //Agregamos cada teléfono al array.
        for i in 0 ..< rs.count{
            let o = rs[i] as! NSDictionary;
            let tel = UsuarioTelefono();
            tel.id = Int((o["id"] as? String)!)!;
            tel.usuario = DatosDeSesion.getInstance()?.usuario;
            tel.telefono = o["telefono"] as? String;
            tel.sesion = Sesion();
            tel.sesion?.id = Int((o["sesion"] as? String)!)!;
            tel.fecha = Fecha(string: o["fecha"] as! NSString);
            telefonosList?.add(tel);
        }
        //Recargamos la tabla.
        tableView.reloadData();
        super.viewWillAppear(true);
    }

}
