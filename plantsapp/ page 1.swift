import SwiftUI
struct page1: View {
    var body: some View {
        // ZStack يحط العناصر فوق بعض
        ZStack {
            // يخلي الشاشه كلها سوده
            Color(.systemBackground)                .ignoresSafeArea()
            // VStack يرتب العناصر تحت بعض
            VStack(spacing: 0) {
                // HStack يحط العناصر جنب بعض
                HStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.primary)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 12)
                // العنوان
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal)
                Spacer()
                // هنا حطيت الصوره
                Image("plant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                // هنا حطيت العنوان اللي تحت الصوره
                Text("Start your plant journey!")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.primary)
                    .padding(.top, 37)
                // padding horizontal يضيق النص عشان ينكسر على سطرين في النص
                Text("Now all your plants will be in one place and\nwe will help you take care of them :) 🪴")
                    .font(.system(size: 15))
                    .foregroundStyle(Color(red: 153/255, green: 153/255, blue: 153/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 25)
                // هنا حطيت الزر
                Button("Set Plant Reminder") {
                    print("Button tapped")
                }
                .foregroundStyle(.white)
                .frame(width: 280, height: 42)
                .background(Color(red: 51/255, green: 128/255, blue: 105/255))
                .clipShape(Capsule())
                .padding(.top, 105)
                // عشان كل شي يكون بالنص
                Spacer()
            }
        }
        .preferredColorScheme(.dark)    }
}
#Preview {
    page1()
}

