//
//  DetailViewController.swift
//  AppGateTest
//
//  Created by Enar GoMez on 30/01/22.
//

import UIKit

class DetailViewController: UIViewController {

    var user: String!
    var arrValidations:[Validation] = [Validation]()
    let dataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItems = nil;
        self.navigationItem.hidesBackButton = true
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setData()
        self.loadData()
    }
   
    func setData(){
        self.lblUser.text = self.user
    }

}

private extension DetailViewController {
    
    @IBAction func logoutAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadData() {
        dataManager.getValidationsByUser(userName: self.user) { (success, msg, arrData) in
            if success {
                self.arrValidations = arrData
                self.tableView.reloadData()
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrValidations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        let item = arrValidations[indexPath.row]
        let date = item.val_date!.description
        let location = "\(item.val_latitude)-\(item.val_longitude)"
    
        cell.updateValues(date: date, location: location, status: item.val_status)
        return cell
    }
    
}

extension DetailViewController: UITableViewDelegate {
}
