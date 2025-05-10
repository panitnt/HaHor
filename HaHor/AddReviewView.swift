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

        // Safe unwrapping of user data
        let username = viewModel.user?.username ?? "Unknown"

        // Build review dictionary (safe to pass across await in Swift 6)
        let reviewEntry: [String: Any] = [
            "star": star,
            "comment": comment,
            "by": username,
            "displayAsAnonymous": displayAsAnonymous,
            "timestamp": Timestamp(date: Date())
        ]

        do {
            let dormRef = Firestore.firestore().collection("dorm").document(dorm.id)
            try await dormRef.updateData([
                "review": FieldValue.arrayUnion([reviewEntry])
            ])
            isSubmitting = false
            dismiss()
        } catch {
            print("❌ Error saving review: \(error.localizedDescription)")
            isSubmitting = false
        }
    }
}
