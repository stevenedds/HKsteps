//
//  SearchTableViewController.swift
//  StepCount
//
//  Created by Ryan  Gunn on 2/7/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import Firebase

class SearchTableViewController: UITableViewController {

    var searchController = UISearchController(searchResultsController: nil)
    var usersArray = Array<Dictionary<String,AnyObject>>()
    var searchUsers = Array<Dictionary<String,AnyObject>>()
    var selectedUserDic = Dictionary<String,AnyObject>()


    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self

        getUsers()
    }

    func getUsers() {
        let usernameRef = Firebase(url: "https://healthkitapp.firebaseio.com/users")

        usernameRef.observeSingleEventOfType(.Value, withBlock: { snapshot in

            let userDic = snapshot.value as? Dictionary<String, Dictionary<String,AnyObject>>

            if let userDic = userDic {
                for (_, dic) in userDic {
                    self.usersArray.append(dic)
                }
            }
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.tableView.reloadData()
            })
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchUsers.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath)

        var userDic = Dictionary<String,AnyObject>()
        if searchController.active && searchController.searchBar.text != "" {

            userDic = searchUsers[indexPath.row]
        } else {
            userDic = usersArray[indexPath.row]
        }

        let username = userDic["userEmail"] as? String

        if let username = username {
            cell.textLabel?.text = username
        }

        return cell



    }

    func filterContentForSearchText(searchText: String, scope: Int) {
        //        let searchPredicate = NSPredicate(format: "name like %@", searchText)


            searchUsers = usersArray.filter({ (theUser) -> Bool in
                print(theUser["userEmail"])

                return theUser["userEmail"]?.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
            })


        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if searchController.active && searchController.searchBar.text != ""  {
            selectedUserDic = searchUsers[indexPath.row]
//            performSegueWithIdentifier("searchUsersSegue", sender: self)
            print(selectedUserDic)

        } else {
            self.selectedUserDic = searchUsers[indexPath.row]
//            performSegueWithIdentifier("searchUsersSegue", sender: self)
              print(selectedUserDic)

        }
        
        
    }

}

extension SearchTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Search Lists and Users")
    }

    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Enter in Searchbar above")
    }

}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.selectedScopeButtonIndex
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}


