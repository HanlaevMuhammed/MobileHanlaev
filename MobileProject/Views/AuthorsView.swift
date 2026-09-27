//
//  AuthorsView.swift
//  MobileProject
//

import SwiftUI

struct AuthorsView: View {
    var body: some View {
        List(Author.sampleAuthors) { author in
            AuthorRow(author: author)
        }
        .navigationTitle(Strings.authorsTabTitle)
    }
}

private struct AuthorRow: View {
    let author: Author

    var body: some View {
        HStack(spacing: 16) {
            authorImage
            VStack(alignment: .leading, spacing: 4) {
                Text(author.name)
                    .font(.headline)
                Text(author.role ?? Strings.authorsPlaceholderRole)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }

    @ViewBuilder
    private var authorImage: some View {
        if let imageName = author.imageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(Color.accentColor))
                .clipShape(Circle())
        }
    }
}

#Preview {
    NavigationStack {
        AuthorsView()
    }
}
