//
//  CoreDataMnager.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import Foundation
import UIKit
import CoreData
class  CoreDataManger {
    
    let managedobjectcontext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    //MARK:- SAVE DATA
    func savedata(sendingCountry : String,payingCountry : String, amountToSend: String, amountToReceiver: String, purpose: String ) {
        
        if  let managedobjectcontext = managedobjectcontext {
            
            let  entityDiscription = NSEntityDescription.entity(forEntityName: "CountryData", in: managedobjectcontext)
            
            let newRecord = NSManagedObject(entity: entityDiscription!, insertInto: managedobjectcontext)
            newRecord.setValue(sendingCountry, forKey: "sendingCountry")
            newRecord.setValue(payingCountry, forKey: "payingCountry")
            newRecord.setValue(amountToSend, forKey: "amountToSend")
            newRecord.setValue(amountToReceiver, forKey: "amountToReceiver")
            newRecord.setValue(purpose, forKey: "purpose")
            do {
                try managedobjectcontext.save()
                print("Data Saved")
            } catch {
                print("Data doesnot Saved")
            }
        }
    }
    
    //MARK:- FETCH DATA
    
    func fetchdata() -> [CountryData] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        let entityDiscription = NSEntityDescription.entity(forEntityName: "CountryData", in: managedobjectcontext!)
        
        fetchRequest.entity = entityDiscription
        var savedRecords = [CountryData]()
        do {
            if let result = try managedobjectcontext?.fetch(fetchRequest) as? [CountryData] {
            savedRecords = result
            }
        } catch {
            let fetcherror = error as NSError
            print(fetcherror)
        }
        return savedRecords
    }
}
