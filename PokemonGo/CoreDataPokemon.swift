//
//  CoreDataPokemon.swift
//  PokemonGo
//
//  Created by Catia Miranda de Souza on 17/11/19.
//  Copyright © 2019 Catia Miranda de Souza. All rights reserved.
//

import UIKit
import  CoreData

class CoreDataPokemon{
    
    //RECUPERER CONTEXTO
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        return context!
    }
    //ADICIONAR POKEMONS
    
    func adicionarTodosPokemons(){
        
        let context = self.getContext()
        self.criarPokemons(nome: "Bellsprout", nomePOkemon: "bellsprout", capturado: false)
        self.criarPokemons(nome: "Bullbasaur", nomePOkemon: "bullbasaur", capturado: false)
        self.criarPokemons(nome: "Caterpie", nomePOkemon: "caterpie", capturado: true)
        self.criarPokemons(nome: "Charmander", nomePOkemon: "charmander", capturado: false)
        self.criarPokemons(nome: "Compass", nomePOkemon: "compass", capturado: false)
        self.criarPokemons(nome: "Map", nomePOkemon: "map", capturado: true)
        self.criarPokemons(nome: "Meowth", nomePOkemon: "meowth", capturado: false)
        self.criarPokemons(nome: "Mew", nomePOkemon: "mew", capturado: false)
        self.criarPokemons(nome: "Psyduck", nomePOkemon: "psyduck", capturado: false)
        
        do{
            try context.save()
        }catch{}
    }
    //CRIAR POKOEMONS
    func criarPokemons(nome: String, nomePOkemon: String, capturado: Bool){
        let context  = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomePOkemon = nomePOkemon
        pokemon.capturado = capturado
    }
    func recuperarTodosPokemons() -> [Pokemon]{
        let context = self.getContext()
        
        do {
          let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
            
            if pokemons.count == 0{
                self.adicionarTodosPokemons()
                return self.recuperarTodosPokemons()
            }
            return pokemons
        } catch  {
            
        }
        return []
    }
}
