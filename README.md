# coffee

lib/
│
├── core/                       # Thành phần dùng chung (Global)
│   ├── constants.dart          # Hằng số (Colors, API keys, Supabase URL)
│   ├── supabase_client.dart    # Nơi duy nhất khởi tạo Supabase
│   ├── utils.dart              # Các hàm dùng chung (format tiền, ngày tháng)
|   └── widgets/                # Chứa các widget
│
├── features/                   # Từng cụm tính năng của app
│   ├── auth/                   # Đăng nhập / Đăng ký
│   │   ├── models/             # Định nghĩa Object (VD: UserModel)
│   │   ├── repository/         # Chứa logic gọi Supabase Auth & DB
│   │   ├── controllers/        # Quản lý State (Bloc/Provider/GetX...)
│   │   └── views/              # Chứa toàn bộ UI (Pages và Widgets)
│   │
│   ├── menu/                   # Xem thực đơn
│   │   ├── models/             
│   │   ├── repository/         
│   │   ├── controllers/        
│   │   └── views/              
│   │
│   └── orders/                 # Giỏ hàng & Lịch sử đặt hàng
│       ├── models/             
│       ├── repository/         
│       ├── controllers/        
│       └── views/              
│
└── main.dart                   # Entry point, chạy app

1. features/auth/ (Luồng Chào mừng & Xác thực)
Views bao gồm: Onboarding, Login, Register, Forgot Password.

Giải thích: Gom hết bọn này vào một cục vì chúng nó chung một mục đích: 
    Mời chào và cấp quyền cho user vào app. Khi đã đăng nhập xong thì luồng này kết thúc, user hiếm khi quay lại trừ khi đăng xuất.

2. features/menu/ (Luồng Khám phá món)
   Views bao gồm: Home, Detail Item, Favorite.

Giải thích: Hành vi của khách ở đây là xem danh sách đồ uống (Home), bấm vào xem chi tiết size/đá/đường (Detail Item) và 
    "thả tim" lưu lại món ruột (Favorite). Cả 3 màn này đều chọc chung vào bảng dữ liệu products (sản phẩm) nên gom chung là chuẩn nhất.

3. features/orders/ (Luồng Mua hàng & Vận chuyển)
   Views bao gồm: Cart (Giỏ hàng), Order (Màn hình thanh toán/Checkout), Delivery (Màn hình bản đồ theo dõi Shipper).

Giải thích: Đây là luồng tạo ra tiền. 
    Bắt đầu từ việc chốt số lượng món -> Áp mã giảm giá/chọn địa chỉ giao -> Chuyển sang trạng thái theo dõi đơn hàng.

4. features/profile/ (Luồng Cá nhân hóa)
   Views bao gồm: Profile (Trang cá nhân), Add Payment Method (Thêm phương thức thanh toán).

Giải thích: Nơi quản lý thông tin định danh (Tên, Email, Ảnh đại diện, Điểm thưởng) và các thiết lập tài chính (Thẻ Visa, Ví điện tử).

5. features/notifications/ (Luồng Thông báo)
   Views bao gồm: Notifications.

Giải thích: Màn hình này nên tách ra thành một feature riêng. 
    Vì logic của nó rất khác biệt (thường dùng để hứng dữ liệu Realtime khi shipper đổi trạng thái đơn, 
    hoặc hứng push notification khuyến mãi từ hệ thống bắn về).

1. Quản lý Tài khoản (Auth & Profile)
           Vì yêu cầu bắt buộc là khách phải đăng nhập mới dùng được app, đây là chốt chặn đầu tiên.
        
        Đăng ký & Đăng nhập cơ bản: Bằng Email và Mật khẩu (khoan làm Google OAuth2 ở giai đoạn này).
        
        Thông tin cá nhân cơ bản: Cập nhật tên và địa chỉ giao hàng dạng Text (chưa cần tích hợp Google Maps).

2. Trưng bày Sản phẩm (Catalog)
           Dữ liệu chỉ cần đọc (Read-only) từ database lên app.
        
        Danh sách danh mục: Phân loại đồ uống (Cà phê, Trà, Nước ép...).
        
        Chi tiết sản phẩm & Size: Khách xem được món ăn, chọn được Size (S, M, L) và thấy được giá tiền tương ứng thay đổi theo Size.

3. Xử lý Giỏ hàng (Cart Management)
           Đây là nơi xử lý logic dữ liệu quan trọng nhất trước khi chốt đơn.
        
        Thêm/Sửa/Xóa món: Thêm một món với size cụ thể vào giỏ, tăng giảm số lượng hoặc xóa khỏi giỏ.
        
        Tính tổng tiền tạm tính: Logic cộng dồn giá tiền dựa trên products_size và quantity.

