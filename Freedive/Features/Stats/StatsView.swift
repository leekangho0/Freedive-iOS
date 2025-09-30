//
//  StatsView.swift
//  Freedive
//
//  Created by Kanghos on 9/25/25.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack {
                    Text("Your Stats")
                        .font(.largeTitle)

                    Text("Personal records and achievements")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                HStack {
                    CardView(icon: "wave", value: "1", description: "Total Dives")

                    CardView(icon: "wave", value: "1", description: "Total Dives")
                }

                HStack {
                    CardView(icon: "wave", value: "1", description: "Total Dives")

                    CardView(icon: "wave", value: "1", description: "Total Dives")
                }

                Text("Preferences")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 150)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                    .padding(.horizontal)
            }
        }
    }
}

struct CardView: View {
    let icon: String
    let value: String
    let description: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "water.waves")
                .foregroundStyle(Color.indigo)

            Text(value)

            Text(description)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .stroke(Color.gray, lineWidth: 1)
        }
    }
}

#Preview {
    StatsView()
}
