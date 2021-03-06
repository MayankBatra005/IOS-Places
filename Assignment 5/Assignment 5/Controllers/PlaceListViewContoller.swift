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

class PlaceListViewController: UITableViewController, ConnectionStatus, ServerChecker {
    
    var placeselectedIndex = 0
    var modifiedPlace = PlaceDescription()
    var selectedPlaceName: String?
    
    let db = PlaceDB()
    let tempDb = NonSyncPlace()
    let initAppData = InitialAppData()
    
    // This is a check condition for swipe to refresh
    var isRefeshing:Bool = false;
    
    /**********************************************************************************************************************
                                        Life cycle methods
     **********************************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeToRefersh()
        initDataBase()
        setCustomizedNavBar()
        tempDb.getAllNonSyncState()
    }
    
    /**********************************************************************************************************************
                                        UITable View methods
     **********************************************************************************************************************/
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
        let customCell = tableView.dequeueReusableCell(withIdentifier: "PlaceListIdentifier", for: indexPath) as! PlaceItemCellCustom
        if !self.isRefeshing{
            let place = PlaceLibrary.allremotePlaces[indexPath.row]
            customCell.setView(place: place)
        }
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
    
    /**********************************************************************************************************************
                                        Segue methods
     **********************************************************************************************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PlaceDetailSegue"){
            let placedetailViewContoller = segue.destination as! PlaceDetailViewController
            placedetailViewContoller.currentPlace = sender as? PlaceDescription
        }
    }
    
    @IBAction func unwindToPlaceListVC(segue: UIStoryboardSegue) {
        
        if(segue.identifier=="gobacktoPlaceList"){
           deletePlace()
        }else if(segue.identifier=="SaveAddPlace"){
            print("Save place Successfully")
            addNewPlace()
        }else if(segue.identifier=="modifyPlace"){
            modifyPlace()
        }
    }
    
    /**********************************************************************************************************************
                                        IBActions
     **********************************************************************************************************************/
    @IBAction func addNewPlace(_ sender: Any) {
        performSegue(withIdentifier: "AddPlaceSegue", sender: nil)
    }
    
    @IBAction func syncWithServer(_ sender: Any) {
        sync()
    }
    
    /**********************************************************************************************************************
                                        Callbacks
     **********************************************************************************************************************/
    func connectionFailed(placeName: String, actionName: String) {
        
        tempDb.add(name: placeName, action: actionName)
        
    }
    
    func nonSyncPlacesPused() {
        print("Non synced places pushed")
        PlaceLibrary.allremotePlaces = Array<PlaceDescription>()
        db.deleteAllPlaces()
    }
    
    func isconnected() {
        print("Server Connected")
        tempDb.pushPendingToserver(connectionCallback: self)
        db.deleteAllPlaces()
        PlaceLibrary.loadAllPlacesFromMemory(vc: self)
    }
    
    func notconnected() {
        print("Server not connected")
        syncEnd()
    }
    
    /**********************************************************************************************************************
                                        Private helper methods
     **********************************************************************************************************************/
    @objc private func syncinit()  {
        isRefeshing = true;
        PlaceLibrary.loadAllPlacesFromMemory(vc: self)
    }
    
    public func syncProgress(connectionSuccess: Bool){
        if connectionSuccess{
            tempDb.pushPendingToserver(connectionCallback: self)
            
        }else{
            syncEnd()
        }
    }
    
    public func syncEnd(){
        refreshList()
    }
    
    public func refreshList(){
        isRefeshing = false;
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    private func addNewPlace(){
        PlaceLibrary.allremotePlaces.append(modifiedPlace)
        PlaceLibrary.addPlaceOnServer(place: modifiedPlace, connectionCallback: self)
        db.addPlace(place: modifiedPlace)
        self.tableView.reloadData()
    }
    
    private func modifyPlace(){
        print("updating")
        PlaceLibrary.allremotePlaces[placeselectedIndex] = modifiedPlace
        PlaceLibrary.updatePlaceOnServer(oldName: selectedPlaceName!, modifiedObject: modifiedPlace, connectionCallback: self)
        db.updatePlace(oldName: selectedPlaceName!, place: modifiedPlace)
        self.tableView.reloadData()
    }
    
    private func deletePlace(){
        let placeName: String = PlaceLibrary.allremotePlaces[placeselectedIndex].placeName ?? ""
        PlaceLibrary.deletePlaceOnServer(placeName: placeName, connectionCallback: self)
        PlaceLibrary.allremotePlaces.remove(at: placeselectedIndex)
        db.deletePlace(placeName: placeName)
        refreshList()
    }
    
    private  func initDataBase(){
        if !initAppData.ifAppLaunchedFirstTime(){
            initAppData.appLoaded()
            db.addPlace(place: initAppData.getInitailData())
        }
        db.getAllPlacesFromDatabase(vc: self)
    }
    
    private func setupSwipeToRefersh(){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(serverSyncStart), for: .valueChanged)
        self.refreshControl = refreshControl
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Syncing with server")
    }
    
    private func setCustomizedNavBar(){
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.blackOpaque
        nav?.tintColor = UIColor.white
    }
    
    private func loadListFromServer(){
        PlaceLibrary.loadAllPlacesFromMemory(vc:self)
    }
    
    @objc private func serverSyncStart(){
        isRefeshing = true;
        PlaceLibrary.checkServerConnection(connectionCallback: self)
    }
    
}
