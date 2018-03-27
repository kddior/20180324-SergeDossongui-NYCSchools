//
//  SchoolDetailsViewController.swift
//  20180324-SergeDossongui-NYCSchools
//
//  Created by serge kone Dossongui on 3/25/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import UIKit
import  TTTAttributedLabel

class SchoolDetailsViewController: UIViewController {

    
    var SATscoreArrayBySchool : [SATScore] = []
   
    @IBOutlet weak var schoolWebSite: TTTAttributedLabel!
    
  
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var Adress: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var overview_paragraph: UILabel!
    @IBOutlet weak var numofSATTestTakers: UILabel!
    @IBOutlet weak var SATcriticalReadingAvgScore: UILabel!
    @IBOutlet weak var SATMathAvgScore: UILabel!
    @IBOutlet weak var SATWritingAvgScore: UILabel!
    
    var selectedSchool : School!
    
    var activityIndicator  = UIActivityIndicatorView()
    var loadingText = UILabel()
    var messageFrame = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
         rotated()
      
        if (selectedSchool != nil) {
            schoolWebSite.delegate = self
            fetchSAT()
        }
        
        //Notification to detect rotation
     NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    /**
     *Hide Overview Label in Landscape
     * @param: none
     */
    @objc func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
        {
           //landscape
            overview_paragraph.isHidden = true
            self.title = selectedSchool.school_name as? String
        
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            //Portrait
            overview_paragraph.isHidden = false
              self.title = "SAT Results"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.DetailsView.isHidden  = true
     
        if  let a_selectedSchool  = selectedSchool {
            
            //Update UI field 
            Adress.text = "Address: \(a_selectedSchool.address!)"
            PhoneNumber.text  = "Phone: \(a_selectedSchool.phoneNumber!)"
            schoolName.text = a_selectedSchool.school_name
            overview_paragraph.text = a_selectedSchool.overview_paragraph
            
            if a_selectedSchool.website != nil {
              
                 let newWebsite =  formatWebsite(website: a_selectedSchool.website! as NSString)
                   schoolWebSite.text =  newWebsite as String
                   let range :NSRange = newWebsite.range(of: "\(newWebsite)")
                   schoolWebSite.addLink(to: URL(string: "\(newWebsite)"), with: range)
            }

        }
 
    }

    /**
     *Display Error on screen and handle cancel action
     * @param: errorDescription string
     */
    func DisplayAlert(errorDescription:String) {
        
        let alertController = UIAlertController(title: "Cannot Load  Schools", message: errorDescription, preferredStyle: .alert)
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Try again", style: .cancel) { (action) in
            
            // handle cancel response here. Doing nothing will dismiss the view.
            self.fetchSAT()
            
        }
        
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        self.hideActiviyIndicatorAndResumeWork(_sender: self)
        present(alertController, animated: true) {
            // can add  code for what happens after the alert controller has finished presenting
        }
    }
    
    
    
    
    
    /**
     *Format Website by adding require header at the begining
     * @param: website NSString
     */
    func formatWebsite(website: NSString)-> NSString {
        
        return    "http://\(String(describing: website))" as NSString
    }
    
    /**
     *Hide  loading animated view and resume activity
     * @param: none
     */
    func hideActiviyIndicatorAndResumeWork(_sender:Any) {
        
        self.activityIndicator.stopAnimating()
        self.messageFrame.removeFromSuperview()
        self.DetailsView.isHidden  = false
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
    
    /**
     *Initialize a loading animated view and load activity on screen
     * @param: none
     */
    func showActivityIndicator(_sender:Any){
        
        loadingText = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        loadingText.text = "loading SATScores "
        loadingText.textColor = UIColor.white
        loadingText.font = UIFont(name: "Avenir Next", size: 14.0)
  
        
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 200, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(red: 156/255.0, green:
            6/255.0, blue: 6/255.0, alpha: 0.5)
        
    
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.color = UIColor.white
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        

        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        messageFrame.addSubview(activityIndicator)
        messageFrame.addSubview(loadingText)
        view.addSubview(messageFrame)
       
        //stop ignoring application
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }

    
    
    
    /**
     *Return SAT result for a specific school   from the network request
     * @param: none
     */
    func fetchSAT() {
       
        //set movie id in database URL
        self.showActivityIndicator(_sender: self)
        NycSchoolApiManager().GetSATdata { (SATscoresBySchool:[SATScore]?,error:Error?) in
            
            if let SATscoresBySchool = SATscoresBySchool {
                self.SATscoreArrayBySchool = []
                self.SATscoreArrayBySchool = SATscoresBySchool
                let selectedDbn = self.selectedSchool?.dbn as! String
                self.SearchSATForSelectedSchool(searchText: selectedDbn)
              
            }else {
                self.DisplayAlert(errorDescription: (error?.localizedDescription)!)
            }
            DispatchQueue.main.async {
                self.hideActiviyIndicatorAndResumeWork(_sender: self)
                
            }
            
            
        }
    }
    
    
    /**
     *Filter List of SAT result  by school using searchText parameter dbn
     * @param: searchText
     */
    func SearchSATForSelectedSchool(searchText:String ) {
        
        
        var  searchResult =  SATscoreArrayBySchool.filter { (item: SATScore) -> Bool in
           
            let criteria = item.dbn
            return criteria!.range(of: searchText , options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        if searchResult.count > 0 {
            
        let returnSATScore = searchResult[0]
            self.selectedSchool?.satScore = SATScore(dbn: returnSATScore.dbn!, num_of_sat_test_takers: returnSATScore.num_of_sat_test_takers, sat_critical_reading_avg_score: returnSATScore.sat_critical_reading_avg_score!, sat_math_avg_score: returnSATScore.sat_math_avg_score, sat_writing_avg_score: returnSATScore.sat_writing_avg_score, school_name: returnSATScore.school_name)
        
            self.numofSATTestTakers.text = selectedSchool?.satScore?.num_of_sat_test_takers
            self.SATcriticalReadingAvgScore.text = selectedSchool?.satScore?.sat_critical_reading_avg_score
            self.SATMathAvgScore.text = selectedSchool?.satScore?.sat_math_avg_score
            self.SATWritingAvgScore.text = selectedSchool?.satScore?.sat_writing_avg_score
            
            searchResult = []
        } else {
            
            self.numofSATTestTakers.text = "none"
            self.SATcriticalReadingAvgScore.text = "none"
            self.SATMathAvgScore.text = "none"
            self.SATWritingAvgScore.text = "none"
            
        }
        
        
    }
    

}

/**
 *Extend view controller to use TTTAttributedLabelDelegate that create link on label and implement require method
 * @param: TTTAttributedLabel
 * @param: URL
 */
extension SchoolDetailsViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.openURL(url! as URL)
    }
}
