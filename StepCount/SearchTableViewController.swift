//
//  SearchTableViewController.swift
//  StepCount
//
//  Created by Ryan  Gunn on 2/7/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class SearchTableViewController: UITableViewController {

    var searchController = UISearchController(searchResultsController: nil)
    var usersArray = [BackendlessUser]()
    var searchUsers = [BackendlessUser]()
    var selectedUserDic = BackendlessUser()


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

        let dataStore = Backendless.sharedInstance().data .of(BackendlessUser)
            dataStore.find({ (collection) -> Void in
                for user in collection.data {
                    let backendUser = user as? BackendlessUser
                    if let backendUser = backendUser {
                        self.usersArray.append(backendUser)
                    }
                 NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                 })
                }

                print(collection)
                }) { (error) -> Void in
                    print(error.message)
        }

              
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

        var userAtIndex = BackendlessUser()
        if searchController.active && searchController.searchBar.text != "" {

            userAtIndex = searchUsers[indexPath.row]
        } else {
            userAtIndex = usersArray[indexPath.row]
        }

        let username = userAtIndex.name

        if let username = username {
            cell.textLabel?.text = username
        }

        return cell



    }

    func filterContentForSearchText(searchText: String, scope: Int) {

            searchUsers = usersArray.filter({ (theUser) -> Bool in

                return theUser.name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
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


