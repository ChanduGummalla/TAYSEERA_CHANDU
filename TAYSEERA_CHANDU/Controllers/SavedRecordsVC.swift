//
//  SavedRecordsVC.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import UIKit

class SavedRecordsVC: UIViewController {
    @IBOutlet var recordsTableView: UITableView!

    var savedRecords = [CountryData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //"RecordsTableViewCell"
        recordsTableView.register(UINib(nibName: "RecordsTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordsTableViewCell")
        self.savedRecords =  CoreDataManger().fetchdata()
       
    }
    


}

//MARK:- UITableViewDataSource,UITableViewDelegate
extension SavedRecordsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recordsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecordsTableViewCell") as? RecordsTableViewCell else {
            return UITableViewCell()
        }
        let data = self.savedRecords[indexPath.row]
        recordsTableViewCell.updateData(data: data)
        return recordsTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
