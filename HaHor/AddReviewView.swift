//
//  AddReviewView.swift
//  HaHor
//
//  Created by bell on 10/5/2568 BE.
//

import SwiftUI
import FirebaseFirestore

struct AddReviewView: View {
    var dorm: Dorm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: UserProfileViewModel

    @State private var star: Int = 5
    @State private var comment: String = ""
    @State private var displayAsAnonymous: Bool = false
    @State private var isSubmitting: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Rating")) {
                    Picker("Stars", selection: $star) {
                        ForEach(1...5, id: \.self) { i in
                            Text("\(i) ⭐️").tag(i)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section(header: Text("Comment")) {
                    TextEditor(text: $comment)
                        .frame(minHeight: 100)
                }

//                Section {
//                    Toggle("Hide my name (post as anonymous)", isOn: $displayAsAnonymous)
//                }

                Section {
                    if isSubmitting {
                        ProgressView()
                    } else {
                        Button("Submit Review") {
                            Task {
                                await submitReview()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    @MainActor
    private func submitReview() async {
        guard !comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        isSubmitting = true

        let username = viewModel.user?.username ?? "Unknown"

        let reviewEntry: [String: Any] = [
            "star": star,
            "comment": comment,
            "by": username,
            "displayAsAnonymous": displayAsAnonymous,
            "timestamp": Timestamp(date: Date())
        ]

        do {
            let dormRef = Firestore.firestore().collection("dorm").document(dorm.id)

            // 1. Add the new review
            try await dormRef.updateData([
                "review": FieldValue.arrayUnion([reviewEntry])
            ])

            // 2. Get updated review list
            let snapshot = try await dormRef.getDocument()
            if let data = snapshot.data(),
               let reviews = data["review"] as? [[String: Any]] {

                // 3. Recalculate average & count
                let totalStars = reviews.compactMap { $0["star"] as? Int }.reduce(0, +)
                let count = reviews.count
                let avg = Double(totalStars) / Double(count)

                // 4. Update avg_review and review_count
                try await dormRef.updateData([
                    "avg_review": Double(round(avg * 100) / 100), // round to 2 decimal places
                    "review_count": count
                ])
            }

            isSubmitting = false
            dismiss()
        } catch {
            print("❌ Error saving review: \(error.localizedDescription)")
            isSubmitting = false
        }
    }

}
