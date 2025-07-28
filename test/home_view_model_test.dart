import 'package:flutter_book_search_app/ui/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('HomeViewModel test', () async {
    final providerContainer = ProviderContainer();
    addTearDown(providerContainer.dispose);
    final homeVm = providerContainer.read(homeViewModelProvider.notifier);
    final firstState = providerContainer.read(homeViewModelProvider);
    expect(firstState.books.isEmpty, true);

    await homeVm.searchBooks('harry');
    final afterState = providerContainer.read(homeViewModelProvider);
    expect(afterState.books.isEmpty, false);

    afterState.books.forEach(
      (element) {
        print(element.toJson());
      },
    );
  });
}
