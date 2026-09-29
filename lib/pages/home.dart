import 'dart:async';
import 'package:flutter/material.dart';
import '../styles/home_style.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _contentPosition;
  late Animation<double> _contentOpacity;

  late PageController _reviewsController;
  Timer? _reviewTimer;

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Juliana Silva',
      'comment':
          'A NutriFit mudou completamente minha forma de organizar minha alimentação. As receitas são incríveis!',
      'rating': 5,
    },
    {
      'name': 'Rafael Costa',
      'comment':
          'Gostei muito da variedade de receitas. É simples de usar e as sugestões são muito interessantes.',
      'rating': 5,
    },
    {
      'name': 'Mariana Oliveira',
      'comment':
          'Finalmente encontrei um aplicativo que deixa alimentação saudável muito mais fácil.',
      'rating': 4,
    },
    {
      'name': 'Lucas Martins',
      'comment':
          'As receitas são práticas e as informações ajudam bastante na hora de escolher o que comer.',
      'rating': 5,
    },
    {
      'name': 'Camila Santos',
      'comment':
          'A proposta da NutriFit é muito interessante. Adorei a ideia de reunir receitas e bem-estar.',
      'rating': 5,
    },
  ];

  final List<Map<String, dynamic>> recipes = [
    {
      'name': 'Salada de frango com quinoa',
      'description':
          'Uma refeição leve, completa e cheia de nutrientes. Perfeita para o almoço e para manter sua energia durante o dia.',
      'creator': 'Camila Santos',
      'rating': 4.8,
      'reviews': 324,
      'image':
          'https://images.unsplash.com/photo-1546793665-c74683f339c1?auto=format&fit=crop&w=900&q=85',
    },
  ];

  @override
  void initState() {
    super.initState();

    // =========================
    // ANIMAÇÃO DA ENTRADA
    // =========================

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoScale = Tween<double>(
      begin: 0.4,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _logoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0,
          0.45,
          curve: Curves.easeIn,
        ),
      ),
    );

    _contentPosition = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.35,
          1,
          curve: Curves.easeOut,
        ),
      ),
    );

    _contentOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.35,
          0.9,
          curve: Curves.easeIn,
        ),
      ),
    );

    _animationController.forward();

    // =========================
    // CARROSSEL DE AVALIAÇÕES
    // =========================

    _reviewsController = PageController(
      viewportFraction: 0.72,
      initialPage: 5000,
    );

    _reviewTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        if (_reviewsController.hasClients) {
          _reviewsController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _reviewsController.dispose();
    _reviewTimer?.cancel();

    super.dispose();
  }

  // =========================
  // AVISO
  // =========================

  void _showUnavailableMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: HomeStyle.lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: HomeStyle.primary,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Aviso',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: const Text(
            'Essa funcionalidade não está disponível nessa versão. '
            'Não é o nosso departamento.',
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'ENTENDI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HomeStyle.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // CRIAR PERFIL
  // =========================

  void _showCreateAccountOptions() {
    _showAccountOptions(
      title: 'Criar seu perfil',
      subtitle: 'Escolha como deseja criar sua conta.',
      actionPrefix: 'Continuar com',
    );
  }

  // =========================
  // LOGIN
  // =========================

  void _showLoginOptions() {
    _showAccountOptions(
      title: 'Entrar na NutriFit',
      subtitle: 'Escolha uma opção para continuar.',
      actionPrefix: 'Entrar com',
    );
  }

  void _showAccountOptions({
    required String title,
    required String subtitle,
    required String actionPrefix,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 25),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: HomeStyle.textDark,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              _accountOption(
                icon: Icons.email_outlined,
                title: '$actionPrefix E-mail',
              ),

              const SizedBox(height: 12),

              _accountOption(
                icon: Icons.g_mobiledata_rounded,
                title: '$actionPrefix Google',
              ),

              const SizedBox(height: 12),

              _accountOption(
                icon: Icons.apple,
                title: '$actionPrefix Apple',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _accountOption({
    required IconData icon,
    required String title,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          _showUnavailableMessage();
        },
        icon: Icon(
          icon,
          color: HomeStyle.primary,
          size: 25,
        ),
        label: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: HomeStyle.textDark,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // =========================
  // ESTRELAS
  // =========================

  Widget _stars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          return Icon(
            index < rating.round()
                ? Icons.star_rounded
                : Icons.star_border_rounded,
            color: Colors.amber.shade600,
            size: 18,
          );
        },
      ),
    );
  }

  // =========================
  // AVALIAÇÃO
  // =========================

  Widget _reviewCard(
    Map<String, dynamic> review,
    double pagePosition,
  ) {
    final double distance = pagePosition.abs();

    final double scale = (1 - (distance * 0.16))
        .clamp(0.72, 1.0);

    final double opacity = (1 - (distance * 0.55))
        .clamp(0.25, 1.0);

    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 15,
          ),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // ESTRELAS EM CIMA
              _stars(
                review['rating'].toDouble(),
              ),

              const SizedBox(height: 15),

              CircleAvatar(
                radius: 28,
                backgroundColor: HomeStyle.lightGreen,
                child: Text(
                  review['name'][0],
                  style: const TextStyle(
                    color: HomeStyle.primary,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                review['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                '"${review['comment']}"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: HomeStyle.textGrey,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Usuário NutriFit',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // RECEITA
  // =========================

  Widget _recipeCard() {
    final recipe = recipes[0];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // FOTO
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            child: Image.network(
              recipe['image'],
              width: double.infinity,
              height: 230,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: HomeStyle.lightGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'RECEITA EM DESTAQUE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: HomeStyle.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  recipe['name'],
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: HomeStyle.textDark,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _stars(recipe['rating']),

                    const SizedBox(width: 8),

                    Text(
                      '${recipe['rating']} (${recipe['reviews']} avaliações)',
                      style: const TextStyle(
                        fontSize: 13,
                        color: HomeStyle.textGrey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                const Text(
                  'Sobre a receita',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  recipe['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: HomeStyle.textGrey,
                  ),
                ),

                const SizedBox(height: 20),

                const Divider(),

                const SizedBox(height: 15),

                const Text(
                  'Criada por',
                  style: TextStyle(
                    fontSize: 13,
                    color: HomeStyle.textGrey,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: HomeStyle.lightGreen,
                      child: Icon(
                        Icons.person,
                        color: HomeStyle.primary,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Camila Santos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Nutricionista',
                          style: TextStyle(
                            fontSize: 12,
                            color: HomeStyle.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: HomeStyle.background,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: [

                  const SizedBox(height: 30),

                  // =========================
                  // LOGO
                  // =========================

                  FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Container(
                        width: 175,
                        height: 175,
                        decoration: HomeStyle.logoShadow,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(35),
                          child: Image.asset(
                            'assets/logo_NUTRIFIT.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // =========================
                  // APRESENTAÇÃO
                  // =========================

                  SlideTransition(
                    position: _contentPosition,
                    child: FadeTransition(
                      opacity: _contentOpacity,
                      child: Column(
                        children: [

                          const Text(
                            'NutriFit',
                            style: HomeStyle.logo,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'SAÚDE • NUTRIÇÃO • BEM-ESTAR',
                            style: HomeStyle.subtitle,
                          ),

                          const SizedBox(height: 35),

                          // =========================
                          // CHAMADA PRINCIPAL
                          // =========================

                          const Text(
                            'Alimente sua melhor versão.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              height: 1.15,
                              color: HomeStyle.textDark,
                            ),
                          ),

                          const SizedBox(height: 15),

                          const Text(
                            'Descubra receitas deliciosas, '
                            'cuide da sua alimentação e encontre '
                            'novas formas de transformar sua '
                            'rotina em uma jornada mais saudável.',
                            textAlign: TextAlign.center,
                            style: HomeStyle.description,
                          ),

                          const SizedBox(height: 30),

                          // =========================
                          // IMAGEM / PROMOÇÃO
                          // =========================

                          Container(
                            height: 260,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.12),
                                  blurRadius: 25,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(28),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [

                                  Image.network(
                                    'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=85',
                                    fit: BoxFit.cover,
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      gradient:
                                          LinearGradient(
                                        begin:
                                            Alignment.topCenter,
                                        end: Alignment
                                            .bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black
                                              .withOpacity(0.75),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const Positioned(
                                    left: 20,
                                    right: 20,
                                    bottom: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [

                                        Text(
                                          'Receitas que dão vontade de experimentar.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        Text(
                                          'Saúde também pode ser deliciosa.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 55),

                          // =========================
                          // AVALIAÇÕES
                          // =========================

                          const Text(
                            'O que dizem sobre a NutriFit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: HomeStyle.textDark,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            'Experiências de quem já descobriu '
                            'uma nova forma de cuidar da alimentação.',
                            textAlign: TextAlign.center,
                            style: HomeStyle.description,
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            height: 300,
                            child: PageView.builder(
                              controller: _reviewsController,
                              itemBuilder: (context, index) {

                                final review =
                                    reviews[index %
                                        reviews.length];

                                return AnimatedBuilder(
                                  animation:
                                      _reviewsController,
                                  builder:
                                      (context, child) {

                                    double page = 0;

                                    if (_reviewsController
                                        .position
                                        .haveDimensions) {
                                      page =
                                          _reviewsController
                                                  .page ??
                                              5000;
                                    }

                                    final position =
                                        index - page;

                                    return _reviewCard(
                                      review,
                                      position,
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 55),

                          // =========================
                          // RECEITA
                          // =========================

                          const Align(
                            alignment:
                                Alignment.centerLeft,
                            child: Text(
                              'Receita em destaque',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: HomeStyle.textDark,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Align(
                            alignment:
                                Alignment.centerLeft,
                            child: Text(
                              'Uma escolha especial para você experimentar.',
                              style: HomeStyle.description,
                            ),
                          ),

                          const SizedBox(height: 20),

                          _recipeCard(),

                          const SizedBox(height: 55),

                          // =========================
                          // COMEÇAR
                          // =========================

                          const Text(
                            'Pronto para começar?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: HomeStyle.textDark,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            'Faça parte da NutriFit.',
                            style: HomeStyle.description,
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed:
                                  _showCreateAccountOptions,
                              style: HomeStyle.button,
                              child: const Text(
                                'CRIAR PERFIL',
                                style: HomeStyle.buttonText,
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: _showLoginOptions,
                              style:
                                  HomeStyle.loginButton,
                              child: const Text(
                                'JÁ TENHO UMA CONTA',
                                style:
                                    HomeStyle.loginButtonText,
                              ),
                            ),
                          ),

                          const SizedBox(height: 35),

                          const Text(
                            'NutriFit • Sua jornada começa aqui.',
                            style: HomeStyle.footer,
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}