//
//  StatisticViewModel.swift
//  Dota Dairy
//
//  Created by birdik on 14.06.2024.
//

import SwiftUI
import CoreData

class StatisticViewModel: ObservableObject {
    @Published var matches: [MatchesModel] = []
    @Published var tournaments: [TournamentsModel] = []
    
    @Published var mostFrequentHero = ""
    @Published var mostFrequentPosition = ""
    
    @Published var heroFrequency: [String: Int] = [:]
    @Published var calcHeroDonatChat: [CGFloat] = []
    
    func fetch() {
        let context = CoreDatas.shared.container.viewContext
        let fetchRequestTournaments = NSFetchRequest<TournamentsModel>(entityName: "TournamentsModel")
        let fetchRequestMatches = NSFetchRequest<MatchesModel>(entityName: "MatchesModel")
        
        
        do {
            tournaments = try context.fetch(fetchRequestTournaments)
            matches = try context.fetch(fetchRequestMatches)
        } catch {
            tournaments = []
            matches = []
        }
    }
    
    func mostFrequentFunc () {
        var positionFrequency: [String: Int] = [:]
        for match in matches {
            heroFrequency[match.playedHero ?? "", default: 0] += 1
            positionFrequency[match.position ?? "", default: 0] += 1
        }
        if let mostFrequentHero = heroFrequency.max(by: { $0.value < $1.value })?.key {
            self.mostFrequentHero = mostFrequentHero
        } else {
            if matches.isEmpty {
                mostFrequentHero = ""
            } else {
                mostFrequentHero = matches[0].playedHero ?? ""
            }
        }
        if let mostFrequentPosition = positionFrequency.max(by: { $0.value < $1.value })?.key {
            self.mostFrequentPosition = mostFrequentPosition
        } else {
            if matches.isEmpty {
                mostFrequentPosition = ""
            } else {
                mostFrequentPosition = matches[0].position ?? ""
            }
        }
    }
    
    func calcOfPath() {
        var value: CGFloat = 0
                
        for hero in heroFrequency {
            value += CGFloat(hero.value) / CGFloat(matches.count)
            calcHeroDonatChat.append(value)
        }
    }
    
    
}


