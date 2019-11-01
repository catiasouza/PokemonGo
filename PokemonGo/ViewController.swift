

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorDeLocalizacao = CLLocationManager()
    var contador = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorDeLocalizacao.delegate = self
        gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
        gerenciadorDeLocalizacao.startUpdatingLocation()          //gerencia a localizacao
       
    }   //configurando localizacao
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   
    if contador < 5 {
        if  let coordenadas = gerenciadorDeLocalizacao.location?.coordinate {
    
            // centralizando localizacao
            let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 200, longitudinalMeters: 200)
            mapa.setRegion(regiao, animated: true)
            
        }
        print("EXECUTOU")
        contador += 1
    }else{
        print("PAROU")
        gerenciadorDeLocalizacao.stopUpdatingLocation()
    }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse && status !=  .notDetermined{
            // alerta
            let alertController = UIAlertController(title: "Permissao de localizacao",
                                                    message: "Para que voc epossa cacar pokemons,prescisamos da sua localizacao!! Por favor habilite!!!", preferredStyle: .alert)
            let acaoConfiguracao = UIAlertAction(title: "Abrir configuracoes", style: .default) { (alertaConfiguracoes) in
                
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(configuracoes as URL)
                }
            }
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            alertController.addAction(acaoConfiguracao)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

