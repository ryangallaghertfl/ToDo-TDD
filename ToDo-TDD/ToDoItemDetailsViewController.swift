//
//  ToDoItemDetailsViewController.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 22/11/2023.
//

import UIKit
import MapKit

class ToDoItemDetailsViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var doneButton: UIButton!
    
    var toDoItem: ToDoItem? {
        didSet {
            titleLabel.text = toDoItem?.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
