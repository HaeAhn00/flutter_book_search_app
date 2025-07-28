import 'package:flutter/material.dart';
import 'package:flutter_book_search_app/ui/home/home_view_model.dart';
import 'package:flutter_book_search_app/ui/home/widgets/home_bottom_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  void onSearch(String text) {
    ref.read(homeViewModelProvider.notifier).searchBooks(text);
    print("onSearch 호출됨");
  }

  @override
  void dispose() {
    // 4. TextEditingController 는 반드시 사용 다하면 dispose를 호출해줘야 메모리에서 제거됨!
    // 소거해주려면 StatefulWidget 사용!
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return GestureDetector(
      onTap: () {
        // 3. UX 고려하기
        // 현재 위젯(HomePage)에서 포커스를 가지고 있는 위젯이 있으면 포커스 해제해줌
        // TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                onSearch(textEditingController.text);
              },
              // 버튼의 터치영역ㅡㄴ 44 디바이스 픽셀 이상으로 해야함 (UX)
              child: Container(
                width: 50,
                height: 50,
                // 컨테이너에 배경생이 없으면 자녀 위젯에만 터치 이벤트가 적용됨
                color: Colors.transparent,
                child: Icon(Icons.search),
              ),
            ),
          ],
          // 1. TextField 구현
          title: TextField(
            maxLines: 1,
            // TextField의 값을 검색 아이콘 터치했을때에도 사용할거라 사용!
            controller: textEditingController,
            onSubmitted: onSearch,
            // 2. TextStyle 꾸미기
            decoration: InputDecoration(
              hintText: '검색어를 입력해 주세요',
              border: MaterialStateOutlineInputBorder.resolveWith(
                (states) {
                  print(states);
                  // MaterialStateOutlineInputBorder.resolveWith를 사용하면
                  // TextField의 값이 바뀔때마다 WidgetState enum 값을 전달해서 이 함수 실행!
                  // print(states);
                  if (states.contains(WidgetState.focused)) {
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    );
                  }
                  return OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(20),
          itemCount: homeState.books.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final book = homeState.books[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return HomeBottomSheet(book);
                  },
                );
              },
              child: Image.network(book.image),
            );
          },
        ),
      ),
    );
  }
}
