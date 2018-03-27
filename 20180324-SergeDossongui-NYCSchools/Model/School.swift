//
//  School.swift
//  20180324-SergeDossongui-NYCSchools
//
//  Created by serge kone Dossongui on 3/24/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import Foundation

/**
 * A School class that define the School schema
 */
class School {
    
    var school_name : String?
    var phoneNumber : String?
    var address: String?
    var overview_paragraph : String?
    var dbn : String?
    var website :String?
    var satScore: SATScore?
    
    /**
     * A initializer that set the property of the school class
     */
    init(dictionary : [String : Any]){
        
        self.school_name = dictionary["school_name"] as? String
        self.phoneNumber = dictionary["phone_number"] as? String
        self.address = dictionary["primary_address_line_1"] as? String
        self.overview_paragraph  = dictionary["overview_paragraph"] as? String
        self.dbn = dictionary["dbn"] as? String
        self.website = dictionary["website"] as? String
      
        
    }
    
  
    /**
     *Return an array of School from a  school dictionary
     * @param: dictionaries: [[String: Any]]
    */
    class func  Schools(dictionaries: [[String: Any]]) -> [School] {
        
        var schoolArray : [School] = []
        for dict in dictionaries {
            let a_school = School(dictionary: dict)
            schoolArray.append(a_school)
        }
        
        return schoolArray
       
    }
}
