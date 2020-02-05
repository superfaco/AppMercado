//
//  CrearUsuarioViewController.swift
//  AppMercado
//
//  Created by Fernando Alfonso Caldera Olivas on 01/06/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

import UIKit

class CrearUsuarioViewController: UIViewController {

    //Outlets de la vista de crear usuario.
    @IBOutlet weak var tbxNombreCompleto: UITextField!
    
    @IBOutlet weak var tbxCorreoElectronico: UITextField!
    
    @IBOutlet weak var tbxTelefono: UITextField!
    
    @IBOutlet weak var tbxNombreUsuario: UITextField!
    
    @IBOutlet weak var tbxContraseña: UITextField!
    
    @IBOutlet weak var btnMostrarCaracteres: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //Funcion para mostrar u ocultar caracteres en el textbox
    //de contraseña..
    @IBAction func btnMostrarCaracteresClick(_ sender: UIButton) {
        tbxContraseña.isSecureTextEntry = !tbxContraseña.isSecureTextEntry;
        if tbxContraseña.isSecureTextEntry{
            btnMostrarCaracteres.setBackgroundImage(UIImage(named: "hide"), for: .normal);
        }else{
            btnMostrarCaracteres.setBackgroundImage(UIImage(named: "eye"), for: .normal);
        }
    }
    
    //Método que dice si existe un usuario utilizando su nombre de usuario.
    private func existeUsuario(usuario: Usuario?) -> Bool{
        let rs = JsonParser.parse(metodo: "getUsuario.php", parametros: "nombreUsuario=\((usuario?.nombreUsuario)!)");
        if rs.count > 0{
            let usu = rs[0] as! NSDictionary;
            usuario?.id = Int((usu["id"] as? String)!);
            usuario?.nombre = usu["nombre"] as? String;
            usuario?.fecha = Fecha(string: usu["fecha"] as! NSString);
            return true;
        }
        return false;
    }
    
    //Método que crea una sesion para el usuario dado..
    private func crearSesion(usuario: Usuario?) -> Sesion?{
        var rs = JsonParser.parse(metodo: "postSesion.php", parametros: "usuario=\((usuario?.id)!)");
        let o = rs[0] as! NSDictionary;
        var sesion:Sesion? = nil;
        if (o["rs"] as? String)! == "1"{
            rs = JsonParser.parse(metodo: "getSesion.php", parametros: "usuario=\((usuario?.id)!)");
            let ses = rs[0] as! NSDictionary;
            sesion = Sesion();
            sesion?.id = Int(ses["id"] as! String);
            sesion?.inicio = Fecha(string: ses["inicio"] as! NSString);
            sesion?.usuario = usuario;
        }
        return sesion;
    }
    
    //Método para registrar un usuario nuevo.
    private func registrarUsuario(usuario: Usuario?) -> Bool{
        //Llamamos el web service para crear un nuevo usuario..
        var rs = JsonParser.parse(metodo: "postUsuario.php", parametros: "nombre=\((usuario?.nombre)!)&nombreUsuario=\((usuario?.nombreUsuario)!)&contrasena=\((usuario?.contraseña)!)");
        let o = rs[0] as! NSDictionary;
        //Si se pudo insertar..
        if o["rs"] as! String == "1" {
            //Obtenemos el usuario recien creado con ayuda de su
            //nombre de usuario..
            rs = JsonParser.parse(metodo: "getUsuario.php", parametros: "nombreUsuario=\((usuario?.nombreUsuario)!)");
            let usu = rs[0] as! NSDictionary;
            //Llenamos el id del usuario, le creamos una sesion y guardamos ambos
            //en el singleton.
            //Regresamos true.
            usuario?.id = Int((usu["id"] as? String)!)!;
            DatosDeSesion.getInstance()?.usuario = usuario;
            DatosDeSesion.getInstance()?.sesion = crearSesion(usuario: usuario);
            return true;
        }else{
            return false;
        }
    }
    
