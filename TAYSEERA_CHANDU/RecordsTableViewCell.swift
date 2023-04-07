//
//  RecordsTableViewCell.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {

    @IBOutlet var sendingCountryLabel: UILabel!
    @IBOutlet var payingCountryLabel: UILabel!
   
    @IBOutlet var amountTosendLabel: UILabel!
    
    @IBOutlet var amountToReceiverLabel: UILabel!
    @IBOutlet var purposeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(data: CountryData) {
        sendingCountryLabel.text = data.sendingCountry
        payingCountryLabel.text = data.payingCountry
        amountTosendLabel.text = data.amountToSend
        amountToReceiverLabel.text = data.amountToReceiver
        purposeLabel.text = data.purpose
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
