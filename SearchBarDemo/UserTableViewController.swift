//
//  UserTableViewController.swift
//  SearchBarDemo
//
//  Created by 三斗 on 5/24/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController,UISearchResultsUpdating {
  let instance = Public_Func.instance
  var userData = [[String:String]]()
  var filterData = [[String:String]]()
  var searchController:UISearchController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.estimatedRowHeight = 50
    tableView.rowHeight = UITableViewAutomaticDimension
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    setSeachController()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    instance.getInfoList("getResult.php", parameter: nil) { (data, error) in
      if error != nil{
        let _ = UIAlertController().justHint(error!)
      }else{
        self.userData = data!
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        self.tableView.reloadData()
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setSeachController(){
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    //searchController.searchBar.searchBarStyle = .Minimal
    tableView.tableHeaderView = searchController.searchBar
    tableView.tableFooterView = UIView(frame: CGRectZero)
    tableView.contentOffset.y = searchController.searchBar.frame.size.height
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return searchController.active ? filterData.count: userData.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let result = searchController.active ? filterData[indexPath.row]: userData[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserTableViewCell
    cell.titleLabel.text = result["title"]
    cell.introLabel.text = result["intro"]
    let url = result["imageUrl"]
    cell.userHeadImageView.setImageWithURL(NSURL(string: Constants.imageIp + url!)!, placeholderImage: UIImage(named: "bg"))
    return cell
  }
  
  
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    if let textToSearch = searchController.searchBar.text{
      filter(textToSearch)
      tableView.reloadData()
    }
  }
  
  func filter(data:String){
    filterData = userData.filter({ (singleData) -> Bool in
      return (singleData["title"]?.containsString(data))!
    })
  }
  
  override func scrollViewDidScroll(scrollView: UIScrollView) {
    
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
   if editingStyle == .Delete {
   // Delete the row from the data source
   tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
   } else if editingStyle == .Insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
