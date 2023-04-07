//
//  CountryTableCell.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import UIKit
import SDWebImage

class CountryTableCell: UITableViewCell {

    @IBOutlet var countryImageView: UIImageView!
    @IBOutlet var selectRowButton: UIButton!
    @IBOutlet var countryNameLabel: UILabel!
    var selectButtonCallback:((_ buttonTag: Int) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupdata(countryData: CountryResults, row: Int) {
        let name = countryData.countryName ?? ""
        selectRowButton.tag = row
        let image = countryData.isSelect ?? false ? UIImage(named: "radio-check") : UIImage(named: "radio-uncheck")
        self.selectRowButton.setImage(image, for: .normal)
        countryImageView.sd_setImage(with: URL(string: countryData.flagUrl ?? ""), placeholderImage: UIImage(named: "india"))
        countryNameLabel.text = name
    }
    
    func setupdataForPayingCountry(countryData: PayingCountries, row: Int) {
        let name = countryData.countryName ?? ""
        selectRowButton.tag = row
        let image = countryData.isSelect ?? false ? UIImage(named: "radio-check") : UIImage(named: "radio-uncheck")
        self.selectRowButton.setImage(image, for: .normal)
        countryImageView.sd_setImage(with: URL(string: countryData.flagUrl ?? ""), placeholderImage: UIImage(named: "india"))
        countryNameLabel.text = name
    }

    @IBAction func onTapSelectRow(_ sender: UIButton) {
        selectButtonCallback?(sender.tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
