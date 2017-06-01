//
//  NewPlayerViewController.swift
//  lavieja
//
//  Created by Maite Mañana on 5/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import CoreData

class NewPlayerViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.age.keyboardType = UIKeyboardType.numberPad
        self.email.keyboardType = UIKeyboardType.emailAddress


    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.name.text = nil
        self.age.text = nil
        self.email.text = nil
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        tabBarController?.selectedIndex = 0
    }

    @IBAction func savePlayer(_ sender: UIBarButtonItem) {
        if newPlayerValidation(name.text!, age.text!, email.text!) {
            let player = NSEntityDescription.insertNewObject(forEntityName: "Player", into: self.context) as! Player
            player.name = name.text
            player.age = Int16(age.text!)!
            player.email = email.text

            do {
                try context.save()
                tabBarController?.selectedIndex = 0
                MessageHandler.showMessage(title: "Jugador creado", body: "El jugador se ha creado correctamente", type: messageType.SUCCESS)
            } catch {
                MessageHandler.showMessage(title: "Error", body: "No se ha podido crear el jugador", type: messageType.ERROR)
            }
        }
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: testStr)
    }
    
    func newPlayerValidation(_ name: String, _ age: String, _ email: String) -> Bool {
        let incompleteFields = name.isEmpty ||  String(age).isEmpty ||  email.isEmpty
        let validEmail = isValidEmail(testStr: email)

        if incompleteFields {
            MessageHandler.showMessage(title: "Datos incompletos", body: "Debe ingresar todos los campos", type: messageType.ERROR)
            return false
        }
        
        if !validEmail {
            MessageHandler.showMessage(title: "Email inválido", body: "Debe ingresar un email válido", type: messageType.ERROR)
            return false
        }
        
        return true
    }
}
