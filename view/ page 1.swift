import SwiftUI
struct page1: View {
    // نفس الـ ViewModel اللي تستخدمه باقي الصفحات
    @Bindable var viewModel: PlantsViewModel

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
                        // حجم عنوان الصفحة
                        .font(.system(size: 28, weight: .bold))
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
                    .frame(width: 145)
                // هنا حطيت العنوان اللي تحت الصوره
                Text("Start your plant journey!")
                    // حجم العنوان تحت الصورة
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.primary)
                    .padding(.top, 30)
                // padding horizontal يضيق النص عشان ينكسر على سطرين في النص
                Text("Now all your plants will be in one place and\nwe will help you take care of them :) 🪴")
                    // حجم النص الصغير
                    .font(.system(size: 12))
                    .foregroundStyle(Color(red: 153/255, green: 153/255, blue: 153/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                // هنا حطيت الزر
                Button("Set Plant Reminder") {
                    // يفتح صفحة Set Reminder لإضافة نبتة جديدة
                    viewModel.startAdding()
                }
                // حجم خط الزر
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 260, height: 40)
                // تأثير الزجاج (Liquid Glass) بلون أخضر، وinteractive يخليه يتجاوب لما نضغطه
                .glassEffect(.regular.tint(Color(red: 51/255, green: 128/255, blue: 105/255)).interactive(), in: .capsule)
                .padding(.top, 105)
                // عشان كل شي يكون بالنص
                Spacer()
            }
        }
        .preferredColorScheme(.dark)    }
}
#Preview {
    // نعطيها ViewModel تجريبي عشان يشتغل الـ Preview
    page1(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
