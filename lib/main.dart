import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showLoginCard = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();
  bool isLoading = false;

  pageContainerReverse() {
    setState(() {
      showLoginCard = !showLoginCard;
    });
  }

  checkRegister() {}

  forgotPassword() {}

  checkLogin() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget registerCard = OwnCard(
      title: "CREATE NEW",
      margin: EdgeInsets.only(
          left: 40, right: 40, top: MediaQuery.of(context).size.height * .3),
      onTap: pageContainerReverse,
      children: [
        const SizedBox(
          height: 30,
        ),
        CustomTextField(
          controller: emailController,
          label: "EMAIL",
        ),
        CustomTextField(
          controller: passwordController,
          label: "PASSWORD",
          isPasswordInput: true,
        ),
        CustomTextField(
          controller: secondPasswordController,
          label: "RE-ENTER PASSWORD",
          isPasswordInput: true,
        ),
        const Expanded(child: SizedBox.shrink()),
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            secondPasswordController.text.isNotEmpty)
          TextButton(
              onPressed: checkRegister(), child: const Text("CREATE NEW"))
      ],
    );
    Widget loginCard = OwnCard(
      title: "SIGN IN",
      margin: EdgeInsets.only(
          left: 20, right: 20, top: MediaQuery.of(context).size.height * .2),
      onTap: pageContainerReverse,
      children: [
        const SizedBox(
          height: 30,
        ),
        CustomTextField(controller: emailController, label: "EMAIL"),
        CustomTextField(
          controller: passwordController,
          label: "PASSWORD",
          isPasswordInput: true,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextButton(
              onPressed: () => forgotPassword(),
              child: const Text("Forgot password?"),
            ),
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty)
          Container(
            margin: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () => checkLogin(),
              child: const Text(
                "SIGN IN",
                style: TextStyle(fontSize: 24),
              ),
            ),
          )
      ],
    );
    Widget registerCardBlanc = OwnCard(
      title: "CREATE NEW",
      margin: EdgeInsets.only(
          left: 40, right: 40, top: MediaQuery.of(context).size.height * .3),
      onTap: pageContainerReverse,
      children: [
        const Expanded(child: SizedBox.shrink()),
        Container(
          margin: const EdgeInsets.all(20),
          child: const Text(
            "CREATE NEW",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF00CCFF), Color(0xFF3366FF)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: isLoading
            ? const LoadingCircle()
            : Stack(
                children: showLoginCard
                    ? [registerCardBlanc, loginCard]
                    : [loginCard, registerCard],
              ),
      ),
    );
  }
}

class OwnCard extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  final VoidCallback onTap;
  final List<Widget> children;

  const OwnCard({
    super.key,
    required this.title,
    required this.margin,
    required this.onTap,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: 400,
        width: double.infinity,
        child: Card(
          elevation: 12,
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ...children
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final void Function(String)? onChanged;
  final EdgeInsets? margin;
  final bool? isPasswordInput;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.onChanged,
      this.margin,
      this.isPasswordInput});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool? obscureText;

  showInput() {
    setState(() {
      obscureText = !obscureText!;
    });
  }

  @override
  void initState() {
    super.initState();

    obscureText = widget.isPasswordInput;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: widget.margin ??
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Stack(
        children: [
          TextField(
            controller: widget.controller,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(widget.label)),
            onChanged: widget.onChanged,
          ),
          if (obscureText != null)
            Positioned(
                right: 15,
                top: 15,
                child: InkWell(
                  onTap: () => showInput(),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "show",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                ))
        ],
      ),
    );
  }
}

class LoadingCircle extends StatefulWidget {
  const LoadingCircle({super.key});

  @override
  State<LoadingCircle> createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle> {
  double width = 250;
  double height = 250;
  bool isStarting = false;

  startAnimation() {
    setState(() {
      width = 100;
      height = 100;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => startAnimation());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(seconds: 1),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        onEnd: () {
          setState(() {
            width = width == 100 ? 250 : 100;
            height = height == 100 ? 250 : 100;
          });
        },
      ),
    );
  }
}
