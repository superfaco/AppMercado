//
//  LoginViewController.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 01/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

//Constantes de los identificadores de los segue
private let ingresarSegue = "ingresarSegue";
private let crearUsuarioSegue = "crearUsuarioSegue";

class LoginViewController: UIViewController {

    //Outlets mapeados de la forma
    @IBOutlet weak var tbxUsuario: UITextField!
    @IBOutlet weak var tbxContraseña: UITextField!
    @IBOutlet weak var btnMostrarCaracteres: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Funcion que nos dice si existe un usuario para el inicio de sesion.
    private func existeUsuario(usuario: Usuario?)   -> Bool{
        //Obtenemos el usuario por su nombre de usuario.
        let rs = JsonParser.parse(metodo: "getUsuario.php", parametros: "nombreUsuario=\((usuario?.nombreUsuario)!)");
        //Si existe un usuario con ese nombre de usuario..
        if rs.count > 0{
            //Verificamos que las contraseñas coincidan, si no
            //coinciden, regresamos false.
            let usu = rs[0] as! NSDictionary;
            if usu["contrasena"] as? String != usuario?.contraseña!{
                return false;
            }else{
                //Las contraseñas coinciden, llenamos los datos de usuario
                //que nos pasaron y regresamos true
                usuario?.id = Int((usu["id"] as? String)!);
                usuario?.nombre = usu["nombre"] as? String;
                usuario?.fecha = Fecha(string: usu["fecha"] as! NSString);
                return true;
            }
        }
        return false;
    }
    
    //Funcion que crea una sesion nueva para el usuario que nos den
    private func crearSesion(usuario: Usuario?) -> Sesion?{
        //Tratamos de crear una nueva sesion
        var rs = JsonParser.parse(metodo: "postSesion.php", parametros: "usuario=\((usuario?.id)!)");
        let o = rs[0] as! NSDictionary;
        var sesion:Sesion? = nil;
        //Si el resultado fue positivo..
        if (o["rs"] as? String)! == "1"{
            //Obtenemos los datos de la sesion recien creada para el usuario
            //(La ultima sesion creada tiene fecha final = NULL)
            rs = JsonParser.parse(metodo: "getSesion.php", parametros: "usuario=\((usuario?.id)!)");
            //Llenamos los datos de la sesion
            let ses = rs[0] as! NSDictionary;
            sesion = Sesion();
            sesion?.id = Int(ses["id"] as! String);
            sesion?.inicio = Fecha(string: ses["inicio"] as! NSString);
            //Le asignamos el usuario de la sesion igual al usuario que nos mandaron.
            sesion?.usuario = usuario;
        }
        //Regresamos la sesion.
        return sesion;
    }
    
    //Boton para mostrar u ocultar los caracteres en el
    //textbox de contraseña
    @IBAction func btnMostrarCaracteresClick(_ sender: UIButton) {
        //Cambiamos la bandera a su negativo
        tbxContraseña.isSecureTextEntry = !tbxContraseña.isSecureTextEntry;
        //Si la bandera es verdadera, mostramos una imagen para el boton,
        //si no, mostramos otra.
        if tbxContraseña.isSecureTextEntry{
            btnMostrarCaracteres.setBackgroundImage(UIImage(named: "hide"), for: .normal);
        }else{
            btnMostrarCaracteres.setBackgroundImage(UIImage(named: "eye"), for: .normal);
        }
    }
    
    //Metodo que sirve para poder controlar las transiciones de una vista a otra.
    //Aquí, podemos decirle a la app si debe realizar la transición especificada
    //en la vista o no.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //Si el identificador del segue es para ingresar...
        if identifier == ingresarSegue  {
            //Creamos usuario y lo llenamos con los datos de la vista.
            let usuario:Usuario? = Usuario();
            usuario?.nombreUsuario = tbxUsuario.text;
            usuario?.contraseña = Encriptador.encriptar(cadena: tbxContraseña.text! as NSString );
            //Verificamos que exista..
            if existeUsuario(usuario: usuario) {
                //Si existe, creamos una nueva sesion para el usuario y
                //guardamos al usuario y a la sesion en el singleton.
                //Regresamos true..
                DatosDeSesion.getInstance()?.usuario = usuario;
                let sesion = crearSesion(usuario: usuario);
                if sesion != nil{
                    DatosDeSesion.getInstance()?.sesion = sesion;
                    return true;
                }else{
                    //Si no se pudo crear la sesion, mandamos alerta y regresamos false.
                    let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al iniciar sesión.", preferredStyle: .alert);
                    
                    alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                    
                    self.present(alerta, animated: true, completion: nil);
                    return false;
                }
            }else{
                //Si no existe el usuario, mandamos alerta y regresamos false.
                let alerta = UIAlertController(title: "Error", message: "Nombre de usuario o contraseña incorrectos.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alerta, animated: true, completion: nil);
                return false;
            }
        }else if identifier == crearUsuarioSegue {
            //Si el segue es para crear usuarios, regresamos true.
            return true;
        }
        return false;
    }
    
}
