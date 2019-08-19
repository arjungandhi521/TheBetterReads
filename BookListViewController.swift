//
//  BookListViewController.swift
//  My Reads
//
//  Created by Digital Media on 1/10/18.
//  Copyright © 2018 Arjun Gandhi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol AddBookDelegate {
    func addBook(book: Book)
    func updateBook(book: Book)
    func removeBook(book: Book)
}

// Class representing the user's book list.
class BooksListViewController: UIViewController {
    @IBOutlet weak var bookListType: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var bookList: [Book]! // book list is stored as an arry of books
    var bookListName: String!
    
    
    // When hit add a book, go from book list page to add a book page.
    @IBAction func addABookButton(_ sender: Any) {
        performSegue(withIdentifier: "bookListToAddABook", sender: nil)
    }
    
    // When hit edit book go from book list page to book's page.
    @IBAction func editABook(_ sender: Any) {
        performSegue(withIdentifier: "bookListToBook", sender: nil)
    }
    
    // When click home button go back to home page by dismissing book view controller.
    @IBAction func goHome(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // Bring up correct book list
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookListType.text = bookListName // the book list title is set to the current book list
        tableView.reloadData() // update the table view
    }
    
    // Prepare view for book list type
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddABook {
            destination.delegate = self
            destination.category = bookListName
            debugPrint("Add a Book")
        } else if let destination = segue.destination as? BookViewController {
            destination.delegate = self
            destination.book = sender as? Book
        }
    }
    
    // Sorts books alphabetically by name of book
    @IBAction func sortByName(_ sender: Any) {
        // order books correctly
        bookList.sort() {
            $0.title! < $1.title!
        }
        // reload the table of books
        tableView.reloadData()
    }
    
    // Sort books by date added.
    @IBAction func sortByDate(_ sender: Any) {
        bookList.sort() {
            $0.dateAdded! < $1.dateAdded!
        }
        tableView.reloadData()
    }
   
    
}

extension BooksListViewController: UITableViewDataSource {
    
    // count the number of books in list.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    // pick number and book to put in table cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        let book = bookList[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1)) \(book.title!)"
        return cell
    }
    
}

extension BooksListViewController: UITableViewDelegate {
    
    // go from book selected on list of books to the book's page
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = bookList[indexPath.row]
        performSegue(withIdentifier: "bookListToBook", sender: book)
    }
}

extension BooksListViewController: AddBookDelegate {
    
    /// add book to list of books
    func addBook (book: Book) {
        bookList.append(book) // add book to book list
        tableView.reloadData() // reload the table
    }
    
    // remove book function
    func removeBook(book: Book) {
        // iterate trhough list of books until gone through all books
        for i in 0..<bookList.count {
            // if the current book is the book removing
            if bookList[i] == book {
                bookList.remove(at: i) // remove the book at that index
                tableView.reloadData() // reload the book table
                return
            }
        }
    }
    
    // reload table of books when update book
    func updateBook(book: Book) {
        tableView.reloadData()
    }
}
