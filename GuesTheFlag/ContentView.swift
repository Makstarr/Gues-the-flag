//
//  ContentView.swift
//  GuesTheFlag
//
//  Created by Максим on 29.01.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import SwiftUI

struct FlagImg: View {
    
    var number: Int
    var names: [String]
    var body: some View {
        Image(names[number])
        .renderingMode(.original)
        .clipShape(RoundedRectangle(cornerRadius: 200))
            .overlay(RoundedRectangle(cornerRadius: 200)
                .stroke(Color.black,lineWidth:2))
        .shadow(color: .black, radius:3)
        .clipShape(RoundedRectangle(cornerRadius: 200))
        .opacity(1)
    }
}
struct ContentView: View {
    @State private var Score = 0
    @State private var showingScore = false
    @State private var titleScore = ""
    @State private var countries = ["Russia","Germany","Estonia","Poland","France","Ireland","Italy","Nigeria","UK","US","Spain"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var enabled = [0.0,0.0,0.0]
    @State private var padding: [CGFloat] = [0,0,0]
    @State private var opasity = [0.25,0.25,0.25]
    var body: some View {
        print(self.titleScore)
        print(enabled)
        return ZStack{
           
            AngularGradient(gradient: Gradient(colors: [.red, .yellow,.red]), center: .topTrailing).edgesIgnoringSafeArea(.all)
            VStack(spacing:20){
                VStack(spacing:20){
                    Spacer()
                    Text("Score: \(Score)")
                                   .foregroundColor(.white)
                                   .font(.largeTitle)
                                   .fontWeight(.bold)
                                   .shadow(color: .black, radius:2)
                   Spacer()
                    Text("Tap the flag of...")
                        .foregroundColor(.white)
                        .shadow(color: .black, radius:2)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(color: .black, radius:2)
                }
            
                ForEach(0..<3){ number in Button(action:{
                    self.flagTappeg(number)
    
                    
                })
               {
                    FlagImg(number:number,names:self.countries)
                    .padding(.leading,self.padding[number])
                    .opacity(self.showingScore&&number != self.correctAnswer ? 0.25 : 1)
                    
                    }
              
                  .rotation3DEffect(.degrees(self.enabled[number]), axis: (x: 0, y: 1, z: 0))
               
                
                }
                Spacer()
            }
            
        }.alert(isPresented: $showingScore){
            Alert(title:Text(titleScore), message: Text("Your score is \(Score)"), dismissButton: .default(Text("Continue")){
                self.padding = [0,0,0]
                self.enabled = [0.0,0.0,0.0]
                self.shuffle()
                
                })
        }
    }
    func flagTappeg(_ number:Int){
        if number == correctAnswer{
            titleScore = "Correct"
            Score+=1
            withAnimation{
                enabled[number]+=360
                
            }
                

        }
        else{
            titleScore = "Wrong! That’s the flag of \(countries[number])"
            withAnimation(.easeIn){
                padding[number]+=1000
                
            }
                           

                   }
        showingScore = true
        
    }
    func shuffle(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

