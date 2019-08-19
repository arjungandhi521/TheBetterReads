//
//  addABook.swift
//  My Reads
//
//  Created by Digital Media on 1/4/18.
//  Copyright © 2018 Arjun Gandhi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// A class for the add a book page.
class AddABook: UIViewController {

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: AddBookDelegate?
    var category: String!

    // Book's title and author vars
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    
    // Category option for books when adding it.
    @IBOutlet weak var rankingsSwitch: UISwitch!
    @IBOutlet weak var myBooksSwitch: UISwitch!
    @IBOutlet weak var readBooksSwitch: UISwitch!
    @IBOutlet weak var futureReadsSwitch: UISwitch!

    @IBOutlet weak var addBookButton: UIButton! // add a book button var
    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // if added from favorties page, turn on favorties switch
        if category == "Favorites" {
            rankingsSwitch.isOn = true
        }
         // if added from my books page, turn on my books switch
        else if category == "My Books" {
            myBooksSwitch.isOn = true
        }
         // if added from read page, turn on rad switch
        else if category == "Read Books" {
            readBooksSwitch.isOn = true
        }
        // if added from future books page, turn on future books switch
        else if category == "Future Reads" {
            futureReadsSwitch.isOn = true
        }
        
            // if added from all books page, turn on all switches
        else if category == "All Books" {
            readBooksSwitch.isOn = true
            futureReadsSwitch.isOn = true
            rankingsSwitch.isOn = true
            myBooksSwitch.isOn = true
        }
    }

    // Add book function
    @IBAction func addBook(sender: UIButton) {
        // if title is not empty and a switch is on
        if titleTextField.text! != "" && (readBooksSwitch.isOn || rankingsSwitch.isOn || futureReadsSwitch.isOn || myBooksSwitch.isOn) {
            
            let book = Book (context: managedContext)
            // collect text fields and current switch states
            book.author = authorTextField.text
            book.title = titleTextField.text
            book.readBooks = readBooksSwitch.isOn
            book.futureReads = futureReadsSwitch.isOn
            book.rankings = rankingsSwitch.isOn
            book.myBooks = myBooksSwitch.isOn
            book.dateAdded = Date()
            
            do {
                try managedContext.save()
            } catch {
                print("Error saving to disk.")
            }
            debugPrint(book)
            delegate?.addBook(book: book)
        dismiss(animated: true, completion: nil)
        }
        
    }
    
    // cancel button function dismiss current addABook page
    @IBAction func cancelButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}

extension AddABook: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
