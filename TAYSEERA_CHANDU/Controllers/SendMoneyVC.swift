//
//  SendMoneyVC.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import UIKit

class SendMoneyVC: UIViewController {

    @IBOutlet var purposeTextfield: UITextField!
    @IBOutlet var sendingCountryTextfield : UITextField!
    @IBOutlet var payingCountryTextfield : UITextField!
    @IBOutlet var amounttosendTextfield : UITextField!
    @IBOutlet var amounttoreceiveTextfield : UITextField!
    
    var pickerView = UIPickerView()
    var myItems = ["Family Expences", "Rent", "Study"]
    var sendingCountryName = String()
    var payingCountryName = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView = UIPickerView(frame: CGRect(x: 0, y: self.view.frame.size.height - 150, width: self.view.frame.size.width, height: 150))
        pickerView.backgroundColor = .groupTableViewBackground
        pickerView.dataSource = self
        pickerView.delegate = self
        purposeTextfield.delegate = self
        purposeTextfield.inputView = pickerView
       // self.view.addSubview(pickerView)
        sendingCountryTextfield.text = sendingCountryName
        payingCountryTextfield.text = payingCountryName
        amounttosendTextfield.delegate = self
        sendingCountryTextfield.isUserInteractionEnabled = false
        payingCountryTextfield.isUserInteractionEnabled = false
        amounttoreceiveTextfield.isUserInteractionEnabled = false
        self.amounttosendTextfield.addDoneCancelToolbar()
        
    }
    
    func doneButtonTappedForMyNumericTextField() {
        print("Done");
        amounttosendTextfield.resignFirstResponder()
        let text = self.amounttosendTextfield.text ?? ""
        self.amounttosendTextfield.text = "\(text) USD"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let calculatedMoney = Int(self.amounttosendTextfield.text ?? "")
            if (calculatedMoney == 0) {
                self.amounttosendTextfield.text = ""
            } else {
                self.amounttoreceiveTextfield.text = "\((calculatedMoney ?? 0) * 80) GBP"
            }
        }
    }
   
    @IBAction func onTapSendMoney(_ sender: UIButton) {
        
        
        guard self.amounttosendTextfield.text != "" else {
            self.showAlert(title: "Validation Error", message: "Please enter send amount")
            return
        }
        
        guard self.purposeTextfield.text != "" else {
            self.showAlert(title: "Validation Error", message: "Please select purpose")
            return
        }
       
        
        CoreDataManger().savedata(sendingCountry: self.sendingCountryTextfield.text ?? "", payingCountry: self.payingCountryTextfield.text ?? "", amountToSend: self.amounttosendTextfield.text ?? "", amountToReceiver: self.amounttoreceiveTextfield.text ?? "", purpose: self.purposeTextfield.text ?? "")
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SavedRecordsVC") as! SavedRecordsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - UITextFieldDelegate
extension SendMoneyVC: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == self.purposeTextfield) {
            pickerView.isHidden = false
            purposeTextfield.inputView = pickerView;
            self.view.addSubview(pickerView)
            return false
        }
        return true
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.amounttosendTextfield.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.amounttosendTextfield) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let calculatedMoney = Int(self.amounttosendTextfield.text ?? "")
                if (calculatedMoney == 0) {
                    self.amounttosendTextfield.text = ""
                } else {
                    self.amounttoreceiveTextfield.text = "\((calculatedMoney ?? 0) * 80) GBP"
                }
            }
        }
    }
}

// MARK: - UIPickerViewDelegate

extension SendMoneyVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myItems.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myItems[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        purposeTextfield.text = myItems[row]
        self.pickerView.isHidden = true
    }
}


