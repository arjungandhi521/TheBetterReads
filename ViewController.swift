//
//  ViewController.swift
//  Better Reads
//
//  Created by Digital Media on 1/9/18.
//  Copyright © 2018 Arjun Gandhi. All rights reserved.
//

import UIKit
import CoreData

// This class ViewController is for the the homepage of the app when it is open. It outlines what
// happens when the user clicks the buttons such as favorites/read/owned/to read books. It also
// lays out what happnes when about and the add a book buttons are pressed.
class ViewController: UIViewController {
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Homsecreen button options
    @IBOutlet weak var rankingsButton: UIButton! // favorite books button
    @IBOutlet weak var myBooksButton: UIButton! // books owned button
    @IBOutlet weak var readBooksButton: UIButton! // books read button
    @IBOutlet weak var futureReadsButton: UIButton! // books to read button
    @IBOutlet weak var addABookButton: UIButton! // add a book button
    
    // load the the name of book for each book in table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BooksListViewController {
            let (list, name) = sender as! ([Book], String)
             destination.bookList = list
            destination.bookListName = name
            
        }
    }
    
    // Send user to add a book page
    @IBAction func addABookButton(_ sender: Any) {
        performSegue(withIdentifier: "hometoAddABook", sender: nil)
    }
    
    // Send user to about page
    @IBAction func aboutBookButton(_ sender: Any) {
        performSegue(withIdentifier: "homeToAbout", sender: nil)
        
    }
    
    // Send user to favorite books
    @IBAction func rankingsButton(_ sender: Any) {
        do {
            var bookList = try managedContext.fetch(Book.fetchRequest()) as [Book]
            bookList = bookList.filter() {
                $0.rankings
            }
            // switch screen from home to favorites list
            performSegue(withIdentifier: "homeToBookList", sender: (bookList, "Favorites"))
        } catch {
            print("Error loading books.")
            
        }
        
    }
    
    // send user to books owned list
    @IBAction func myBooksButton(_ sender: Any) {
        do {
            var bookList = try managedContext.fetch(Book.fetchRequest()) as [Book]
            bookList = bookList.filter() {
                $0.myBooks
            }
            // change screen from home to my books list
            performSegue(withIdentifier: "homeToBookList", sender: (bookList, "My Books"))
        } catch {
            print("Error loading books.")
        }
    }
    
    // send user to read books page
    @IBAction func readBooksButton(_ sender: Any) {
        do {
            var bookList = try managedContext.fetch(Book.fetchRequest()) as [Book]
            bookList = bookList.filter() {
                $0.readBooks
            }
            // switch screen from home to read books list
            performSegue(withIdentifier: "homeToBookList", sender: (bookList, "Read Books"))
        } catch {
            print("Error loading books.")
        }
    }
    
    // send user to future reads list
    @IBAction func futureBooksButton(_ sender: Any) {
        do {
            var bookList = try managedContext.fetch(Book.fetchRequest()) as [Book]
            bookList = bookList.filter() {
                $0.futureReads
            }
            // switch screen from home to to read list
            performSegue(withIdentifier: "homeToBookList", sender: (bookList, "Future Reads"))
        } catch {
            print("Error loading books.")
        }
    }
    
    // send user to list of all books
    @IBAction func allBooks(_ sender: Any) {
        do {
            let bookList = try managedContext.fetch(Book.fetchRequest()) as [Book]
            // change screen from home to all books
            performSegue(withIdentifier: "homeToBookList", sender: (bookList, "All Books"))
        } catch {
            print("Error loading books.")
            
        }
        
    }
    
}
