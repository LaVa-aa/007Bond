//
//  ViewController.swift
//  007Bond
//
//  Created by dmu mac 20 on 24/11/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //til at kobles med de ting der står i main EK: Image med @IBOutlet er en variabel
    
    private let bondService = BondService()
    private var soundPlayer: AVAudioPlayer?
    
    //view implementers ved xaml
    //outlet er navn give af UIImageView
    @IBOutlet weak var bondImageView: UIImageView!
    
    @IBAction func bondTap(_ sender: UITapGestureRecognizer) {
        bondImageView.image = UIImage(named: selectRandomBondName())
    }
    
    @IBAction func soundAction(_ sender: UIButton) {
        if soundPlayer!.isPlaying{
            soundPlayer?.pause()
            sender.setTitle("Play", for: .normal)
        }else{
            soundPlayer?.play()
            sender.setTitle("Pause", for: .normal)
        }
    }
    
    
    
    
    //liv cyklusen for UIKit hver gang der er en passivet view som bliver styret af controller
    // viewDidLoad er den funk der kaldet den kades en gang og der kan ikke bruges mange gang
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bondImageView.image = UIImage(named: selectRandomBondName())
        let path = Bundle.main.path(forResource: "theme", ofType: "aiff")
        //optional unwrapping
        if let path = path {
            let url = NSURL.fileURL(withPath: path)
            do {
                try soundPlayer = AVAudioPlayer(contentsOf: url)
                //prepareToPlay() betyder reset
                soundPlayer?.prepareToPlay()
                soundPlayer?.play()
            }catch{
                print("Worning, there is error")
            }
        }
    
    }
   
    
    //Shake phone func change image
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        bondImageView.image = UIImage(named: selectRandomBondName())
    }
    
    private func selectRandomBondName()-> String {
        //lav et array
      //  let bondNames = ["sean_conary","george_lazenby","daniel_craig","pierce_brosnan","timothy_dalton","roger_moore"]
         
      //  return bondNames.randomElement()!
        
        //using service i stedet for den oven code
        let bondNames = bondService.ReadBondFromFile()
        
        return bondNames.randomElement()!
    
    }


}

