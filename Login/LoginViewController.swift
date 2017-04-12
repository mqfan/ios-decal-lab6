//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        static let buttonCornerRadius: CGFloat = 10
    }
    
    
    var emailField = UITextField(frame: CGRect(x:0, y:0, width: 0, height: 0))
    var passwordField = UITextField(frame: CGRect(x:0, y:0, width: 0, height: 0))

    // TODO: instantiate the views needed for your project
    
    let mainFrame = CGRect(x: UIScreen.main.bounds.width * 0.05, y: 0,
                         width: UIScreen.main.bounds.width * 0.9,
                         height: UIScreen.main.bounds.height)
    
    let loginFrame = CGRect(x: UIScreen.main.bounds.width * 0.2, y: 0,
                           width: UIScreen.main.bounds.width * 0.9,
                           height: UIScreen.main.bounds.height * 0.2)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        let labelFrame = CGRect(x:0, y:0, width: mainFrame.width-40, height: 40)
        
        let loginLabel = UILabel(frame: labelFrame)
        loginLabel.textColor = UIColor.white
        loginLabel.backgroundColor = Constants.backgroundColor
        loginLabel.font = UIFont(name: "GillSans", size: 40)
        loginLabel.text = "Login View Controller"
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraint1 = view.topAnchor.constraint(equalTo: loginLabel.topAnchor, constant: UIScreen.main.bounds.height * -0.3)
        let constraintCenterLabel = loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        
        let loginView = UIView(frame: loginFrame)
        loginView.center = view.center
        loginView.backgroundColor = UIColor.white
        loginView.layer.cornerRadius = Constants.buttonCornerRadius
        
        
        let textFrame = CGRect(x:0, y:0, width: loginView.bounds.width*0.95, height: 20)
        
        emailField = UITextField(frame: textFrame)
        emailField.placeholder = "berkeley.edu account"
        emailField.translatesAutoresizingMaskIntoConstraints = false
        let constraintTopEmail = loginView.topAnchor.constraint(equalTo: emailField.topAnchor, constant: -20)
        let constraintLeftEmail = emailField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10)

        
        passwordField = UITextField(frame: textFrame)
        passwordField.placeholder = "Password"
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        let constraintTopPassword = passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10)
        let constraintLeftPassword = passwordField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10)
        
        let buttonFrame = CGRect(x:0, y:0, width: loginView.bounds.width, height: 20)
        
        let loginButton = UIButton(frame: buttonFrame)
        loginButton.addTarget(self, action: #selector(clickedLogin), for: .touchUpInside)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = Constants.backgroundColor
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = Constants.buttonCornerRadius
        let constraintTopButton = loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10)
        let constraintCenterButton = loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor)
        let constraintWidthButton = loginButton.widthAnchor.constraint(equalToConstant: loginView.bounds.width * 0.5)
        
        
        view.addSubview(loginLabel)
        view.addSubview(loginView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        constraint1.isActive = true
        constraintCenterLabel.isActive = true
        constraintLeftEmail.isActive = true
        constraintTopEmail.isActive = true
        constraintTopPassword.isActive = true
        constraintLeftPassword.isActive = true
        constraintTopButton.isActive = true
        constraintCenterButton.isActive = true
        constraintWidthButton.isActive = true
        // TODO: layout your views using frames or AutoLayout
        
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func clickedLogin(sender: UIButton) {
        print(emailField.text ?? "")
        print(passwordField.text ?? "")
        authenticateUser(username: emailField.text, password: passwordField.text)
    }
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
