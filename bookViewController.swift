//
//  book.swift
//  My Reads
//
//  Created by Digital Media on 1/9/18.
//  Copyright © 2018 Chase Smith. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// This class represents the screen that the user sees when they are viewing/adding/editing
// a book.

class BookViewController: UIViewController {
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var book: Book!
     var delegate: AddBookDelegate?
    
    @IBOutlet weak var titleTextField: UITextField! //  title field var
    @IBOutlet weak var authorTextField: UITextField! // author field var
    @IBOutlet weak var rankingsSwitch: UISwitch! // rankings switch var
    @IBOutlet weak var myBooksSwitch: UISwitch! // my books switch var
    @IBOutlet weak var readBooksSwitch: UISwitch! // read books var
    @IBOutlet weak var futureReadsSwitch: UISwitch! // to read switch
    @IBOutlet weak var editBookButton: UIButton! // edit book button var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set book's author field to the current book's author
        authorTextField.text = book.author
        // set book's title field to the current book title
        titleTextField.text = book.title
        // set switch titles to saved/current set states of off/on
        readBooksSwitch.isOn = book.readBooks
        futureReadsSwitch.isOn = book.futureReads
        rankingsSwitch.isOn = book.rankings
        myBooksSwitch.isOn = book.myBooks
    }
    
    // Edit book function
    @IBAction func editBook(sender: UIButton) {
        // if the title is not blank and a book category is selected
        if titleTextField.text! != "" && (readBooksSwitch.isOn || rankingsSwitch.isOn || futureReadsSwitch.isOn || myBooksSwitch.isOn) {
            // book's author is set to text of author field
            book.author = authorTextField.text
            // book title is set to text of of title field
            book.title = titleTextField.text
            // all category switches are set to the current set values
            book.readBooks = readBooksSwitch.isOn
            book.futureReads = futureReadsSwitch.isOn
            book.rankings = rankingsSwitch.isOn
            book.myBooks = myBooksSwitch.isOn

            do {
                try managedContext.save()
            } catch {
                print(error)
            }
            delegate?.updateBook(book: book)
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Function to send user back to the previous book list.
    @IBAction func backToBookList(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // Function for remove book button.
    @IBAction func removeBook(sender: UIButton) {
        managedContext.delete(book)
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
        delegate?.removeBook(book: book)
        dismiss(animated: true, completion: nil)
    }
}

extension BookViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
