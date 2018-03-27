//
//  HomeViewController.swift
//  20180324-SergeDossongui-NYCSchools
//
//  Created by serge kone Dossongui on 3/24/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var schoolArray : [School]  = []
     var  selectedSchool: School?
    var activityIndicator  = UIActivityIndicatorView()
    var loadingText = UILabel()
    var messageFrame = UIView()
    var refreshcontrol : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.title = "NYC SCHOOLS"
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = "Home--TableView"
        
        refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)    ), for: .valueChanged)
        
        tableView.insertSubview(refreshcontrol, at: 0)
        
        fetchSchool()
     
    }
    
    
    /**
     *Handle refresh event    from the network request
     * @param: refreshcontorl : UIRefreshControl
     */
    @objc func didPullToRefresh(_ refreshcontorl: UIRefreshControl){
        
        //tableView.insertSubview(refreshcontrol, at: 0)
        fetchSchool()
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath) as! SchoolTableViewCell
        
        cell.School = schoolArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return schoolArray.count
    }
    
    
    /**
     *Return NYC Schools result from the network request and relaod the tableview
     * @param: none
     */
    func fetchSchool() {
        
        self.showActivityIndicator(_sender: self)
        
        NycSchoolApiManager().GetSchoolList { (schools:[School]?,error:Error?) in
            
            if let schools = schools {
                self.schoolArray = []
                self.schoolArray = schools
                self.tableView.reloadData()
                self.refreshcontrol.endRefreshing()
                
            }else {
                self.DisplayAlert(errorDescription: (error?.localizedDescription)!)
            }
            //use to execute in the main so it is faster
            DispatchQueue.main.async {
                self.hideActiviyIndicatorAndResumeWork(_sender: self)
                
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
            self.tableView.reloadData()
            self.fetchSchool()
           
        }
       
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        self.hideActiviyIndicatorAndResumeWork(_sender: self)
        present(alertController, animated: true) {
            // can add  code for what happens after the alert controller has finished presenting
        }
    }
    
    /**
     *Initialize a loading animated view and loack activity on screen
     * @param: none
     */
    func showActivityIndicator(_sender:Any){
        
        loadingText = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        loadingText.text = "Loading NYC School!"
        loadingText.textColor = UIColor.white
        
        loadingText.font = UIFont(name: "Avenir Next", size: 14.0)
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 200, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(red: 156/255.0, green:
            6/255.0, blue: 6/255.0, alpha: 0.5)
        
        // UIColor(white: 1, alpha: 0.5)
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
     *Hide  loading animated view and resume activity
     * @param: none
     */
    func hideActiviyIndicatorAndResumeWork(_sender:Any) {
        
        self.activityIndicator.stopAnimating()
        self.messageFrame.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         self.selectedSchool =  schoolArray[indexPath.row]
       
        self.performSegue(withIdentifier: "test", sender: nil)
          tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "test" {
            
             let destinationVC = segue.destination as! SchoolDetailsViewController
            destinationVC.selectedSchool = selectedSchool

            
          

        }
 
    }

}


