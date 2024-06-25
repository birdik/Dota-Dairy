//
//  StatisticsView.swift
//  Dota Dairy
//
//  Created by birdik on 13.06.2024.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @AppStorage("victories") private var victories = ""
    @AppStorage("defeats") private var defeats = ""
    @AppStorage("endTour") private var endTour = "0"
    @StateObject private var viewModel = StatisticViewModel()
    @State private var chooseHero = ""
    
    
    
    var body: some View {
        ZStack {
            Color.color1
                .ignoresSafeArea()
            VStack {
                HStack {
                    VStack{
                        Spacer()
                        Text("Statistics")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .frame(height: 40)
                    Spacer()
                }
                .padding(.horizontal)
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    VStack {
                        if !viewModel.matches.isEmpty {
                            VStack {
                                HStack {
                                    Text("Total games played -")
                                        .foregroundColor(.white)
                                    if viewModel.calcHeroDonatChat.count == 1 {
                                        Text("One hero")
                                    } else {
                                        Text("\(viewModel.calcHeroDonatChat.count.spelledOut?.capitalized ?? "Two") heroes")
                                    }
                                }
                                .padding([.horizontal, .top])
                                chartDonutView
                                    .frame(width: 180, height: 216)
                                Menu {
                                    ScrollView {
                                        Button ("Total games") {
                                            chooseHero = ""
                                        }
                                        ForEach(viewModel.heroFrequency.sorted(by: >), id: \.key) { key, value in
                                            Button(key) {
                                                chooseHero = key
                                            }
                                        }
                                    }
                                    .frame(height: 200)
                                } label: {
                                    Text(chooseHero.isEmpty ? "Choose hero" : chooseHero)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 40)
                                        .background(Color.white.opacity(0.5))
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: 1)
                                        )
                                }
                                .padding([.horizontal, .bottom])
                            }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.color)
                            .cornerRadius(10)
                            .padding([.horizontal, .top])
                        }

                        HStack {
                            VStack {
                                Text(victories == "" ? "0" : victories)
                                    .foregroundColor(.green)
                                    .font(.headline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                Text("Total wins")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.color)
                            .cornerRadius(10)
                            
                            VStack (alignment: .leading) {
                                Text(defeats == "" ? "0" : defeats)
                                    .foregroundColor(.red)
                                    .font(.headline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                Text("Total defeats")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.color)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.top, viewModel.matches.isEmpty ? 20 : 10)
                        
                        HStack{
                            VStack {
                                Text("\(viewModel.tournaments.count)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                Text("Added tournaments")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.color)
                            .cornerRadius(10)
                            
                            VStack (alignment: .leading) {
                                TextField("", text: $endTour)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .keyboardType(.numberPad)
                                Text("Ended tournaments")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.color)
                            .cornerRadius(10)
                        }
                        .padding([.horizontal])
                        .padding(.top, 5)
                        
                        HStack{
                            VStack {
                                if viewModel.matches.isEmpty {
                                    Text("-----")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                } else {
                                    Text(viewModel.mostFrequentHero)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                }
                                Text("Most played hero")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.color)
                            .cornerRadius(10)
                            
                            VStack (alignment: .leading) {
                                if viewModel.matches.isEmpty {
                                    Text("-----")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                } else {
                                    Text(viewModel.mostFrequentPosition)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                }

                                Text("Most played position")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.color)
                            .cornerRadius(10)
                        }
                        .padding([.horizontal])
                        .padding(.top, 5)
                        
                        Spacer()
                        
                        List {}
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetch()
            viewModel.mostFrequentFunc()
            viewModel.calcOfPath()
        }
    }
}

#Preview {
    StatisticsView()
}


extension StatisticsView {
    private var chartDonutView: some View {
        ZStack {
            ForEach(0..<viewModel.calcHeroDonatChat.count, id: \.self) { index in
                Circle()
                    .trim(from: index == 0 ? 0.0 : viewModel.calcHeroDonatChat[index - 1],
                          to: viewModel.calcHeroDonatChat[index])
                    .stroke(Color.random, lineWidth: 15)
                    .scaleEffect(1.0)
                    .animation(.spring())
            }
            VStack {
                Text("Games")
                    .foregroundColor(.white.opacity(0.5))
                Text(chooseHero.isEmpty ? "\(viewModel.matches.count)" : "\(viewModel.heroFrequency[chooseHero] ?? 0)")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
    }
    
}

extension Color {
    static var random: Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}

extension NumberFormatter {
    static let spelled: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }()
}

extension Numeric {
    var spelledOut: String? { NumberFormatter.spelled.string(for: self) }
}
