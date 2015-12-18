//
//  OrderViewController.swift
//  NewOrderForm
//
//  Created by Ivo Radoslavov on 12/17/15.
//  Copyright © 2015 Ivo Radoslavov. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITextFieldDelegate {
    
    var order : Order?
    
    //MARK: Properties
    
    @IBOutlet weak var clientNameTextField: UITextField!
    @IBOutlet weak var unitPriceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //MARK: Actions
    
    @IBAction func calculateTotal(sender: UIButton) {
        
        var unitPrice = Double(unitPriceTextField.text!)
        if unitPrice == nil {unitPrice = 0}
        
        var quantity = Double(quantityTextField.text!)
        if quantity == nil {quantity = 0}
        
        let result = unitPrice! * quantity!
        
        totalLabel.text = String(result)
        
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    /*
    func textFieldDidBeginEditing(textField: UITextField) {
        //disable save button while typing in text fields
        saveButton.enabled = false
    }
    
    func checkValidClientName() {
        //disable save button if text field is empty
        let text = clientNameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    */
    
    func textFieldDidEndEditing(textField: UITextField) {
        //checkValidClientName()
        navigationItem.title = clientNameTextField.text
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    //MARK: Navigation
    
    @IBAction func cancel(sender: AnyObject) {
        if presentingViewController is UINavigationController {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let client = clientNameTextField.text ?? ""
            let unitPrice = Double(unitPriceTextField.text!) ?? 0.0
            let quantity = Double(quantityTextField.text!) ?? 0.0
            
            order = Order(client: client, unitPrice: unitPrice, quantity: quantity)
        }
    }

    
    override func viewDidLoad(){
        super.viewDidLoad()
        clientNameTextField.delegate = self
        unitPriceTextField.delegate = self
        quantityTextField.delegate = self
        
        //enable save button only if the text field has a valid meal name
        //checkValidClientName()
        
        //set up if editing an existing Meal
        
        if let order = order {
            navigationItem.title = order.client
            clientNameTextField.text = order.client
            unitPriceTextField.text = String(order.unitPrice)
            quantityTextField.text = String(order.quantity)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

