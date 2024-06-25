//
//  MatchesViewModel.swift
//  Dota Dairy
//
//  Created by birdik on 13.06.2024.
//

import SwiftUI
import CoreData

final class MatchesViewModel: ObservableObject {
    
    @Published var matches: [MatchesModel] = []
    @Published var match: MatchesModel?
    
    @Published var isShowingAddMatch = false
    @Published var isShowingDetailMatch = false
    
    @Published var gameName = ""
    @Published var gameDate = ""
    @Published var gameTime = ""
    @Published var gameType = ""
    @Published var position = ""
    @Published var gameDuration = ""
    @Published var playedHero = ""
    @Published var yourKDA = ""
    @Published var gameResult: Bool?
    
    func fetchMatches() {
        let context = CoreDatas.shared.container.viewContext
        let fetchRequest = NSFetchRequest<MatchesModel>(entityName: "MatchesModel")
        
        do {
            matches = try context.fetch(fetchRequest)
        } catch {
            matches = []
        }
    }
    
    func addMatch() {
        let context = CoreDatas.shared.container.viewContext
        let match = NSEntityDescription.insertNewObject(forEntityName: "MatchesModel", into: context) as! MatchesModel
        
        match.gameName = gameName
        match.gameDate = gameDate
        match.gameTime = gameTime
        match.gameType = gameType
        match.position = position
        match.gameDuration = gameDuration
        match.playedHero = playedHero
        match.yourKDA = yourKDA
        match.gameResult = gameResult ?? false
        
        CoreDatas.shared.save()
        clear()
    }
    
    func clear() {
        gameName = ""
        gameDate = ""
        gameTime = ""
        gameType = ""
        position = ""
        gameDuration = ""
        playedHero = ""
        yourKDA = ""
        gameResult = nil
    }
    
    func deleteMatch(match: MatchesModel?) {
        guard let match else { return }
        let context = CoreDatas.shared.container.viewContext
        context.delete(match)
        CoreDatas.shared.save()
        fetchMatches()
    }
    
    func onDetail(match: MatchesModel?) {
        guard let match else { return }
        self.match = match
        onDetailMatch()
        isShowingDetailMatch = true
    }
    
    func onDetailMatch() {
        gameName = match?.gameName ?? ""
        gameDate = match?.gameDate ?? ""
        gameTime = match?.gameTime ?? ""
        gameType = match?.gameType ?? ""
        position = match?.position ?? ""
        gameDuration = match?.gameDuration ?? ""
        playedHero = match?.playedHero ?? ""
        yourKDA = match?.yourKDA ?? ""
        gameResult = match?.gameResult ?? false
    }
    
    
    func saveChangeMatch() {
        match?.gameName = gameName
        match?.gameDate = gameDate
        match?.gameTime = gameTime
        match?.gameType = gameType
        match?.position = position
        match?.gameDuration = gameDuration
        match?.playedHero = playedHero
        match?.yourKDA = yourKDA
        match?.gameResult = gameResult ?? false
        CoreDatas.shared.save()
    }
}
