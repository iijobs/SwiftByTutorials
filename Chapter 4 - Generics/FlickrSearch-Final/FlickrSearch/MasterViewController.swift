/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class MasterViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchBar: UISearchBar!
  
  var searches = OrderedDictionary<String, [Flickr.Photo]>()
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow() {
        let (_, photos) = self.searches[indexPath.row]
        (segue.destinationViewController as DetailViewController).photos = photos
      }
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow() {
      self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
    }
    self.navigationItem.leftBarButtonItem = self.editButtonItem()
  }
  
  override func setEditing(editing: Bool, animated: Bool)  {
    super.setEditing(editing, animated: animated)
    self.tableView.setEditing(editing, animated: animated)
  }
  
}

extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.searches.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    let (term, photos) = self.searches[indexPath.row]
    cell.textLabel.text = "\(term) (\(photos.count))"
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      self.searches.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
  }
  
}

extension MasterViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
    searchBar.resignFirstResponder()
    
    let searchTerm = searchBar.text
    Flickr.search(searchTerm) {
      switch ($0) {
      case .Error:
        break
      case .Results(let results):
        self.searches.insert(results, forKey: searchTerm, atIndex: 0)
        self.tableView.reloadData()
      }
    }
  }
  
}
