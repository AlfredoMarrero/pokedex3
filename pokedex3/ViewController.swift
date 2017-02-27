//
//  ViewController.swift
//  pokedex3
//
//  Created by Alfredo M. on 2/26/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    var musicPlayer: AVAudioPlayer!
    var pokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        
        }catch let err as NSError {
            print(err.debugDescription)
        }
    
    }
    
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let cvs = try CSV(contentsOfURL: path!)
            let rows = cvs.rows
            
            for row in rows {
                let pekeId = Int(row["id"]!)
                let name = row["identifier"]!
                
                let poke = Pokemon (name: name, pokedexId: pekeId!)
                pokemon.append(poke)
            }
        
        }catch let err as NSError {
            print(err.debugDescription)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeViewCell {
            
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: 115, height: 109)
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            sender.alpha = 0.2
        }else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }

    
    
}

