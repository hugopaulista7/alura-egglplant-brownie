//
//  RefeicaoDao.swift
//  eggplant-brownie
//
//  Created by Hugo Paulista on 23/05/22.
//

import Foundation

class RefeicaoDao {
    func save(_ refeicoes: Array<Refeicao>) {
        guard let caminho = getCaminho() else { return }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCaminho() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return diretorio.appendingPathComponent("refeicao")
    }
    
    func get() -> Array<Refeicao> {
        guard let caminho = getCaminho() else { return [] }
        
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else { return [] }
            return refeicoesSalvas
        } catch {
            print(error.localizedDescription)
            
            return []
        }
    }
}
