import 'dart:io';

import 'package:appflowy/plugins/document/presentation/share/share_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as p;

import '../../shared/mock/mock_file_picker.dart';
import '../../shared/util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('share markdown in document page', () {
    testWidgets('click the share button in document page', (tester) async {
      final context = await tester.initializeAppFlowy();
      await tester.tapGoButton();

      // mock the file picker
      final path = await mockSaveFilePath(
        p.join(context.applicationDataDirectory, 'test.md'),
      );
      // click the share button and select markdown
      await tester.tapShareButton();
      await tester.tapMarkdownButton();

      // expect to see the success dialog
      tester.expectToExportSuccess();

      final file = File(path);
      final isExist = file.existsSync();
      expect(isExist, true);
      final markdown = file.readAsStringSync();
      expect(markdown, expectedMarkdown);
    });

    testWidgets(
      'share the markdown after renaming the document name',
      (tester) async {
        final context = await tester.initializeAppFlowy();
        await tester.tapGoButton();

        // expect to see a getting started page
        tester.expectToSeePageName(gettingStarted);

        // rename the document
        await tester.hoverOnPageName(
          gettingStarted,
          onHover: () async {
            await tester.renamePage('example');
          },
        );

        final shareButton = find.byType(ShareActionList);
        final shareButtonState =
            tester.state(shareButton) as ShareActionListState;
        final path = await mockSaveFilePath(
          p.join(
            context.applicationDataDirectory,
            '${shareButtonState.name}.md',
          ),
        );

        // click the share button and select markdown
        await tester.tapShareButton();
        await tester.tapMarkdownButton();

        // expect to see the success dialog
        tester.expectToExportSuccess();

        final file = File(path);
        final isExist = file.existsSync();
        expect(isExist, true);
      },
    );
  });
}

const expectedMarkdown = '''
# Boas-vindas à Rekreio!
## Dicas para iniciar
- [ ] Clique em qualquer lugar para começar a digitar.
- [ ] Highlight any text, and use the editing menu to _style_ **your** <u>writing</u> `however` you ~~like.~~
- [ ] As soon as you type `/` a menu will pop up. Select different types of content blocks you can add.
- [ ] Type `/` followed by `/bullet` or `/num` to create a list.
- [x] Click `+ Nova Página `button at the bottom of your sidebar to add a new page.
- [ ] Click `+` next to any page title in the sidebar to quickly add a new subpage, `Document`, `Grid`, or `Kanban Board`.

---

## Atalhos de teclado, markdown e bloco de código
1. Atalhos de teclado [guide](https://appflowy.gitbook.io/docs/essential-documentation/shortcuts)
1. Markdown [reference](https://appflowy.gitbook.io/docs/essential-documentation/markdown)
1. Type `/code` to insert a code block
```rust
// This is the main function.
fn main() {
    // Print text to the console.
    println!("Hello World!");
}
```

## Possui alguma dúvida❓
> Click `?` no canto inferior direito para obter ajuda.

> 🥰
> 
> Nos siga:
> [GitHub](https://github.com/AppFlowy-IO/AppFlowy)
> [Twitter](https://twitter.com/appflowy): @appflowy
> [Newsletter](https://blog-appflowy.ghost.io/)
> 




''';
