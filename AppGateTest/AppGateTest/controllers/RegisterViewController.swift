//
//  RegisterViewController.swift
//  AppGateTest
//
//  Created by Enar GoMez on 30/01/22.
//

import UIKit



class RegisterViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    private let dataManager = DataManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }      
    
}

private extension RegisterViewController {
    @IBAction func registerAction(_ sender: Any) {
        if let username = txtUserName.text {
            if let password = txtPassword.text {
            
                guard Utils.isValidEmail(username) else {
                    Utils.showMessage(self, "El nombre usuario no es valido")
                    return
                }
                
                guard Utils.isValidPassword(password) else {
                    Utils.showMessage(self, "El password no corresponde con el formato")
                    return
                }                
                
                dataManager.registerUser(userName: username, password: password) { (successs, msg) in
                    if successs {
                        Utils.showMessage(self, "Usuario registrado")
                    }else{
                        Utils.showMessage(self, msg)
                        self.navigationController?.popViewController(animated: false)
                    }
                }
            }
        }
    }
}
