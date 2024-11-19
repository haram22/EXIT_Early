//
//  SelectLimitAppVMSU.swift
//  Sabotage
//
//  Created by 김하람 on 12/28/23.
//

import Foundation
import SwiftUI
import FamilyControls

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var settingIndex = 0
    @State var selection = FamilyActivitySelection()
    @State private var isPresented = false
    
    private let columns = [
        GridItem(.fixed(56)),
        GridItem(.fixed(56)),
        GridItem(.fixed(56)),
        GridItem(.fixed(56)),
        GridItem(.fixed(56))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            SelectAppContainerView()
            Spacer()
        }
        .background(.base50, ignoresSafeAreaEdges: .all)
        .onAppear() {
            selection = ScreenTimeVM.shared.selectionToDiscourage
        }
    }
}

extension DetailView {
    
    private func SelectAppContainerView() -> some View {
        // TODO::Pick interface
        // VERSION 1
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text("제한 중인 앱 목록")
                    .font(.caption1())
                    .foregroundColor(.base300)
                Spacer()
                Button("Edit") { isPresented = true }
                    .familyActivityPicker(
                        isPresented: $isPresented,
                        selection: $selection)
                    .font(.subheadline)
                    .foregroundColor(.primary700)
                    .padding(.horizontal, 10.0)
                    .padding(.vertical, 4.0)
                    .background(.base50)
                    .border(.white, width: 0)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 0.40)
            // 앱 아이콘 나오는 부분
            SelectedAppListView()
        }
    }
    func SelectedAppListView() -> some View {
        VStack {
            if (selection.applicationTokens.count > 0 || selection.categoryTokens.count > 0) {
                LazyVGrid(columns: columns, alignment: .leading){
                    if selection.applicationTokens.count > 0 {
                        ForEach(Array(selection.applicationTokens), id: \.self) {
                            token in
                            HStack {
                                Label(token)
                                    .labelStyle(.iconOnly)
                                    .scaleEffect(2.5)
                            }
                            .frame(width: 56, height: 56)
                        }
                    }
                    if selection.categoryTokens.count > 0 {
                        ForEach(Array(selection.categoryTokens), id: \.self) {
                            token in
                            HStack {
                                Label(token)
                                    .labelStyle(.iconOnly)
                                    .scaleEffect(1.8)
                            }
                            .frame(width: 56, height: 56)
                        }
                    }
                }
                .padding(0.6)
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(Color.blue)
                .cornerRadius(16)
            } else {
                HStack{
                    Text("Edit 버튼을 눌러 제한할 앱을 추가해주세요")
                        .font(.system(size: 12))
                        .foregroundColor(.base400)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color.white)
                        .cornerRadius(16)
                    Spacer()
                }
                
            }
        }
        .padding(.top, 0.50)
        .padding(.horizontal, 0.50)
    }
}

extension DetailView {
    private func handleSavePlan() {
        ScreenTimeVM.shared.selectionToDiscourage = selection
        
        dismiss()
    }
}
