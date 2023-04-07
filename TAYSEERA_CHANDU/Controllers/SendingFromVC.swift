//
//  SendingFromVC.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import UIKit

class SendingFromVC: UIViewController {
    
    // Outlet Connections
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var conutryTableView: UITableView!
    
    // Local properties
    var counryDeafultData = [CountryResults]()
    var countryData = [CountryResults]()
    var activityIndicatorView: ActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conutryTableView.register(UINib(nibName: "CountryTableCell", bundle: nil), forCellReuseIdentifier: "CountryTableCell")
        searchBar.showsCancelButton = true
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        self.activityIndicatorView = ActivityIndicatorView(title: "Loading...", center: self.view.center)
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.getCountryList()
    }
    
    //MARK:- Local Function
    func getCountryList() {
        
        if (Reachability.isConnectedToNetwork()) {
            let params = ["payload":["systemId":19]]
            let urlString = APIConstnats.getsendingcountries
            self.activityIndicatorView.startAnimating()
            APIHandler().postAPICall(paramters: params, urlString: urlString) { data in
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
                let jsonDecoder = JSONDecoder()
                let countryData = try? jsonDecoder.decode(CoutryModel.self, from: data as! Data)
                if let countryResults = countryData?.payload?.result {
                    self.countryData = countryResults
                    self.counryDeafultData = countryResults
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
extension SendingFromVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let countryCell = tableView.dequeueReusableCell(withIdentifier: "CountryTableCell") as? CountryTableCell else {
            return UITableViewCell()
        }
        let countryData = self.countryData[indexPath.row]
        countryCell.setupdata(countryData: countryData, row: indexPath.row)
        countryCell.selectButtonCallback = { selectedRow in
            self.updateSelectedRow(selectedRow, countryData.isSelect as? Bool ?? false)
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
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "SendingToVC") as! SendingToVC
                vc.sendingCountryName = self.countryData[selectedRow].countryName ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(countryData[indexPath.row])
        //
        //        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //        let sendingtoVC = storyBoard.instantiateViewController(withIdentifier: "SendingToVC") as! SendingToVC
        //        sendingtoVC.sendingtoArray = (countryData[indexPath.row] as? [String:Any])!
        //
        //        self.navigationController?.pushViewController(sendingtoVC, animated: true)
    }
    
    
}

//MARK:- UISearchBarDelegate
extension SendingFromVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            let filteredData  = self.countryData.filter { ($0.countryName ?? "").contains(searchText)}
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
            let filteredData  = self.countryData.filter { ($0.countryName ?? "").contains(searchBar.text ?? "")}
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
