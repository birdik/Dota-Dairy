//
//  MatchesViewAdd.swift
//  Dota Dairy
//
//  Created by birdik on 12.06.2024.
//

import SwiftUI

struct MatchesViewAdd: View {
    @Environment(\.presentationMode) var router
    @ObservedObject var viewModel: MatchesViewModel
    
    let gameTypes = ["Ranked","Normal"]
    
    
    var body: some View {
        ZStack {
            Color.color1.ignoresSafeArea()
            
            VStack {
                ZStack {
                    Text("Add match")
                        .foregroundColor(.white)
                        .font(.headline)
                    HStack {
                        Button {
                            viewModel.clear()
                            router.wrappedValue.dismiss()
                        } label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.color)
                                    .font(.headline)
                                
                                Text("Back")
                                    .foregroundColor(.color)
                                    .font(.headline)
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding([.horizontal])
                
                ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    VStack {
                        VStack {
                            
                            TextField("", text: $viewModel.gameName)
                                .placeholder(when: viewModel.gameName.isEmpty) {
                                    Text("Game name").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding([.horizontal, .top])
                                .padding(.bottom, 3)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.gameDate)
                                .placeholder(when: viewModel.gameDate.isEmpty) {
                                    Text("Game date").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.gameTime)
                                .placeholder(when: viewModel.gameTime.isEmpty) {
                                    Text("Game time").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding([.horizontal, .bottom])
                                .padding(.top, 3)
                        }
                        .background(Color.color)
                        .cornerRadius(10)
                        .padding()
                        .padding(.top, 10)
                        
                        VStack {
                            Menu {
                                Button ("Ranked") {
                                    viewModel.gameType = "Ranked"
                                }
                                Button ("Normal") {
                                    viewModel.gameType = "Normal"
                                }
                            } label: {
                                Text(viewModel.gameType.isEmpty ? "Game type": viewModel.gameType)
                                    .foregroundColor(viewModel.gameType.isEmpty ? .white.opacity(0.5) : .white)
                                Spacer()
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundColor(viewModel.gameType.isEmpty ? .white.opacity(0.5) : .white)
                            }
                            .padding([.horizontal, .top])
                            .padding(.bottom, 3)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.position)
                                .placeholder(when: viewModel.position.isEmpty) {
                                    Text("Position").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.gameDuration)
                                .placeholder(when: viewModel.gameDuration.isEmpty) {
                                    Text("Game duration").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.playedHero)
                                .placeholder(when: viewModel.playedHero.isEmpty) {
                                    Text("Played hero").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.yourKDA)
                                .placeholder(when: viewModel.yourKDA.isEmpty) {
                                    Text("Your KDA").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding([.horizontal, .bottom])
                                .padding(.top, 3)
                            
                        }
                        .background(Color.color)
                        .cornerRadius(10)
                        .padding([.horizontal])
                        
                        VStack {
                            Button {
                                viewModel.gameResult = true
                            } label: {
                                HStack {
                                    Text("Win")
                                        .font(.body)
                                        .foregroundColor(viewModel.gameResult == nil ? .white.opacity(0.5) : .white)
                                    Spacer()
                                    Image(systemName: viewModel.gameResult ?? false ? "square.fill" : "square")
                                        .foregroundColor(viewModel.gameResult == nil ? .white.opacity(0.5) : .white)
                                }
                                .padding([.horizontal, .top])
                                .padding(.bottom, 3)
                            }
                            
                            Divider().background(Color.white)
                            
                            Button {
                                viewModel.gameResult = false
                            } label: {
                                HStack {
                                    Text("Lose")
                                        .font(.body)
                                        .foregroundColor(viewModel.gameResult == nil ? .white.opacity(0.5) : .white)
                                    Spacer()
                                    if let gameResult = viewModel.gameResult {
                                        Image(systemName: gameResult ? "square" : "square.fill")
                                            .foregroundColor(.white)
                                    } else {
                                        Image(systemName: "square")
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                }
                                .padding([.horizontal, .bottom])
                                .padding(.top, 3)
                            }
                            

                        }
                        .background(Color.color)
                        .cornerRadius(10)
                        .padding()
                        
                        Spacer()
                        
                        
                        Button {
                            viewModel.addMatch()
                            viewModel.fetchMatches()
                            viewModel.clear()
                            router.wrappedValue.dismiss()
                        } label: {
                            Text("Add")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.color1)
                                .cornerRadius(16)
                        }
                        .padding([.horizontal, .bottom])
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    MatchesViewAdd(viewModel: MatchesViewModel())
}

