//
//  DetailTableViewCell.swift
//  AppGateTest
//
//  Created by Enar GoMez on 31/01/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateValues(date:String, location:String, status:Bool){
        self.lblDate.text = date
        self.lblLocation.text = location
        if status {
            self.lblStatus.textColor = .green
            self.lblStatus.text = "Exitoso"
        }else{
            self.lblStatus.textColor = .red
            self.lblStatus.text = "Denegado"
        }
        
    }
}
