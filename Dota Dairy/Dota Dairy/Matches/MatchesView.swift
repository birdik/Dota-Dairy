//
//  MatchesView.swift
//  Dota Dairy
//
//  Created by birdik on 13.06.2024.
//

import SwiftUI

struct MatchesView: View {
    @AppStorage("victories") private var victories = ""
    @AppStorage("defeats") private var defeats = ""
    @StateObject var viewModel = MatchesViewModel()
    
    var body: some View {
        ZStack {
            Color.color1
                .ignoresSafeArea()
            VStack {
                HStack {
                    VStack{
                        Spacer()
                        Text("Matches")
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
                        HStack {
                            Text("Satistics")
                                .font(.title3)
                            Spacer()
                        }
                        .padding([.horizontal, .top])
                        
                        HStack{
                            VStack (alignment: .leading){
                                Text("Victories")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                TextField("", text: $victories)
                                    .placeholder(when: victories.isEmpty) {
                                        Text("-----").foregroundColor(.white)
                                    }
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .keyboardType(.numberPad)
                            }
                            .padding()
                            .background(Color.color1)
                            .cornerRadius(10)
                            
                            Spacer()
                            Spacer()
                            
                            VStack (alignment: .leading) {
                                Text("Defeats")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                TextField("-----", text: $defeats)
                                    .placeholder(when: defeats.isEmpty) {
                                        Text("-----").foregroundColor(.white)
                                    }
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            .padding()
                            .background(Color.color1)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Matches")
                                .font(.title3)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        ZStack {
                            if viewModel.matches.isEmpty {
                                VStack {
                                    Text("Empty")
                                        .foregroundColor(.color1)
                                        .font(.title2.bold())
                                    Text("You don’t have any matches yet")
                                        .foregroundColor(.color1)
                                        .font(.footnote)
                                }
                            } else {
                                ScrollView {
                                    LazyVStack {
                                        ForEach(viewModel.matches, id: \.self) { match in
                                            Button {
                                                viewModel.onDetail(match: match)
                                            } label: {
                                                SwipeableMatchView(match: match, onDelete: {
                                                    viewModel.deleteMatch(match: match)
                                                })
                                            }
                                        }
                                    }
                                }
                            }
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button {
                                        viewModel.isShowingAddMatch = true
                                    } label: {
                                        Image("plus")
                                            .frame(width: 40, height: 40)
                                    }
                                }
                            }
                            .padding()
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMatches()
        }
        .fullScreenCover(isPresented: $viewModel.isShowingAddMatch, content: {
            MatchesViewAdd(viewModel: viewModel)
        })
        .fullScreenCover(isPresented: $viewModel.isShowingDetailMatch, content: {
            MatchesDetailView(viewModel: viewModel)
        })
    }
}

#Preview {
    MatchesView()
}


struct SwipeableMatchView: View {
    @State private var offset: CGFloat = 0
    @State private var isSwiping = false
    var match: MatchesModel
    var onDelete: () -> Void

    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: onDelete) {
                    VStack {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                    }
                    .frame(maxHeight: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                }
                .padding(.trailing)
            }
            .padding(.bottom, 4)
            
            HStack {
                HStack {
                    VStack {
                        Text("W")
                            .font(.title3)
                            .foregroundColor(Color.w)
                    }
                    .padding(4)
                    .background(match.gameResult ? Color.wView : Color.color2)
                    .cornerRadius(4)
                    .padding(.leading)
                    Spacer()
                    VStack {
                        Text("\(match.gameDate ?? "")" + ", \(match.gameTime ?? "")")
                            .lineLimit(1)
                            .foregroundColor(Color.color2)
                            .font(.caption)
                            .padding(.top)
                        Text(match.gameName ?? "")
                            .font(.title3)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        HStack {
                            VStack {
                                Text(match.gameType ?? "")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 7)
                            .background(Color.color2)
                            .cornerRadius(5)
                            
                            VStack {
                                Text(match.gameDuration ?? "")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 7)
                            .background(Color.color2)
                            .cornerRadius(4)
                            
                            VStack {
                                Text(match.yourKDA ?? "")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 7)
                            .background(Color.color2)
                            .cornerRadius(4)
                        }
                        .padding(.bottom)
                    }
                    Spacer()
                    VStack {
                        Text("L")
                            .font(.title3)
                            .foregroundColor(Color.l)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(match.gameResult ? Color.color2 : Color.lView)
                    .cornerRadius(4)
                    .padding(.trailing)
                }
                .background(Color.color)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 4)
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width < 0 { // Swipe left
                                self.offset = value.translation.width
                                self.isSwiping = true
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -100 {
                                self.offset = -90
                            } else {
                                self.offset = 0
                                self.isSwiping = false
                            }
                        }
                )
            }
            .animation(.spring(), value: offset)
        }
    }
    
}
