//
//  FullScreenModifier.swift
//  Interval Timer | HIIT
//
//  Created by Kunli Zhang on 27/04/22.
//

import SwiftUI
import UIKit

struct FullScreenModifier<Parent: View>: View {
    @Binding var isPresented: Bool
    @State var adType: AdType
    
    //Select adType
    enum AdType {
        case interstitial
        case rewarded
    }
    
    var rewardFunc: () -> Void
    var adUnitId: String
  
    //The parent is the view that you are presenting over
    //Think of this as your presenting view controller
    var parent: Parent
    
    var body: some View {
        ZStack {
            parent
            
            if isPresented {
                EmptyView()
                    .edgesIgnoringSafeArea(.all)
                
                if adType == .interstitial {
                    InterstitialAdView(isPresented: $isPresented, adUnitId: adUnitId)
                }
            }
        }
        .onAppear {
            //Initialize the ads as soon as the view appears
            if adType == .interstitial {
                InterstitialAd.shared.loadAd(withAdUnitId: adUnitId)
            }
        }
    }
}

extension View {
    public func presentInterstitialAd(isPresented: Binding<Bool>, adUnitId: String) -> some View {
        FullScreenModifier(isPresented: isPresented, adType: .interstitial, rewardFunc: {}, adUnitId: adUnitId, parent: self)
    }
}
