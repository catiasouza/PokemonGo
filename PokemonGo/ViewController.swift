

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorDeLocalizacao = CLLocationManager()
    var contador = 0
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorDeLocalizacao.delegate = self
        gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
        gerenciadorDeLocalizacao.startUpdatingLocation()          //gerencia a localizacao
        
        //RECUPERAR POKEMONS
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosPokemons()
        
        //EXIBIR pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
             print("Exibe anotacao")
           
            if let coordenadas = self.gerenciadorDeLocalizacao.location?.coordinate  {
                let anotacao = MKPointAnnotation()
                
                let latAleatoria = (Double(arc4random_uniform(500)) - 250) / 100000.0
                let longAleatoria = (Double(arc4random_uniform(500)) - 250) / 100000.0
                
                anotacao.coordinate = coordenadas
                anotacao.coordinate.latitude += latAleatoria
                 anotacao.coordinate.latitude += longAleatoria
                
                self.mapa.addAnnotation(anotacao)
                
            }
            
        }
        
    }   //configurando localizacao
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   
    if contador < 5 {
        self.centralizar()
            
    
        print("EXECUTOU")
        contador += 1
    }else{
        print("PAROU")
        gerenciadorDeLocalizacao.stopUpdatingLocation()
    }
    
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
       
        
        if annotation is MKUserLocation{
             anotacaoView.image = UIImage(named: "player")
        }else{
            
                 anotacaoView.image = UIImage(named: "pikachu-2")
        }
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width = 40
        anotacaoView.frame = frame
        return anotacaoView
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
    
    // imagem da lupa
    
    func centralizar(){
        if  let coordenadas = gerenciadorDeLocalizacao.location?.coordinate {
            
            // centralizando localizacao
            let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 200, longitudinalMeters: 200)
            mapa.setRegion(regiao, animated: true)
            
        }
    }
    @IBAction func centralizarJogador(_ sender: Any) {
        self.centralizar()
    }

   
    @IBAction func abrirPokedex(_ sender: Any) {
    }
}
