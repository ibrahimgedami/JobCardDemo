//
//  JobCardDetailsView.swift
//  SwiftUI_ImageLoader
//
//  Created by Ibrahim Mo Gedami on 9/24/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct JobCardDetailsView: View {
    
    var viewModel: JobCardDetailViewModelProtocol?
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 2.0
    @StateObject var toggleViewModel = StackViewModel()
    
    init(viewModel: JobCardDetailViewModelProtocol? = nil) {
        self.viewModel = viewModel
    }
    
    func gridSwitch(){
        gridLayout = Array(repeating: GridItem(.flexible()), count: Int(gridColumn))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        toggleButton
                    }//HStack
                    if let data = viewModel?.getJobCardDetails {
                        gridItemView
                        Spacer().frame(height: 20)
                        Divider()
                        Spacer().frame(height: 20)
                        HorizontalGridView(imageUrls: data.images ?? [])
                    } else {
                        EmptyView()
                    }
                }//VStack
            }//ScrollView
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }//NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .padding()
    }// body
    
    var gridItemView: some View {
        VStack(alignment: .center, spacing: 40) {
            Text("JobCard")
                .font(.title)
                .bold()
                .padding(.bottom, 10)
            
            HStack {
                Spacer()
                HStack{
                    Text("JobCard No. #")
                        .font(.headline)
                        .foregroundColor(.brown)
                    Text("31402983")
                        .font(.subheadline)
                }//HStack
                Spacer()
            }//HStack
            
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                JobCardRowView(key: "Customer Name", value: viewModel?.getJobCardDetails.customerName ?? "")
                    .environmentObject(toggleViewModel)
                JobCardRowView(key: "Customer Phone", value: viewModel?.getJobCardDetails.jobCardNumber ?? "")
                    .environmentObject(toggleViewModel)
                JobCardRowView(key: "Date", value: viewModel?.getJobCardDetails.date ?? "")
                    .environmentObject(toggleViewModel)
                JobCardRowView(key: "Purchase Date", value: viewModel?.getJobCardDetails.purchaseDate ?? "")
                    .environmentObject(toggleViewModel)
                JobCardRowView(key: "Brand", value: viewModel?.getJobCardDetails.brand ?? "")
                    .environmentObject(toggleViewModel)
                JobCardRowView(key: "Model Code", value: viewModel?.getJobCardDetails.modelCode ?? "")
                    .environmentObject(toggleViewModel)
                JobCardRowView(key: "JobCard Serial", value: viewModel?.getJobCardDetails.jobCardSerial ?? "")
                    .environmentObject(toggleViewModel)
            }//LazyVGrid
            .onAppear {
                gridSwitch()
            }
        }//VStack
        .padding(.horizontal, 0)
        .padding(.vertical, 8)
    }
    
    var toggleButton: some View {
        Button(action: {
            withAnimation {
                toggleViewModel.isVertical.toggle()
            }
        }) {
            Image(systemName: toggleViewModel.isVertical ? "square.grid.2x2.fill" : "list.bullet.rectangle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(8)
                .background(Color(hex: "#613F1A"))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct JobCardRowView: View {
    
    var key: String
    var value: String
    @EnvironmentObject var toggleViewModel: StackViewModel
    
    var body: some View {
        Group {
            if(toggleViewModel.isVertical) {
                VStack{
                    Text(key)
                        .font(.headline)
                        .foregroundColor(.brown)
                    //            Spacer().frame(width: 20)
                    Text(value)
                        .font(.subheadline)
                }//VStack
                .padding(.bottom, 8)
            } else {
                HStack{
                    Text(key)
                        .font(.headline)
                        .foregroundColor(.brown)
                    //            Spacer().frame(width: 20)
                    Text(value)
                        .font(.subheadline)
                }//HStack
                .padding(.bottom, 8)
            }
        }//Group
    }
}


class StackViewModel: ObservableObject {
    @Published var isVertical = false
}