4. Đặt hàng & Thanh toán (Checkout)
        Giai đoạn "chốt" luồng dữ liệu, chuyển dữ liệu từ Giỏ hàng sang Đơn hàng.

        Nhập thông tin giao hàng: Điền địa chỉ nhận hàng và ghi chú (ít đá, nhiều đường...).
        
        Thanh toán COD (Tiền mặt): Ở phiên bản lõi, chỉ nên làm thanh toán tiền mặt khi nhận hàng. Việc gọi API qua Momo hay VNPay nên để ở Giai đoạn 2.
        
        Lưu lịch sử giá (Quan trọng): Chuyển giá từ bảng products_size sang cột unit_price của bảng order_detail để đảm bảo hóa đơn không bị sai lệch nếu sau này quán tăng/giảm giá đồ uống.

5. Theo dõi Đơn hàng (Order Tracking)
   Lịch sử đơn hàng: Khách hàng xem lại các đơn đã đặt.

        Trạng thái đơn: Xem trạng thái hiện tại (Đang chờ xử lý, Đang chuẩn bị, Đang giao).
        
        Các tính năng nên CẮT BỎ (đưa vào Giai đoạn 2) để tránh ngợp:
        
        Vouchers & Hạng thành viên (Rank point).
        
        Đánh giá, bình luận sản phẩm (Reviews).
        
        Sản phẩm yêu thích (Favorites).
        
        Tích hợp bản đồ Google Maps và Đăng nhập Google/Facebook.
        
        Gợi ý sản phẩm.


1. Nhóm DÙNG CHUNG (Đặt ở thư mục core/)
   Đây là những nghiệp vụ "xuyên lục địa", chạy ngầm và được gọi bởi rất nhiều màn hình khác nhau.

   Auth (Xác thực người dùng):

       AuthRepository: Chứa hàm gọi Supabase đăng nhập, đăng xuất, lấy thông tin User.
    
       AuthService (Kế thừa GetxService): Lưu trữ biến currentUser.
    
       Vì sao dùng chung? Vì màn hình Home cần hiển thị "Chào [Tên User]", màn hình Cart cần lấy user_id để query giỏ hàng, và màn hình Profile cần lấy thông tin để hiển thị. Nếu không dùng chung, bạn sẽ phải gọi API lấy thông tin user lặp đi lặp lại ở 3 màn hình này.

   Cart (Giỏ hàng):

        CartRepository: Chứa lệnh gọi bảng cart_items (CRUD).
        
        CartService (Kế thừa GetxService): Lưu trữ biến danh sách món trong giỏ (cartItems) và biến tổng_tiền.
        
        Vì sao dùng chung? Màn hình Detail gọi hàm "Thêm vào giỏ". Ngay lập tức, icon giỏ hàng nhỏ xíu trên thanh điều hướng (Bottom Nav) ở màn hình Home phải nảy số lên 1. Màn Cart hiển thị chi tiết, và màn Checkout lấy dữ liệu giỏ hàng để tiến hành chốt đơn. Giỏ hàng phải là một luồng data chảy xuyên suốt app.

2. Nhóm RIÊNG BIỆT (Đặt ở thư mục features/)
   Đây là những nghiệp vụ chỉ phục vụ cho một luồng công việc cụ thể, xong việc đóng trang là bộ nhớ bị xóa sạch.

Menu & Sản phẩm (Feature: Menu)

    MenuRepository: Lấy data từ bảng categories, products, products_size.
    
    MenuController: Xử lý logic lọc sản phẩm (tìm kiếm), đổi tab danh mục.
    
    Vì sao dùng riêng? Khách chỉ duyệt món ăn ở màn Home/Menu. Khi khách bấm sang trang Thanh toán hoặc xem Lịch sử, cái đống list món ăn này không cần phải lưu trong RAM nữa, xóa đi cho nhẹ máy.

Thanh toán & Đơn hàng (Feature: Orders)

    OrderRepository: Đẩy data lên bảng orders và order_detail (Chốt đơn), lấy lịch sử đơn hàng.
    
    CheckoutController & OrderHistoryController: Xử lý nhập địa chỉ, ghi chú, và hiển thị danh sách đơn cũ.
    
    Vì sao dùng riêng? Logic này chỉ chạy khi khách bấm nút "Đặt hàng". Nó nhận dữ liệu từ cái CartService (dùng chung) đổ sang, tính toán thêm phí ship rồi đẩy thẳng lên Supabase. Xong xuôi là dọn dẹp biến, không cần các màn hình khác biết tới.

Quản lý hồ sơ (Feature: Profile)

    ProfileController: Chứa logic đổi tên, đổi mật khẩu, cập nhật ảnh đại diện.
    
    Vì sao dùng riêng? Chỉ khi nào khách vào tab Profile mới cần khởi tạo class này để bắt lỗi form (validation). Khách đổi tên thành công thì Controller này gọi cái AuthService ở Core cập nhật lại cái tên mới là xong.

