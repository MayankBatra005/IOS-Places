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
    
    var placeselectedIndex = 0
    var modifiedPlace = PlaceDescription()
    let db = PlaceDB()
    var selectedPlaceName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataBase()
//        loadListFromSource()
        setCustomizedNavBar()
    }
    
    func setCustomizedNavBar(){
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.blackOpaque
        nav?.tintColor = UIColor.white
    }
    
    func loadListFromSource(){

        PlaceLibrary.loadAllPlacesFromMemory(vc:self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaceLibrary.allremotePlaces.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let place = PlaceLibrary.allremotePlaces[indexPath.row]
        let customCell = tableView.dequeueReusableCell(withIdentifier: "PlaceListIdentifier", for: indexPath) as! PlaceItemCellCustom
        
        customCell.setView(place: place)
    
        return customCell
    }
    
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = PlaceLibrary.allremotePlaces[indexPath.row]
        placeselectedIndex = indexPath.row
        selectedPlaceName = place.placeName
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
        
        let placeName: String = PlaceLibrary.allremotePlaces[placeselectedIndex].placeName ?? ""
        PlaceLibrary.deletePlaceOnServer(placeName: placeName)
        PlaceLibrary.allremotePlaces.remove(at: placeselectedIndex)
        db.deletePlace(placeName: placeName)
        refreshList()

    }
    
    private func addNewPlace(){
        PlaceLibrary.allremotePlaces.append(modifiedPlace)
        PlaceLibrary.addPlaceOnServer(place: modifiedPlace)
        db.addPlace(place: modifiedPlace)
        self.tableView.reloadData()
    }
    
    private func modifyPlace(){
        print("updating")
        PlaceLibrary.allremotePlaces[placeselectedIndex] = modifiedPlace
        db.updatePlace(oldName: selectedPlaceName!, place: modifiedPlace)
        self.tableView.reloadData()
    }
    
    public func refreshList(){
        self.tableView.reloadData()
    }
    
    public func initDataBase(){
        
        db.getAllPlacesFromDatabase(vc: self)
        
//        let mplace:PlaceDescription = PlaceDescription()
//        mplace.placeName = "Delhh"
//        mplace.placeDescription = "It sthe capital"
//        mplace.category = "Hike"
//        mplace.streetAddress = "Street address"
//        mplace.streetTitle = "St title"
//        mplace.elevation = 200
//        mplace.latitude = 534.3
//        mplace.longitude = 433.7
//
////        db.addPlace(place: mplace)
//        db.deleteAllPlaces()
//        db.getAllPlacesFromDatabase()
        
        
    }
    
}
