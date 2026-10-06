import 'package:flutter/material.dart';

void main() {
  runApp(const AnimeHubApp());
}

// ============================================================
// MODEL DATA ANIME
// ============================================================

class Anime {
  final String title;
  final String genre;
  final String image;
  final double rating;

  // STATE FAVORITE
  // Nilai ini akan berubah ketika user menekan tombol favorite.
  bool isFavorite;

  Anime({
    required this.title,
    required this.genre,
    required this.image,
    required this.rating,
    this.isFavorite = false,
  });
}

// ============================================================
// DATA ANIME
// ============================================================

List<Anime> animeList = [
  Anime(
    title: 'Seihantai na Kimi to Boku',
    genre: 'Comedy, Romance, School, Shounen',
    image: 'assets/seihantai.jpg',
    rating: 8.33,
  ),
  Anime(
    title: 'Toumei na Yoru ni Kakeru Kimi to, Me ni Mienai Koi wo Shita',
    genre: 'Drama, Romance',
    image: 'assets/toumei.jpg',
    rating: 7.53,
  ),
  Anime(
    title: 'Futsutsuka na Akujo dewa Gozaimasu ga',
    genre: 'Fantasy, Romance, Villainess',
    image: 'assets/futsutsuka.jpg',
    rating: 7.53,
  ),
  Anime(
    title: 'Koori no Jouheki',
    genre: 'Drama, Romance, School',
    image: 'assets/koori.jpg',
    rating: 8.25,
  ),
  Anime(
    title: 'Class de 2-banme ni Kawaii Onnanoko to Tomodachi ni Natta',
    genre: 'Romance, School',
    image: 'assets/class_2.jpg',
    rating: 7.80,
  ),
  Anime(
    title: 'Aishiteru Game wo Owarasetai',
    genre: 'Comedy, Romance, School',
    image: 'assets/aishiteru.jpg',
    rating: 7.42,
  ),
];

// ============================================================
// ROOT APP
// ============================================================

class AnimeHubApp extends StatelessWidget {
  const AnimeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimeHub',

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF7F5FC),
      ),

      home: const HomePage(),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// ============================================================
// STATE HOME PAGE
// ============================================================

class _HomePageState extends State<HomePage> {

  // ==========================================================
  // STATE SEARCH
  // ==========================================================
  // Variabel ini menyimpan teks yang sedang dicari user

  String searchQuery = '';

  // ==========================================================
  // STATE GENRE
  // ==========================================================
  // Variabel ini menyimpan genre yang sedang dipilih

  String selectedGenre = 'All';

  // ==========================================================
  // FUNGSI MENGHITUNG JUMLAH FAVORITE
  // ==========================================================

  int get favoriteCount {
    return animeList.where((anime) => anime.isFavorite).length;
  }

  // ==========================================================
  // FUNGSI FILTER ANIME
  // ==========================================================
  // Data anime akan berubah berdasarkan search dan genre

  List<Anime> get filteredAnime {

    return animeList.where((anime) {

      // Filter berdasarkan search
      final matchesSearch = anime.title
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      // Filter berdasarkan genre
      final matchesGenre =
          selectedGenre == 'All' ||
          anime.genre.contains(selectedGenre);

      return matchesSearch && matchesGenre;

    }).toList();
  }

  // ==========================================================
  // FUNGSI MENGUBAH FAVORITE
  // ==========================================================
  // setState digunakan agar tampilan langsung diperbarui
  // ketika status favorite berubah
  //
  // Konsep setState sesuai Modul 4

