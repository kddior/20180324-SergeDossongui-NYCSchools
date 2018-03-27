//
//  SATScore.swift
//  20180324-SergeDossongui-NYCSchools
//
//  Created by serge kone Dossongui on 3/25/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import Foundation


class SATScore {
    
    var dbn :String?
    var num_of_sat_test_takers : String?
    var sat_critical_reading_avg_score : String?
    var sat_math_avg_score : String?
    var sat_writing_avg_score : String?
    var school_name : String?
    
    
    /**
     * A initializer that set the property of the SATClass using dcitonary
     * @param: dictionary:[String:Any]
     */
    init(dictionary:[String:Any]) {
        
        self.dbn = dictionary["dbn"] as? String
        self.num_of_sat_test_takers = dictionary["num_of_sat_test_takers"] as? String
        self.sat_critical_reading_avg_score = dictionary["sat_critical_reading_avg_score"] as? String
        self.sat_math_avg_score  = dictionary["sat_math_avg_score"] as? String
        self.sat_writing_avg_score = dictionary["sat_writing_avg_score"] as? String
        self.school_name = dictionary["sat_writing_avg_score"] as? String
    
    }
    
    /**
     * A initializer that set the property of the SATClass using dcitonary
      * @param: dbn :String?
      * @param: num_of_sat_test_takers : String?
      * @param: sat_critical_reading_avg_score : String?
      * @param:sat_math_avg_score : String?
      * @param: sat_writing_avg_score : String?
      * @param: school_name : String?
     
     */ init(dbn:String ,num_of_sat_test_takers:String? ,sat_critical_reading_avg_score:String,sat_math_avg_score:String?,sat_writing_avg_score:String?,school_name:String?){
        
        self.dbn = dbn
        self.num_of_sat_test_takers = num_of_sat_test_takers
        self.sat_critical_reading_avg_score = sat_critical_reading_avg_score
        self.sat_math_avg_score  = sat_math_avg_score
        self.sat_writing_avg_score = sat_writing_avg_score
        self.school_name = sat_writing_avg_score
        
    }
    
    
    
    /**
     *Return an array of SATScores from a  SATScores dictionary
     * @param: dictionaries: [[String: Any]]
     */
    class func  SATScores(dictionaries: [[String: Any]]) -> [SATScore] {
        
        var SATScoreArray : [SATScore] = []
        for dict in dictionaries {
            let a_school = SATScore(dictionary: dict)
            SATScoreArray.append(a_school)
        }
        
        return SATScoreArray
        
    }
    
    
}
