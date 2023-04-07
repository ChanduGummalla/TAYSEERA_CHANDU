//
//  SendingFromVC.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import UIKit



class SendingToVC: UIViewController {
    
    // Outlet Connections
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var conutryTableView: UITableView!
    
    var sendingCountryName = String()
    
    
    // Local properties
    var counryDeafultData = [PayingCountries]()
    var countryData = [PayingCountries]()
    var activityIndicatorView: ActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conutryTableView.register(UINib(nibName: "CountryTableCell", bundle: nil), forCellReuseIdentifier: "CountryTableCell")
        searchBar.showsCancelButton = true
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.getPayingCountryList()
        print(sendingCountryName)
    }
    
    //MARK:- Local Function
    func getPayingCountryList() {
        
        if (Reachability.isConnectedToNetwork()) {
            let params = ["payload":["pCountryId":244,"sCountryId":245,"systemId":19]]
            let urlString = APIConstnats.getsendingcountryconfig
            self.activityIndicatorView.startAnimating()
            APIHandler().postAPICall(paramters: params, urlString: urlString) { data in
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
                let jsonDecoder = JSONDecoder()
                let countryData = try? jsonDecoder.decode(CoutryModel.self, from: data as! Data)
                if let payCoutriesData = countryData?.payload?.result?[0].payingCountries {
                    self.countryData = payCoutriesData
                    self.counryDeafultData = payCoutriesData
                }
                
                DispatchQueue.main.async {
                    self.conutryTableView.reloadData()
                }
            }
        } else {
            self.showAlert(title: "Network Error", message: "Please check your internet connection...")
        }
    }
}

//MARK:- UITableViewDataSource,UITableViewDelegate
extension SendingToVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let countryCell = tableView.dequeueReusableCell(withIdentifier: "CountryTableCell") as? CountryTableCell else {
            return UITableViewCell()
        }
        let countryData = self.countryData[indexPath.row]
        countryCell.setupdataForPayingCountry(countryData: countryData, row: indexPath.row)
        countryCell.selectButtonCallback = { selectedRow in
            self.updateSelectedRow(selectedRow, countryData.isSelect as? Bool ?? false)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SendMoneyVC") as! SendMoneyVC
            vc.sendingCountryName = self.sendingCountryName
            vc.payingCountryName = self.countryData[indexPath.row].countryName ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return countryCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func updateSelectedRow(_ selectedRow: Int, _ isselected: Bool) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: selectedRow, section: 0)
            self.countryData[selectedRow].isSelect = !isselected
            DispatchQueue.main.async {
                self.conutryTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    
}

//MARK:- UISearchBarDelegate
extension SendingToVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            let filteredData  = self.countryData.filter { ($0.countryName as? String ?? "").contains(searchText)}
            self.countryData = filteredData
            print(filteredData)
        } else {
            // on click on close cursor
            self.countryData = self.counryDeafultData
            DispatchQueue.main.async {
                self.searchBar.resignFirstResponder()
                self.conutryTableView.reloadData()
            }
        }
        DispatchQueue.main.async {
            self.conutryTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty == false {
            let filteredData  = self.countryData.filter { ($0.countryName as? String ?? "").contains(searchBar.text ?? "")}
            self.countryData = filteredData
            print(filteredData)
        } else {
            self.countryData = self.counryDeafultData
            DispatchQueue.main.async {
                self.searchBar.resignFirstResponder()
                self.conutryTableView.reloadData()
            }
        }
        DispatchQueue.main.async {
            self.conutryTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.countryData = self.counryDeafultData
        DispatchQueue.main.async {
            self.conutryTableView.reloadData()
        }
    }
}
