//
//  OrderTableViewController.swift
//  NewOrderForm
//
//  Created by Ivo Radoslavov on 12/17/15.
//  Copyright © 2015 Ivo Radoslavov. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    //MARK: Propertires
    
    var orders = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem()
        
        //load saved orders, otherwise load sample data
        
        if let savedOrders = loadOrders() {
            orders = orders + savedOrders
        } else {
        
        loadSampleOrders()
        }
    }
    
    func loadSampleOrders(){
        let order1 = Order(client: "Youman", unitPrice: 0.185, quantity: 10000)
        orders.append(order1)
        
        let order2 = Order(client: "Parador", unitPrice: 0.53, quantity: 500)
        orders.append(order2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "orderCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let order = orders[indexPath.row]
        
        cell.textLabel?.text = order.client
        cell.detailTextLabel?.text = String(order.calculateTotal())
        
        
        
        

        // Configure the cell...

        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            orders.removeAtIndex(indexPath.row)
            saveOrders()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let OrderDetailViewController = segue.destinationViewController as! OrderViewController
            if let selectedOrderCell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(selectedOrderCell)!
                let selectedOrder = orders[indexPath.row]
                OrderDetailViewController.order = selectedOrder
            }
        }
        else if segue.identifier == "addOrder" {
            print("adding new meal")
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToOrderList(sender:UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? OrderViewController, order = sourceViewController.order {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //update an existing order
                orders[selectedIndexPath.row] = order
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
        
                //add new order
                let newIndexPath = NSIndexPath(forRow: orders.count, inSection: 0)
                orders.append(order)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveOrders()
        }
    }
    
    //MARK: NSCoding
    func saveOrders() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(orders, toFile: Order.ArchiveURL.path!)
    }
    
    func loadOrders() -> [Order]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Order.ArchiveURL.path!) as? [Order]
    }
}
