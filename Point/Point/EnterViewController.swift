//
//  EnterViewController.swift
//  Point
//
//  Created by Ryland Sepic on 8/7/20.
//  Copyright © 2020 Ryland Sepic. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var project: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.delegate = self
        project.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissNumPad)))
    }
    
    @IBAction func enter(_ sender: Any) {
        if user != nil && project != nil {
            /// If the user entered the appropriate information
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let surveyVC = storyboard.instantiateViewController(identifier: "SurveyVC") as! SurveyViewController

            guard let userText = user.text, let projectText = project.text else {
                print("User did not enter valid text")
                return
            }
            print("push view")
            surveyVC.user = userText
            surveyVC.project = projectText
            
            self.navigationController?.pushViewController(surveyVC, animated: true)
        }
    }
    
    @objc func dismissNumPad() {
        user.resignFirstResponder()
        project.resignFirstResponder()
    }
}
