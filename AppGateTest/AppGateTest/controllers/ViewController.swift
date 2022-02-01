//
//  ViewController.swift
//  AppGateTest
//
//  Created by Enar GoMez on 29/01/22.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //data
    let dataManager = DataManager()
    
    //data service
    let dateService = DateApiService()
    
    //location
    let locationManager = CLLocationManager()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLocation()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.user = self.txtUserName.text
            let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            navigationItem.backBarButtonItem = backButton
        }
    }

}

private extension ViewController {
    
    @IBAction func loginAction(btn: UIButton){
        if let username = txtUserName.text {
            if let password = txtPassword.text {
            
                guard Utils.isValidEmail(username) else {
                    Utils.showMessage(self, "Por favor Ingrese un nombre usuario valido")
                    return
                }
                
                dateService.fetchRequest(latitude: self.latitude, longitude: self.longitude) { (success, data) in
                    
                    let currentDate:Date
                    if success {
                        currentDate = Utils.getDateFrom(data!.time)
                    }else{
                        currentDate = Date()
                    }
                    
                    self.dataManager.registerValidation(userName: username, password: password, latitude: self.latitude, longitude: self.longitude, date: currentDate, json: "") { (success, msg) in
                        if success {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "gotoDetailVC", sender: nil)
                            }
                            
                        }else{
                            //show error
                            DispatchQueue.main.async {
                                Utils.showMessage(self, msg)
                            }
                        }
                        
                    }
                }
                
                
            }
        }
    }
    
    @IBAction func registerAction(btn: UIButton){
        self.performSegue(withIdentifier: "gotoRegister", sender: nil)
    }
}

//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func startLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse {
               locationManager.requestLocation()
           }
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
