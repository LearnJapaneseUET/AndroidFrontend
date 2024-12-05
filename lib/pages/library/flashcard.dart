import 'package:flutter/material.dart';

class flashcardPage extends StatefulWidget {
  const flashcardPage({super.key});

  @override
  State<flashcardPage> createState() => _flashcardPageState();
}

class _flashcardPageState extends State<flashcardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2A2D37),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF2A2D37),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 56, 16, 146),
              child: Column(
                children: const [
                  LessonHeader(),
                  SizedBox(height: 60),
                  LessonContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class LessonHeader extends StatelessWidget {
  const LessonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const Text(
          'Notebook 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Noto Sans',
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings, size: 24),
          color: Colors.white,
          onPressed: () {
            // do something
          },
        ),
      ],
    );
  }
}


class LessonContent extends StatelessWidget {
  const LessonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: 0.12,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 295, maxHeight: 485),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 196),
            decoration: BoxDecoration(
              color: Color(0xFF8980F0).withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        Transform.rotate(
          angle: -0.12,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 295, maxHeight: 485),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 196),
            decoration: BoxDecoration(
              color: Color(0xFF8980F0).withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 295, maxHeight: 485),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 196),
          decoration: BoxDecoration(
            color: const Color(0xFF8980F0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.volume_up, size: 24),
                    color: Colors.white,
                    onPressed: () {
                      // do something
                    },
                  ),

                  Center(
                    child: Expanded(
                      child: Text(
                        '1/150',
                        style: TextStyle(
                          color: const Color(0xFFE3DFFD),
                          fontSize: 16,
                          fontFamily: 'Noto Sans',
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              Center(
                child: Text(
                  'meejt vaix loz cuu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Noto Sans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}