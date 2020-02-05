//
//  VerEmpresaViewController.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 05/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

private let cellCompra = "cellCompra";
private let cellVenta = "cellVenta";
private let publicacionesSegue = "publicacionesSegue";
private enum Secciones:Int{
    case COMPRAS = 0, VENTAS = 1;
}

private struct CompraAux{
    public var compra:Compra?;
    public var total:Double?;
};

private struct VentaAux{
    public var venta:SolicitudDeVenta?;
    public var total:Double?;
};

class VerEmpresaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableViewCompras: UITableView!
    @IBOutlet weak var tableViewVentas: UITableView!
    
    @IBOutlet weak var lblTotalGanancia: UILabel!
    @IBOutlet weak var lblTotalVentas: UILabel!
    @IBOutlet weak var lblTotalCompras: UILabel!
    private var comprasVentas:[NSMutableArray?]?;
    public var empresa:Empresa?;
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCompras.delegate = self;
        tableViewCompras.dataSource = self;
        tableViewVentas.delegate = self;
        tableViewVentas.dataSource = self;
        tableViewCompras.register(UITableViewCell.self, forCellReuseIdentifier: cellCompra);
        tableViewVentas.register(UITableViewCell.self, forCellReuseIdentifier: cellVenta);
        comprasVentas = [NSMutableArray(), NSMutableArray()];
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == publicacionesSegue{
            let dest = segue.destination as! PublicacionesEmpresaTableViewController;
            dest.empresa = empresa;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewVentas{
            return comprasVentas![1]!.count;
        }else{
            return comprasVentas![0]!.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseIdentifier:String;
        if(tableView == tableViewCompras){
            reuseIdentifier = cellCompra;
        }else{
            reuseIdentifier = cellVenta;
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath);
        
        if tableView == tableViewCompras {
            cell.textLabel?.text = "$" + NSNumber(value: (comprasVentas![0]!.object(at: indexPath.row) as! CompraAux).total!).stringValue;
        }else{
            cell.textLabel?.text = "$" + NSNumber(value: (comprasVentas![1]!.object(at: indexPath.row) as! VentaAux).total!).stringValue;
        }
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = empresa?.nombre;
        let rs = JsonParser.parse(metodo: "getComprasVentas.php", parametros: "empresa=\((empresa?.id)!)");
        comprasVentas![0]!.removeAllObjects();
        comprasVentas![1]!.removeAllObjects();
        var totalCompras:Double = 0.0;
        var totalVentas:Double = 0.0;
        for i in 0 ..< rs.count{
            let o = rs[i] as! NSDictionary;
            if o["tipo"] as? String == String(Secciones.COMPRAS.rawValue){
                var compra = CompraAux();
                compra.compra = Compra();
                compra.compra?.id = Int((o["compvta"] as? String)!)!;
                compra.total = (o["total"] as! NSString).doubleValue;
                comprasVentas![Secciones.COMPRAS.rawValue]!.add(compra);
                totalCompras += compra.total!;
            }else{
                var venta = VentaAux();
                venta.venta = SolicitudDeVenta();
                venta.venta?.id = Int((o["compvta"] as? String)!)!;
                venta.total = (o["total"] as! NSString).doubleValue;
                comprasVentas![Secciones.VENTAS.rawValue]!.add(venta);
                totalVentas += venta.total!;
            }
        }
        tableViewCompras.reloadData();
        tableViewVentas.reloadData();
        //Escribimos los label con la información adquirida..
        lblTotalCompras.text = "$" + NSNumber(value: totalCompras).stringValue;
        lblTotalVentas.text = "$" + NSNumber(value: totalVentas).stringValue;
        var pretextoGananciaTotal = "";
        if totalVentas - totalCompras < 0{
            pretextoGananciaTotal += "-";
        }
        pretextoGananciaTotal += "$";
        lblTotalGanancia.text = pretextoGananciaTotal + NSNumber(value: abs(totalVentas - totalCompras)).stringValue;
        super.viewWillAppear(true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
