//
//  EmpresasTableViewController.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 05/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell";
private let verEmpresaSegue = "verEmpresaSegue";

class EmpresasTableViewController: UITableViewController {

    private var empresasList:NSMutableArray?;
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier);
        empresasList = NSMutableArray();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        let rs = JsonParser.parse(metodo: "getEmpresas.php", parametros: "usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)");
        empresasList?.removeAllObjects();
        for i in 0 ..< rs.count{
            let o = rs[i] as! NSDictionary;
            let empresa = Empresa();
            empresa.id = Int((o["id"] as? String)!)!;
            empresa.nombre = o["nombre"] as? String;
            empresa.direccion = o["direccion"] as? String;
            empresa.fecha = Fecha(string: o["fecha"] as! NSString );
            empresa.sesion = Sesion();
            empresa.sesion?.id = Int((o["sesion"] as? String)!)!;
            empresasList?.add(empresa);
        }
        tableView.reloadData();
        super.viewWillAppear(true);
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: verEmpresaSegue, sender: tableView.cellForRow(at: indexPath));
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == verEmpresaSegue{
            let dest = segue.destination as! VerEmpresaViewController;
            dest.empresa = (empresasList?.object(at:  tableView.indexPath(for: sender as! UITableViewCell)!.row) as! Empresa);
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (empresasList?.count)!;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath);
        cell.textLabel?.text = (empresasList?.object(at: indexPath.row) as! Empresa).nombre;
        return cell;
    }

}
