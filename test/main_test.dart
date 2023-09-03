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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();
  bool showLoginCard = true;
  late List<Widget> pageContainer;
  bool isLoading = false;

  pageContainerReverse() {
    setState(() {
      showLoginCard = !showLoginCard;
    });
  }

  checkLogin() {
    setState(() {
      isLoading = true;
    });
  }

  checkRegister() {}

  forgotPassword(){}

  @override
  Widget build(BuildContext context) {
    Widget registerCard = OwnCard(
      title: "CREATE NEW",
      margin: EdgeInsets.only(
          left: 40, right: 40, top: MediaQuery.of(context).size.height * .3),
      onTapFunction: pageContainerReverse,
      children: [
        CustomTextField(
          controller: emailController,
          label: "EMAIL",
        ),
        CustomTextField(
          controller: passwordController,
          label: "PASSWORD",
        ),
        CustomTextField(
          controller: secondPasswordController,
          label: "RE-ENTER PASSWORD",
        ),
        const Expanded(child: SizedBox.shrink()),
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            secondPasswordController.text.isNotEmpty)
          TextButton(onPressed: checkLogin(), child: const Text("CREATE NEW"))
      ],
    );
    var loginCard = OwnCard(
      title: "SIGN IN",
      margin: EdgeInsets.only(
          left: 20, right: 20, top: MediaQuery.of(context).size.height * .2),
      onTapFunction: pageContainerReverse,
      children: [
        const SizedBox(height: 30),
        CustomTextField(
          controller: emailController,
          label: "EMAIL",
        ),
        CustomTextField(
          controller: passwordController,
          label: "PASSWORD",
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
          onChanged: (string) {
            setState(() {});
          },
        ),
        Align(
            alignment: Alignment.topRight,
            child:
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextButton(onPressed: () => forgotPassword(), child: const Text("Forgot password?")),
                )),
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
                  )))
      ],
    );
    var registerCardBlanc = OwnCard(
        title: "CREATE NEW",
        margin: EdgeInsets.only(
            left: 40, right: 40, top: MediaQuery.of(context).size.height * .3),
        onTapFunction: pageContainerReverse,
        children: [
          const Expanded(child: SizedBox.shrink()),
          Container(
              margin: const EdgeInsets.all(20),
              child: const Text(
                "CREATE NEW",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ))
        ]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFF00CCFF),
              Color(0xFF3366FF),
            ])),
        child: isLoading
            ? const LoadingCircle()
            : Stack(
              children: showLoginCard
                ? [registerCardBlanc, loginCard]
                : [loginCard, registerCard]),
      ),
    );
  }
}

class OwnCard extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  final VoidCallback onTapFunction;
  final List<Widget> children;

  const OwnCard(
      {super.key,
      required this.title,
      required this.margin,
      required this.onTapFunction,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
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
                      ))),
              ...children
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final void Function(String)? onChanged;
  final EdgeInsets? margin;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.margin,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin ?? const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label)),
        onChanged: onChanged,
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => start());
  }

  start(){
    setState(() {
      width = 100;
      height = 100;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: width,
        height: height,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        onEnd: (){
          setState(() {
            width = width == 100 ? 250 : 100;
            height = height == 100 ? 250 : 100;
          });
        },
      ),
    );
  }
}
