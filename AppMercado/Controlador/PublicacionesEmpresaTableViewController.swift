//
//  PublicacionesEmpresaTableViewController.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 09/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell";
private let agregarPublicacionSegue = "agregarPublicacionSegue";
private let editarPublicacionSegue = "editarPublicacionSegue";
class PublicacionesEmpresaTableViewController: UITableViewController {

    public var empresa:Empresa?;
    public var publicacionesList:NSMutableArray?;
    override func viewDidLoad() {
        super.viewDidLoad()
        publicacionesList = NSMutableArray();
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: editarPublicacionSegue, sender: tableView.cellForRow(at: indexPath));
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == editarPublicacionSegue{
            let dest = segue.destination as! AgregarEditarPublicacionEmpresaViewController;
            dest.publicacion = publicacionesList!.object(at: (tableView.indexPath(for: sender as! UITableViewCell)?.row)!) as? Publicacion;
        }
        let dest = segue.destination as! AgregarEditarPublicacionEmpresaViewController;
        dest.empresa = empresa;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath);
        cell.textLabel?.text = (publicacionesList!.object(at: indexPath.row) as! Publicacion).texto;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let rs = JsonParser.parse(metodo: "deletePublicacion.php", parametros: "id=\(((publicacionesList!.object(at: indexPath.row) as! Publicacion).id)!)");
            let o = rs[0] as! NSDictionary;
            if o["rs"] as? String == "1"{
                publicacionesList?.removeObject(at: indexPath.row);
                tableView.reloadData();
            }else{
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al eliminar la publicación.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alerta, animated: true, completion: nil);
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rs = JsonParser.parse(metodo: "getPublicacionesEmpresa.php", parametros: "empresa=\((empresa?.id)!)");
        publicacionesList!.removeAllObjects();
        for i in 0 ..< rs.count{
            let pub = Publicacion();
            let o = rs[i] as! NSDictionary;
            pub.id = Int((o["id"] as? String)!)!;
            pub.texto = o["texto"] as? String;
            pub.precio = (o["precio"] as! NSString).doubleValue;
            pub.sesion = Sesion();
            pub.sesion?.id = Int((o["sesion"] as? String)!)!;
            pub.fecha = Fecha(string: o["fecha"] as! NSString);
            pub.borrado = false;
            pub.empresa = empresa;
            publicacionesList!.add(pub);
        }
        tableView.reloadData();
        super.viewWillAppear(true);
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return publicacionesList!.count;
    }

}
