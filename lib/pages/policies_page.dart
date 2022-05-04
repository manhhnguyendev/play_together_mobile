import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({Key? key}) : super(key: key);

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _textEditingController.text = 'Điều khoản sử dụng:\n'
        '1.1 Thành viên hoặc người dùng sử dụng app Play Together phải đảm đã đọc rõ và hiểu các điều khoản liên quan đến việc sử dụng công cụ của Player Together cùng các điều khoản về bảo mật thông tin sẽ được liệt kê dưới đây.\n1.2 Người dùng cam kết sử dụng các công cụ của Play Together không vì mục đích chính trị, tôn giáo hoặc vi phạm các quy định pháp luật hiện hành trên môi trường Internet. Trong trường hợp vi phạm, Play Together có quyền xóa người dùng ngay lập tức mà không cần báo trước.\n1.3 Tất cả các trường hợp người dùng đăng tải nội dung vi phạm những điều dưới đây đều có thể dẫn đến tài khoản bị cấm tính năng hoặc nặng nhất là banned vĩnh viễn tài khoản tại Play Together:\nThông tin, hình ảnh,... có nội dung nhằm vào mục đích phá hoại, lôi kéo, bôi nhọ uy tín, nói sai sự thật đối với các đối tác trên hệ thống Play Together.\nThông tin, hình ảnh,... có sử dụng từ ngữ, hình ảnh phản cảm, đồi trụy, trái với thuần phong mỹ tục Việt Nam.\n';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            'Chính sách',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          style: GoogleFonts.montserrat(),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          controller: _textEditingController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      )),
    );
  }
}
