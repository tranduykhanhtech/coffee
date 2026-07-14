1. Dữ liệu lưu trên RAM (Biến .obs trong GetX)
   Bản chất của RAM là nhanh, tự động update UI, nhưng tắt app là mất sạch. Do đó, bạn chỉ dùng RAM để chứa các "trạng thái nhất thời" và "dữ liệu hiển thị tạm":

Danh sách hiển thị: productList, categoryList, orderHistory. Mở app thì gọi Supabase kéo về đổ vào RAM để UI vẽ ra. Tắt app mất đi cũng không sao, mở lại gọi API kéo lại.

Trạng thái UI (UI State): Các biến như isLoading (đang xoay vòng vòng), selectedCategoryIndex (tab đang được chọn), currentBottomNavIndex (chuyển tab dưới đáy màn hình).

Dữ liệu form đang nhập: Tên, số điện thoại ở màn hình Checkout, hoặc email/password ở màn hình Login. Đang gõ dở mà vuốt tắt app thì thôi, cho người dùng nhập lại từ đầu.

2. Dữ liệu lưu trên Local Storage (Dùng GetStorage)
   Bản chất của Local là tồn tại vĩnh viễn trên máy (trừ khi người dùng gỡ app hoặc clear data). Bạn dùng Local cho những dữ liệu "bắt buộc phải nhớ" giữa các lần mở app:

Giỏ hàng (Cart): Chính xác như bạn nói! Khách chọn 3 ly cà phê, lỡ tay vuốt tắt app, mở lên lại vẫn phải thấy 3 ly đó trong giỏ. (Nếu để trên RAM là bay sạch, khách dỗi không mua nữa).

Sản phẩm yêu thích (Favorites): Lưu Local là một bước đi cực kỳ thông minh lúc chạy deadline. Nếu lưu lên Supabase, bạn phải tạo thêm bảng favorites, viết thêm API, lo logic đồng bộ. Lưu Local bằng 1 list ID sản phẩm là xong ngay.

Trạng thái Đăng nhập (Session/Token): Để giữ khách luôn ở trạng thái Login, không phải lúc nào mở app lên cũng bắt đăng nhập.

Cờ hệ thống (Flags): Ví dụ biến isFirstTimeOpen (để hiện màn hình giới thiệu Onboarding 1 lần duy nhất).



ghi chú nhẹ về db: 
provider (varchar/enum): 'local', 'google', 'facebook'... Mặc định là 'local'.
provider_id (varchar): Dùng để lưu ID định danh mà Google trả về. Khi query đăng nhập, bạn sẽ check cặp provider + provider_id.


Trong orders, ngoài delivery_address (Text), 2 cột: latitude (decimal hoặc float) và longitude (decimal hoặc float) để lưu tọa độ giao hàng của đơn đó.