//
//  NycSchoolApiManager.swift
//  20180324-SergeDossongui-NYCSchools
//
//  Created by serge kone Dossongui on 3/24/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import Foundation

class NycSchoolApiManager {
    
    static let NycSchoolUrl = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    static  let SATURL = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
    
    var session : URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
   
    /**
     *Return an array of School from the network request
     * @param: completion- school
     * @param: completion- Error
     */
    func GetSchoolList( completion: @escaping([School]?, Error?)->()){
        
        let url  = URL(string: NycSchoolApiManager.NycSchoolUrl)
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10 )
        let task = session.dataTask(with: request){(data,response,error) in
            
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                let schools = School.Schools(dictionaries: dataDictionary)
                completion(schools, nil )
                
            }else {
                
                completion(nil, error)
            }
            
        }
        task.resume()
        
    }
    
    /**
     *Return an array of SATdata  from the network request
     * @param: completion- school
     * @param: completion- Error
     */
    func GetSATdata( completion : @escaping ([SATScore]?,Error? )->()){
        
        let url = URL(string: NycSchoolApiManager.SATURL)
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) {(data,response,error) in
            
            if let data = data {
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
            let SATScores = SATScore.SATScores(dictionaries: dataDictionary)
            completion(SATScores, nil )
            
        }else {
            
            completion(nil, error)
        }
        
    }
    task.resume()
        
  }
}