  void toggleFavorite(Anime anime) {

    setState(() {

      anime.isFavorite = !anime.isFavorite;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(

        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,

        title: const Text(
          'AnimeHub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          // ====================================================
          // FAVORITE COUNTER
          // ====================================================

          Padding(
            padding: const EdgeInsets.only(right: 16),

            child: Row(

              children: [

                const Icon(Icons.favorite),

                const SizedBox(width: 5),

                // Jumlah favorite akan berubah
                // ketika user menekan tombol favorite.

                Text(
                  '$favoriteCount',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(

            padding: const EdgeInsets.all(16),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // ==================================================
                // HEADER
                // ==================================================

                const Text(
                  'Temukan Anime Favoritmu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Jelajahi berbagai anime menarik di AnimeHub.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // SEARCH TEXT FIELD
                // ==================================================
                //
                // onChanged digunakan untuk membaca input user
                //
                // setState digunakan agar daftar anime diperbarui
                // setiap kali user mengetik

                TextField(

                  onChanged: (value) {

                    setState(() {

                      searchQuery = value;

                    });

                  },

                  decoration: InputDecoration(

                    hintText: 'Cari anime...',

                    prefixIcon: const Icon(
                      Icons.search,
                    ),

                    filled: true,

                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // GENRE
                // ==================================================

                const Text(
                  'Genre',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Row digunakan untuk menampilkan tombol genre
                // secara horizontal.

                SingleChildScrollView(

                  scrollDirection: Axis.horizontal,

                  child: Row(

                    children: [

                      genreButton('All'),
                      genreButton('Drama'),
                      genreButton('Fantasy'),
                      genreButton('Romance'),
                      genreButton('School'),
                      genreButton('Shounen'),
                      genreButton('Villainess'),

                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ==================================================
                // POPULAR ANIME
                // ==================================================

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      'Anime Populer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '${filteredAnime.length} anime',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // ==================================================
                // DAFTAR ANIME
                // ==================================================

                if (filteredAnime.isEmpty)

                  // Tampilan ketika pencarian tidak menemukan anime.

                  Container(

                    width: double.infinity,

                    padding: const EdgeInsets.all(30),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(15),
                    ),

                    child: const Column(

                      children: [

                        Icon(
                          Icons.search_off,
                          size: 50,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Anime tidak ditemukan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )

                else

                  Column(

                    children: filteredAnime.map((anime) {

                      return animeCard(anime);

                    }).toList(),
                  ),

                const SizedBox(height: 20),

                // ==================================================
                // RECOMMENDATION
                // ==================================================

                Container(

                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    gradient: const LinearGradient(

                      colors: [

                        Color(0xFF6A4BBC),
                        Color(0xFF8E6DD8),

                      ],
                    ),

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 35,
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Rekomendasi Hari Ini',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Jangan lewatkan anime terbaik yang sedang populer!',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // GENRE BUTTON
  // ============================================================

  Widget genreButton(String genre) {

    // Mengecek apakah genre sedang dipilih.

    final bool isSelected =
        selectedGenre == genre;

    return Padding(

      padding: const EdgeInsets.only(right: 8),

      child: GestureDetector(

        onTap: () {

          // STATE GENRE
          // setState membuat tampilan berubah ketika genre
          // dipilih oleh user.

          setState(() {

            selectedGenre = genre;

          });

        },

        child: Container(

          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),

          decoration: BoxDecoration(

            color: isSelected
                ? Colors.deepPurple
                : Colors.white,

            borderRadius:
                BorderRadius.circular(20),

            border: Border.all(
              color: Colors.deepPurple,
            ),
          ),

          child: Text(

            genre,

            style: TextStyle(

              color: isSelected
                  ? Colors.white
                  : Colors.deepPurple,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ANIME CARD
  // ============================================================

  Widget animeCard(Anime anime) {

    return GestureDetector(

      // ========================================================
      // NAVIGASI KE DETAIL PAGE
      // ========================================================
      //
      // Navigator.push digunakan untuk berpindah ke halaman
      // detail anime.
      //
      // Konsep Navigator.push berasal dari Modul 3.

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (context) {

              return DetailPage(
                anime: anime,
                onFavorite: () {

                  // Ketika favorite diubah dari halaman detail,
                  // HomePage juga diperbarui.

                  setState(() {});
                },
              );

            },
          ),
        );
      },

      child: Container(

        margin: const EdgeInsets.only(bottom: 15),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          boxShadow: [

            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),

        child: Row(

          children: [

            // ==================================================
            // POSTER
            // ==================================================

            ClipRRect(

              borderRadius: const BorderRadius.only(

                topLeft: Radius.circular(18),

                bottomLeft: Radius.circular(18),

              ),

              child: Image.asset(

                anime.image,

                width: 100,

                height: 140,

                fit: BoxFit.cover,

              ),
            ),

            // ==================================================
            // INFORMASI ANIME
            // ==================================================

            Expanded(

              child: Padding(

                padding: const EdgeInsets.all(14),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(

                      anime.title,

                      style: const TextStyle(

                        fontSize: 18,

                        fontWeight: FontWeight.bold,

                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.deepPurple
                            .withOpacity(0.1),

                        borderRadius:
                            BorderRadius.circular(10),
                      ),

                      child: Text(

                        anime.genre,

                        style: const TextStyle(

                          color: Colors.deepPurple,

                          fontSize: 12,

                          fontWeight:
                              FontWeight.bold,

                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(

                      children: [

                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          anime.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        // ==================================================
                        // FAVORITE BUTTON
                        // ==================================================
                        //
                        // State berubah ketika tombol ditekan.

                        IconButton(

                          onPressed: () {

                            toggleFavorite(anime);

                          },

                          icon: Icon(

                            anime.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,

                            color: anime.isFavorite
                                ? Colors.red
                                : Colors.grey,

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// DETAIL PAGE
// ================================================================

class DetailPage extends StatefulWidget {

  final Anime anime;

  final VoidCallback onFavorite;

  const DetailPage({
    super.key,
    required this.anime,
    required this.onFavorite,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

// ================================================================
// STATE DETAIL PAGE
// ================================================================

class _DetailPageState extends State<DetailPage> {

  // ==============================================================
  // TOGGLE FAVORITE
  // ==============================================================
  //
  // setState digunakan untuk memperbarui tampilan detail page.

  void toggleFavorite() {

    setState(() {

      widget.anime.isFavorite =
          !widget.anime.isFavorite;

    });

    // Meminta HomePage memperbarui jumlah favorite.

    widget.onFavorite();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ============================================================
      // APP BAR
      // ============================================================

      appBar: AppBar(

        title: const Text(
          'Detail Anime',
        ),

        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,
      ),

      // ============================================================
      // BODY
      // ============================================================

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ======================================================
            // STACK
            // ======================================================
            //
            // Stack digunakan untuk menumpuk beberapa widget.
            //
            // Sesuai konsep Modul 3.

            Stack(

              children: [

                Image.asset(

                  widget.anime.image,

                  width: double.infinity,

                  height: 400,

                  fit: BoxFit.cover,

                ),

                // =================================================
                // POSITIONED
                // =================================================
                //
                // Positioned digunakan untuk menentukan posisi
                // widget di dalam Stack.

                Positioned(

                  bottom: 20,

                  right: 20,

                  child: Container(

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(

                      color: Colors.black
                          .withOpacity(0.7),

                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: Row(

                      children: [

                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),

                        const SizedBox(width: 5),

                        Text(

                          widget.anime.rating
                              .toString(),

                          style:
                              const TextStyle(

                            color: Colors.white,

                            fontWeight:
                                FontWeight.bold,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ======================================================
            // INFORMASI DETAIL
            // ======================================================

            Padding(

              padding: const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // ==================================================
                  // JUDUL + FAVORITE
                  // ==================================================

                  Row(

                    children: [

                      Expanded(

                        child: Text(

                          widget.anime.title,

                          style:
                              const TextStyle(

                            fontSize: 28,

                            fontWeight:
                                FontWeight.bold,

                          ),
                        ),
                      ),

                      // =================================================
                      // FAVORITE BUTTON
                      // =================================================

                      IconButton(

                        onPressed:
                            toggleFavorite,

                        icon: Icon(

                          widget.anime.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,

                          color:
                              widget.anime.isFavorite
                                  ? Colors.red
                                  : Colors.grey,

                          size: 30,

                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // GENRE
                  // ==================================================

                  Container(

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(

                      color: Colors.deepPurple
                          .withOpacity(0.1),

                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: Text(

                      widget.anime.genre,

                      style: const TextStyle(

                        color:
                            Colors.deepPurple,

                        fontWeight:
                            FontWeight.bold,

                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // DESCRIPTION
                  // ==================================================

                  const Text(

                    'Tentang Anime',

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,

                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(

                    'Anime ini merupakan salah satu anime '
                    'yang populer dan memiliki cerita menarik. '
                    'Nikmati informasi anime favoritmu melalui AnimeHub.',

                    style: TextStyle(

                      fontSize: 15,

                      height: 1.6,

                      color: Colors.grey,

                    ),
                  ),

                  const SizedBox(height: 30),

                  // ==================================================
                  // TOMBOL KEMBALI
                  // ==================================================
                  //
                  // Navigator.pop digunakan untuk kembali ke
                  // halaman sebelumnya.
                  //
                  // Konsep ini sesuai Modul 3.

                  SizedBox(

                    width: double.infinity,

                    child: ElevatedButton.icon(

                      onPressed: () {

                        Navigator.pop(context);

                      },

                      icon: const Icon(
                        Icons.arrow_back,
                      ),

                      label: const Text(
                        'Kembali',
                      ),

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            Colors.deepPurple,

                        foregroundColor:
                            Colors.white,

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}