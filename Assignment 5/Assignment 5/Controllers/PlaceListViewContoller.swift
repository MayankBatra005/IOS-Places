/*
 * Copyright 2020 Rohit Kumar Singh,
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author Rohit Kumar Singh rsingh92@asu.edu
 *
 * @version March 2016
 */


import Foundation
import UIKit

class PlaceListViewController: UITableViewController {
    
    var places = Array<PlaceDescription>()
    var placeselectedIndex = 0
    var modifiedPlace = PlaceDescription()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListFromSource()
        setCustomizedNavBar()
    }
    
    func setCustomizedNavBar(){
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.blackOpaque
        nav?.tintColor = UIColor.white
    }
    
    func loadListFromSource(){
        places = PlaceLibrary.createDummyPlaceList()
        print(places.count.description)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let place = places[indexPath.row]
        let customCell = tableView.dequeueReusableCell(withIdentifier: "PlaceListIdentifier", for: indexPath) as! PlaceItemCellCustom
        
        customCell.setView(place: place)
    
        return customCell
    }
    
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        placeselectedIndex = indexPath.row
        performSegue(withIdentifier: "PlaceDetailSegue", sender: place)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "PlaceDetailSegue"){
            let placedetailViewContoller = segue.destination as! PlaceDetailViewController
            placedetailViewContoller.currentPlace = sender as? PlaceDescription
        }
    }
    
    @IBAction func unwindToPlaceListVC(segue: UIStoryboardSegue) {
        
        print("This is before if condition")
        if(segue.identifier=="gobacktoPlaceList"){
           deletePlace()
        }else if(segue.identifier=="SaveAddPlace"){
            print("Save place Successfully")
            addNewPlace()
        }else if(segue.identifier=="modifyPlace"){
            modifyPlace()
        }
    }
    
    @IBAction func addNewPlace(_ sender: Any) {
        performSegue(withIdentifier: "AddPlaceSegue", sender: nil)
    }
    
    
    private func deletePlace(){
        places.remove(at: placeselectedIndex)
        self.tableView.reloadData()
    }
    
    private func addNewPlace(){
        places.append(modifiedPlace)
        self.tableView.reloadData()
    }
    
    private func modifyPlace(){
        places[placeselectedIndex] = modifiedPlace
        self.tableView.reloadData()
    }
    
}
