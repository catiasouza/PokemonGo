

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorDeLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorDeLocalizacao.delegate = self
        gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
        gerenciadorDeLocalizacao.startUpdatingLocation()          //gerencia a localizacao
       
    }


}