    //Función para registrar telefonos.
    private func registrarTelefono(telefono: UsuarioTelefono?) -> Bool{
        //Llamamos el webservice para ver si no existen..
        var rs = JsonParser.parse(metodo: "getUsuarioTelefono.php", parametros: "telefono=\((telefono?.telefono)!)&usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)");
        //Si no existen..
        if(rs.count == 0){
            //Llamamos el webservice para insertarlo.
            rs = JsonParser.parse(metodo: "postUsuarioTelefono.php", parametros: "telefono=\((telefono?.telefono)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)&usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)");
            let o = rs[0] as! NSDictionary;
            //Si ocurrieron errores, regresamos false..
            if o["rs"] as? String == "0" {
                return false;
            }
        }
        //Regresamos true.
        return true;
    }
    
    //Función para crear correos.
    private func registrarCorreo(correo: UsuarioCorreo?) -> Bool{
        //Llamamos el webservice para ver si no esta registrado el correo..
        var rs = JsonParser.parse(metodo: "getUsuarioCorreo.php", parametros: "correo=\((correo?.correo)!)&usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)");
        var o:NSDictionary;
        //Si no está registrado..
        if rs.count == 0{
            //Lo insertamos..
            rs = JsonParser.parse(metodo: "postUsuarioCorreo.php", parametros: "correo=\((correo?.correo)!)&sesion=\((DatosDeSesion.getInstance()?.sesion?.id)!)&usuario=\((DatosDeSesion.getInstance()?.usuario?.id)!)");
            o = rs[0] as! NSDictionary;
            //Si hubo errores, regresamos false..
            if o["rs"] as? String == "0"{
                return false;
            }
        }
        return true;
    }
    
    //Función del boton para registrar un nuevo usuario..
    @IBAction func btnRegistrarClick(_ sender: UIButton) {
        //Creamos usuario y lo llenamos
        let usuario:Usuario? = Usuario();
        usuario?.nombre = tbxNombreCompleto.text;
        usuario?.nombreUsuario = tbxNombreUsuario.text;
        usuario?.contraseña = Encriptador.encriptar(cadena: tbxContraseña.text! as NSString);
        
        //Creamos correo y lo llenamos
        let correo:UsuarioCorreo? = UsuarioCorreo();
        correo?.correo = tbxCorreoElectronico.text;
        
        //Creamos teléfono y lo llenamos
        let telefono:UsuarioTelefono? = UsuarioTelefono();
        telefono?.telefono = tbxTelefono.text;
        
        //Si ya existe el usuario, mandamos alerta
        if existeUsuario(usuario: usuario) {
            let alerta = UIAlertController(title: "Error", message: "El nombre de usuario ya existe.", preferredStyle: .alert);
            alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            
            self.present(alerta, animated: true, completion: nil);
        }else{
            //Si no existe y se pudo registrar con éxito el usuario, el teléfono, el
            //correo y se pudo cerrar la sesión con éxito..
            if registrarUsuario(usuario: usuario) && registrarTelefono(telefono: telefono) && registrarCorreo(correo: correo) && (DatosDeSesion.getInstance()?.sesion?.cerrarSesion())! {
                
                //Limpiamos los datos del singleton.
                DatosDeSesion.getInstance()?.usuario = nil;
                DatosDeSesion.getInstance()?.sesion = nil;
                
                //Mandamos alerta de éxito y llevamos al usuario a la ventana anterior.
                let alerta = UIAlertController(title: "Info", message: "El usuario se ha registrado con éxito.", preferredStyle: .alert);
                
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(UIAlertAction) -> Void in
                    self.navigationController?.popToRootViewController(animated: true);
                }));
                
                self.present(alerta, animated: true, completion:nil);
                
            }else{
                //Si cualquier cosa fallo, mandamos error
                let alerta = UIAlertController(title: "Error", message: "Ocurrió un error al registrar al usuario.", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                
                self.present(alerta, animated: true, completion: nil);
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
