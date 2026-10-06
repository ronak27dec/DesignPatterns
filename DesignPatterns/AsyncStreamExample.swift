//
//  AsyncStreamExample.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 29/12/25.
//

import SwiftUI
import Combine

class DataProvider {
    func provideDataArray(onCompletion: @escaping (Int) -> (Void)) {
        let nums: [Int] = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
        for num in nums {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(num)) {
                onCompletion(num)
            }
        }
    }
    
    // MARK: Async Stream method
    func provideAsyncStreamData() -> AsyncStream<Int> {
        let nums: [Int] = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
        return AsyncStream { continuation in
            for num in nums {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(num)) {
                    continuation.yield(num)
                }
            }
            continuation.finish()
        }
    }
}


@MainActor
class ContentViewModel: ObservableObject {
    let provider = DataProvider()
    @Published var number: Int = 0
    
    func fetchNumbers() {
        provider.provideDataArray {[weak self] num in
            self?.number = num
        }
    }
    
    func fetchAsyncStreamNumbers() async {
        for await value in provider.provideAsyncStreamData() {
            number = value
        }
    }
}

struct AsyncStreamExample: View {
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.number)")
        }
        .padding()
        .onAppear {
            //vm.fetchNumbers()
        }
        .task {
            await vm.fetchAsyncStreamNumbers()
        }
    }
}
