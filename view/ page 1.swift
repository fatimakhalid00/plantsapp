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
                // العنوان والخط اللي تحته، نفس الهيدر المستخدم في باقي الصفحات عشان يطابق Sketch
                PageHeader()
                // المسافة بين الخط تحت العنوان والصورة مثل Sketch (77 بعد التصغير للجوال)
                // هنا حطيت الصوره
                Image("plant")
                    .resizable()
                    .scaledToFit()
                    // حجم الصورة مثل Sketch (164 في 200) بعد التصغير للجوال
                    .frame(width: 154, height: 188)
                    .padding(.top, 72)
                // هنا حطيت العنوان اللي تحت الصوره
                Text("Start your plant journey!")
                    // حجم العنوان تحت الصورة مثل Sketch
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.primary)
                    // المسافة بين الصورة والعنوان مثل Sketch
                    .padding(.top, 36)
                // padding horizontal يضيق النص عشان ينكسر على سطرين في النص
                Text("Now all your plants will be in one place and\nwe will help you take care of them :) 🪴")
                    // حجم النص الصغير مثل Sketch
                    .font(.system(size: 14))
                    // لون النص الرمادي 9F9F91 مثل Sketch
                    .foregroundStyle(Color(red: 159/255, green: 159/255, blue: 145/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    // المسافة بين العنوان والنص الصغير
                    .padding(.top, 18)
                // هنا حطيت الزر
                Button {
                    // يفتح صفحة Set Reminder لإضافة نبتة جديدة
                    viewModel.startAdding()
                } label: {
                    Text("Set Plant Reminder")
                        // حجم خط الزر مثل Sketch
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white)
                        // حجم الزر مثل Sketch (280 في 42) بعد التصغير للجوال
                        .frame(width: 262, height: 39)
                }
                // تأثير الزجاج (Liquid Glass) بلون أخضر، وinteractive يخليه يتجاوب لما نضغطه
                .glassEffect(.regular.tint(Color.plantGreen).interactive(), in: .capsule)
                // المسافة بين النص الصغير والزر مثل Sketch (105 بعد التصغير للجوال)
                .padding(.top, 98)
                // يخلي كل شي فوق، والباقي فاضي تحت
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}
#Preview {
    // نعطيها ViewModel تجريبي عشان يشتغل الـ Preview
    page1(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
