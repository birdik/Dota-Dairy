//
//  MatchesDetailView.swift
//  Dota Dairy
//
//  Created by birdik on 14.06.2024.
//

import SwiftUI

struct MatchesDetailView: View {
    @Environment(\.presentationMode) var router
    @State private var edit = false
    
    @ObservedObject var viewModel: MatchesViewModel
    
    let gameTypes = ["Ranked","Normal"]
    var body: some View {
        ZStack {
            Color.color1.ignoresSafeArea()
            
            VStack {
                ZStack {
                    Text(edit ? "Edit" : viewModel.match?.gameName ?? "")
                        .foregroundColor(.white)
                        .font(.headline)
                    HStack {
                        Button {
                            viewModel.clear()
                            viewModel.fetchMatches()
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
                        
                        HStack {
                            Button {
                                edit.toggle()
                                viewModel.onDetailMatch()
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.color)
                                    .font(.headline)
                            }
                            .padding(.trailing, 8)
                            
                            
                            Button {
                                viewModel.deleteMatch(match: viewModel.match)
                                viewModel.clear()
                                viewModel.fetchMatches()
                                router.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                                    .font(.headline)
                            }
                        }
                    }
                }
                .padding([.horizontal])
                
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    VStack {
                        if !edit {
                            VStack (alignment: .leading){
                                
                                Text(viewModel.match?.gameName ?? "")
                                    .foregroundColor(.white)
                                    .padding([.horizontal, .top])
                                    .padding(.bottom, 3)
                                
                                Divider().background(Color.white)
                                
                                Text(viewModel.match?.gameDate ?? "")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                Text(viewModel.match?.gameTime ?? "")
                                    .foregroundColor(.white)
                                    .padding([.horizontal, .bottom])
                                    .padding(.top, 3)
                            }
                            .background(Color.color)
                            .cornerRadius(10)
                            .padding()
                            .padding(.top, 10)
                            
                            VStack (alignment: .leading){
                                Text(viewModel.match?.gameType ?? "")
                                    .foregroundColor(.white)
                                    .padding([.horizontal, .top])
                                    .padding(.bottom, 3)
                                
                                Divider().background(Color.white)
                                
                                Text(viewModel.match?.position ?? "")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                Text(viewModel.match?.gameDuration ?? "")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                Text(viewModel.match?.playedHero ?? "")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                Text(viewModel.match?.yourKDA ?? "")
                                    .foregroundColor(.white)
                                    .padding([.horizontal, .bottom])
                                    .padding(.top, 3)
                                
                            }
                            .background(Color.color)
                            .cornerRadius(10)
                            .padding([.horizontal])
                            
                            VStack (alignment: .leading){
                                HStack {
                                    Text("Win")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: viewModel.gameResult ?? false ? "square.fill" : "square")
                                        .foregroundColor(.white)
                                }
                                .padding([.horizontal, .top])
                                .padding(.bottom, 3)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Lose")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: viewModel.gameResult ?? false ? "square" : "square.fill")
                                        .foregroundColor(.white)
                                }
                                .padding([.horizontal, .bottom])
                                .padding(.top, 3)
                                

                            }
                            .background(Color.color)
                            .cornerRadius(10)
                            .padding()
                            
                            Spacer()
                            
                        } else {
                            VStack {
                                
                                HStack {
                                    Text("Game name:")
                                        .foregroundColor(.white.opacity(0.5))
                                    TextField("", text: $viewModel.gameName)
                                        .foregroundColor(.white)
                                }
                                .padding([.horizontal, .top])
                                .padding(.bottom, 3)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Game date:")
                                        .foregroundColor(.white.opacity(0.5))
                                    TextField("", text: $viewModel.gameDate)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Game time:")
                                        .foregroundColor(.white.opacity(0.5))
                                    TextField("", text: $viewModel.gameTime)
                                        .foregroundColor(.white)
                                }
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
                                
                                HStack {
                                    Text("Position:")
                                        .foregroundColor(.white.opacity(0.5))
                                    TextField("", text: $viewModel.position)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Game duration:")
                                        .foregroundColor(.white.opacity(0.5))
                                    TextField("", text: $viewModel.gameDuration)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Played hero:")
                                        .foregroundColor(.white.opacity(0.5))
                                    TextField("", text: $viewModel.playedHero)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Your KDA:")
                                        .foregroundColor(.white.opacity(0.5))
                                    TextField("", text: $viewModel.yourKDA)
                                        .foregroundColor(.white)
                                }
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
                                viewModel.saveChangeMatch()
                                viewModel.fetchMatches()
                                edit = false
                            } label: {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.color1)
                                    .cornerRadius(16)
                            }
                            .padding([.horizontal, .bottom])
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                }
            }
        }
    }
}



