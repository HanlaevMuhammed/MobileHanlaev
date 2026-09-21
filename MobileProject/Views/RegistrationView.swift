//
//  RegistrationView.swift
//  MobileProject
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullName: String = ""
    @State private var gender: Gender = .male
    @State private var course: Int = 1
    @State private var difficulty: Double = 5
    @State private var birthDate: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    @State private var currentZodiacSign: ZodiacSign = .from(date: Date())

    @State private var registeredPlayer: Player?
    @State private var isShowingValidationAlert = false

    private let courses = Array(1...6)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                fullNameSection
                genderSection
                courseSection
                difficultySection
                birthDateSection
                registerButton

                if let player = registeredPlayer {
                    resultSection(for: player)
                }
            }
            .padding()
        }
        .navigationTitle(Strings.formTitle)
        .onChange(of: birthDate) { _, newValue in
            currentZodiacSign = ZodiacSign.from(date: newValue)
        }
        .alert(Strings.validationTitle, isPresented: $isShowingValidationAlert) {
            Button(Strings.ok, role: .cancel) {}
        } message: {
            Text(Strings.emptyNameMessage)
        }
    }

    // MARK: - Sections

    private var fullNameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.fullNameLabel)
                .font(.headline)
            TextField(Strings.fullNamePlaceholder, text: $fullName)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
        }
    }

    private var genderSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.genderLabel)
                .font(.headline)
            Picker(Strings.genderLabel, selection: $gender) {
                ForEach(Gender.allCases) { option in
                    Text(option.localizedName).tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private var courseSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.courseLabel)
                .font(.headline)
            Picker(Strings.courseLabel, selection: $course) {
                ForEach(courses, id: \.self) { value in
                    Text(Strings.courseTitle(value)).tag(value)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxHeight: 120)
        }
    }

    private var difficultySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.difficultyLabel)
                .font(.headline)
            Text(Strings.difficultyValue(Int(difficulty.rounded())))
                .foregroundStyle(.secondary)
            Slider(value: $difficulty, in: 1...10, step: 1)
        }
    }

    private var birthDateSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.birthDateLabel)
                .font(.headline)
            DatePicker(
                Strings.birthDateLabel,
                selection: $birthDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .labelsHidden()

            HStack(spacing: 12) {
                Image(currentZodiacSign.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                VStack(alignment: .leading) {
                    Text(Strings.zodiacLabel)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(currentZodiacSign.localizedName)
                        .font(.headline)
                }
            }
        }
    }

    private var registerButton: some View {
        Button(Strings.registerButton) {
            register()
        }
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity)
    }

    private func resultSection(for player: Player) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Strings.resultTitle)
                .font(.headline)
            HStack(alignment: .top, spacing: 16) {
                Image(player.zodiacSign.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text(player.formattedSummary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Actions

    private func register() {
        let trimmedName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            isShowingValidationAlert = true
            return
        }

        registeredPlayer = Player(
            fullName: trimmedName,
            gender: gender,
            course: course,
            difficulty: Int(difficulty.rounded()),
            birthDate: birthDate,
            zodiacSign: currentZodiacSign
        )
    }
}

#Preview {
    NavigationStack {
        RegistrationView()
    }
}
