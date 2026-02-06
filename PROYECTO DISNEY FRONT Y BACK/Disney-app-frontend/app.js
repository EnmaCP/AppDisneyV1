const API = "http://localhost:3000/api/movies";

// Seleccionamos el contenedor que creamos en el HTML
const $container = document.getElementById("movies-container");

async function loadMovies(category = "") {
    try {
        const url = category ? `${API}?category=${category}` : API;
        const response = await fetch(url);
        const data = await response.json();

        console.log("Datos recibidos:", data); // Para ver qué llega en la consola

        // Limpiamos el contenedor antes de añadir nuevas cartas
        $container.innerHTML = "";

        // Verificamos si data.movies existe y es una lista
        if (data.movies && Array.isArray(data.movies)) {

            // Recorremos cada película de la API
            data.movies.forEach(item => {

                // ... dentro del forEach en app.js ...

                const card = document.createElement("div");
                card.className = "poster-card"; // Usamos la nueva clase

                // Usamos una imagen por defecto si la API no trae una
                const imgUrl = item.imagen_url || `https://source.unsplash.com/random/300x450?movie&sig=${Math.random()}`;

                card.innerHTML = `
    <div class="card-image-wrapper">
        <img src="${imgUrl}" alt="${item.movie}" />
        <div class="poster-overlay">
            <div class="poster-content">
                <h3>${item.movie}</h3>
                <div class="meta-info">
                    <span class="badge">PG-13</span>
                    <span>2024</span>
                </div>
                <div class="card-buttons">
                    <button class="btn-play"><span class="material-symbols-outlined fill-icon">play_arrow</span></button>
                    <button class="btn-plus"><span class="material-symbols-outlined">add</span></button>
                </div>
            </div>
        </div>
    </div>
`;

                $container.appendChild(card);
            });

        } else {
            console.error("La estructura de la API no es la esperada");
        }

    } catch (error) {
        console.error("Error cargando las películas:", error);
    }
}

// Inicializar filtros
const filterButtons = document.querySelectorAll(".filter-btn");
filterButtons.forEach(btn => {
    btn.addEventListener("click", () => {
        // Remover clase active de todos
        filterButtons.forEach(b => b.classList.remove("active"));
        // Añadir active al clickeado
        btn.classList.add("active");

        const category = btn.getAttribute("data-category");
        loadMovies(category);
    });
});

// Ejecutamos la función inicial
loadMovies();

// Scroll Logic
// Scroll Logic
const sliders = document.querySelectorAll(".movies-slider");

sliders.forEach(slider => {
    const btnLeft = slider.querySelector(".btn-left");
    const btnRight = slider.querySelector(".btn-right");
    const container = slider.querySelector(".movies-row");

    if (btnLeft && btnRight && container) {
        btnLeft.addEventListener("click", () => {
            container.scrollBy({
                left: -window.innerWidth / 2,
                behavior: "smooth"
            });
        });

        btnRight.addEventListener("click", () => {
            container.scrollBy({
                left: window.innerWidth / 2,
                behavior: "smooth"
            });
        });
    }
});

// Inline Search Logic
document.addEventListener("DOMContentLoaded", () => {
    const btnSearchNav = document.getElementById("btn-search-nav");
    const searchContainer = document.getElementById("search-container");
    const searchInput = document.getElementById("search-input-nav");

    if (btnSearchNav && searchContainer && searchInput) {
        // Toggle search on button click
        btnSearchNav.addEventListener("click", (e) => {
            e.preventDefault();
            searchContainer.classList.toggle("active");

            if (searchContainer.classList.contains("active")) {
                setTimeout(() => searchInput.focus(), 100);
            }
        });

        // Close search when clicking outside
        document.addEventListener("click", (e) => {
            if (!searchContainer.contains(e.target) && searchContainer.classList.contains("active")) {
                searchContainer.classList.remove("active");
                searchInput.value = "";
            }
        });

        // Prevent closing when clicking inside search
        searchContainer.addEventListener("click", (e) => {
            e.stopPropagation();
        });

        // Close on Escape key
        document.addEventListener("keydown", (e) => {
            if (e.key === "Escape" && searchContainer.classList.contains("active")) {
                searchContainer.classList.remove("active");
                searchInput.value = "";
            }
        });
    }
});

// --- HERO CAROUSEL LOGIC ---
const heroMovies = [
    {
        title: "BLACK PANTHER:<br>WAKANDA FOREVER",
        description: "La reina Ramonda, Shuri, M'Baku, Okoye y las Dora Milaje luchan para proteger a su nación de las potencias mundiales que intervienen tras la muerte del rey T'Challa.",
        image: "https://m.media-amazon.com/images/S/pv-target-images/8c579c1b0ee1e3dfd99c2a33a740982a67fd230c3e1126b23ec907116d116741._SX1080_FMjpg_.jpg" // Black Panther / Dark Sci-fi filler
    },
    {
        title: "AVENGERS:<br>ENDGAME",
        description: "Los devastadores acontecimientos puestos en marcha por Thanos, que acabaron con la mitad del universo y fracturaron a los Vengadores, obligan a los héroes restantes a tomar una última posición.",
        image: "https://cdn.marvel.com/content/2x/avengersendgame_lob_mas_mob_01.jpg" // Sci-fi/Space filler
    },
    {
        title: "THE MANDALORIAN",
        description: "El viaje del Mandaloriano a través de la galaxia de Star Wars continúa. Din Djarin, antaño un cazarrecompensas solitario, se ha reencontrado con Grogu.",
        image: "https://poptv.orange.es/wp-content/uploads/sites/3/2023/02/mandalorian-temporada-3-01.jpg" // Space/Star Wars filler
    }
];

let currentHeroIndex = 0;
const $hero = document.getElementById('home-hero');
const $heroTitle = document.getElementById('hero-title');
const $heroDesc = document.getElementById('hero-desc');
const $heroControls = document.getElementById('hero-controls');

function updateHero(index) {
    if (!$hero) return;

    // Update Content with fade effect (basic)
    const movie = heroMovies[index];

    // Change background
    $hero.style.backgroundImage = `linear-gradient(rgba(0, 0, 0, 0), #1a1d29), url('${movie.image}')`;

    // Update Text
    $heroTitle.innerHTML = movie.title;
    $heroDesc.textContent = movie.description;

    // Update Dots
    const dots = document.querySelectorAll('.hero-dot');
    dots.forEach((dot, i) => {
        if (i === index) dot.classList.add('active');
        else dot.classList.remove('active');
    });

    currentHeroIndex = index;
}

function initHeroCarousel() {
    if (!$heroControls) return;

    // Create Dots
    heroMovies.forEach((_, index) => {
        const dot = document.createElement('div');
        dot.classList.add('hero-dot');
        if (index === 0) dot.classList.add('active');

        dot.addEventListener('click', () => {
            updateHero(index);
            resetHeroInterval(); // Reset timer on manual click
        });

        $heroControls.appendChild(dot);
    });

    // Start Auto Rotation
    startHeroInterval();
}

let heroInterval;

function startHeroInterval() {
    heroInterval = setInterval(() => {
        let nextIndex = currentHeroIndex + 1;
        if (nextIndex >= heroMovies.length) nextIndex = 0;
        updateHero(nextIndex);
    }, 8000); // Change every 8 seconds
}

function resetHeroInterval() {
    clearInterval(heroInterval);
    startHeroInterval();
}

// Init when DOM loads (appending to existing event logic if possible, or just running it)
document.addEventListener("DOMContentLoaded", () => {
    initHeroCarousel();
    initMovieModal();
});

// --- MOVIE MODAL FUNCTIONALITY ---
function initMovieModal() {
    const modal = document.getElementById('movie-modal');
    const modalClose = document.getElementById('modal-close');
    const modalBackdrop = modal.querySelector('.modal-backdrop');

    // Sample movie data for demonstration
    const movieData = {
        'Endgame': {
            title: 'Avengers: Endgame',
            rating: 4.8,
            year: 2019,
            duration: '3h 2m',
            badge: 'PG-13',
            genres: ['Acción', 'Aventura', 'Ciencia Ficción'],
            description: 'Los devastadores acontecimientos puestos en marcha por Thanos, que acabaron con la mitad del universo y fracturaron a los Vengadores, obligan a los héroes restantes a tomar una última posición en la gran conclusión de 22 películas de Marvel Studios.',
            director: 'Anthony y Joe Russo',
            cast: 'Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson'
        },
        'Spider-Man': {
            title: 'Spider-Man: No Way Home',
            rating: 4.7,
            year: 2021,
            duration: '2h 28m',
            badge: 'PG-13',
            genres: ['Acción', 'Aventura', 'Superhéroes'],
            description: 'Por primera vez en la historia cinematográfica de Spider-Man, nuestro amigable héroe del vecindario es desenmascarado y ya no puede separar su vida normal de los enormes riesgos que conlleva ser un superhéroe.',
            director: 'Jon Watts',
            cast: 'Tom Holland, Zendaya, Benedict Cumberbatch, Jacob Batalon'
        },
        'Dune': {
            title: 'Dune',
            rating: 4.5,
            year: 2021,
            duration: '2h 35m',
            badge: 'PG-13',
            genres: ['Ciencia Ficción', 'Aventura', 'Drama'],
            description: 'Una epopeya mitológica y un viaje emocional, Dune cuenta la historia de Paul Atreides, un joven brillante y talentoso nacido con un gran destino más allá de su comprensión, que debe viajar al planeta más peligroso del universo.',
            director: 'Denis Villeneuve',
            cast: 'Timothée Chalamet, Rebecca Ferguson, Oscar Isaac, Josh Brolin'
        },
        'Mandalorian': {
            title: 'The Mandalorian',
            rating: 4.6,
            year: 2019,
            duration: '40m/episodio',
            badge: 'TV-14',
            genres: ['Ciencia Ficción', 'Aventura', 'Western'],
            description: 'El viaje del Mandaloriano a través de la galaxia de Star Wars continúa. Din Djarin, antaño un cazarrecompensas solitario, se ha reencontrado con Grogu. Mientras tanto, la Nueva República lucha por liderar la galaxia lejos de su oscuro pasado.',
            director: 'Jon Favreau',
            cast: 'Pedro Pascal, Grogu, Katee Sackhoff, Carl Weathers'
        },
        'Black Widow': {
            title: 'Black Widow',
            rating: 4.3,
            year: 2021,
            duration: '2h 14m',
            badge: 'PG-13',
            genres: ['Acción', 'Aventura', 'Espionaje'],
            description: 'Natasha Romanoff, también conocida como Black Widow, se enfrenta a las partes más oscuras de su historia cuando surge una peligrosa conspiración vinculada a su pasado. Perseguida por una fuerza que no se detendrá ante nada para derribarla.',
            director: 'Cate Shortland',
            cast: 'Scarlett Johansson, Florence Pugh, David Harbour, Rachel Weisz'
        },
        'Doctor Strange': {
            title: 'Doctor Strange',
            rating: 4.4,
            year: 2016,
            duration: '1h 55m',
            badge: 'PG-13',
            genres: ['Acción', 'Aventura', 'Fantasía'],
            description: 'El Dr. Stephen Strange, un neurocirujano de renombre mundial, busca curación en un lugar misterioso conocido como Kamar-Taj. Rápidamente descubre que no es solo un centro de curación, sino también la primera línea de batalla contra fuerzas oscuras.',
            director: 'Scott Derrickson',
            cast: 'Benedict Cumberbatch, Chiwetel Ejiofor, Rachel McAdams, Tilda Swinton'
        },
        'Thor: Love & Thunder': {
            title: 'Thor: Love and Thunder',
            rating: 4.2,
            year: 2022,
            duration: '1h 59m',
            badge: 'PG-13',
            genres: ['Acción', 'Aventura', 'Comedia'],
            description: 'Thor se embarca en un viaje diferente a todo lo que ha enfrentado: una búsqueda de la paz interior. Pero su retiro se ve interrumpido por un asesino galáctico conocido como Gorr el Carnicero de Dioses, que busca la extinción de los dioses.',
            director: 'Taika Waititi',
            cast: 'Chris Hemsworth, Natalie Portman, Christian Bale, Tessa Thompson'
        },
        'Iron Man': {
            title: 'Iron Man',
            rating: 4.6,
            year: 2008,
            duration: '2h 6m',
            badge: 'PG-13',
            genres: ['Acción', 'Aventura', 'Ciencia Ficción'],
            description: 'Tony Stark, un industrial multimillonario e ingenioso inventor, es secuestrado y obligado a construir un arma devastadora. En cambio, usando su inteligencia y ingenio, Tony construye una armadura de alta tecnología y escapa del cautiverio.',
            director: 'Jon Favreau',
            cast: 'Robert Downey Jr., Gwyneth Paltrow, Jeff Bridges, Terrence Howard'
        },
        'Captain Marvel': {
            title: 'Captain Marvel',
            rating: 4.3,
            year: 2019,
            duration: '2h 4m',
            badge: 'PG-13',
            genres: ['Acción', 'Aventura', 'Ciencia Ficción'],
            description: 'Carol Danvers se convierte en una de las heroínas más poderosas del universo cuando la Tierra se ve atrapada en medio de una guerra galáctica entre dos razas alienígenas. Ambientada en la década de 1990, Captain Marvel es una aventura completamente nueva.',
            director: 'Anna Boden, Ryan Fleck',
            cast: 'Brie Larson, Samuel L. Jackson, Ben Mendelsohn, Jude Law'
        }
    };

    // Function to open modal with movie data
    function openModal(movieTitle, posterUrl) {
        const data = movieData[movieTitle] || {
            title: movieTitle,
            rating: 4.5,
            year: 2024,
            duration: '2h 30m',
            badge: 'PG-13',
            genres: ['Acción', 'Aventura'],
            description: 'Una emocionante película llena de acción y aventura que te mantendrá al borde de tu asiento.',
            director: 'Director Desconocido',
            cast: 'Elenco Estelar'
        };

        // Populate modal with data
        document.getElementById('modal-poster-img').src = posterUrl;
        document.getElementById('modal-title').textContent = data.title;
        document.getElementById('modal-rating-value').textContent = data.rating;
        document.getElementById('modal-year').textContent = data.year;
        document.getElementById('modal-duration').textContent = data.duration;
        document.getElementById('modal-badge').textContent = data.badge;
        document.getElementById('modal-description').textContent = data.description;
        document.getElementById('modal-director').textContent = data.director;
        document.getElementById('modal-cast').textContent = data.cast;

        // Update genres
        const genresContainer = document.getElementById('modal-genres');
        genresContainer.innerHTML = '';
        data.genres.forEach(genre => {
            const tag = document.createElement('span');
            tag.className = 'genre-tag';
            tag.textContent = genre;
            genresContainer.appendChild(tag);
        });

        // Show modal
        modal.classList.add('active');
        document.body.style.overflow = 'hidden'; // Prevent background scrolling
    }

    // Function to close modal
    function closeModal() {
        modal.classList.remove('active');
        document.body.style.overflow = ''; // Restore scrolling
    }

    // Add click listeners to all poster cards
    document.addEventListener('click', (e) => {
        const card = e.target.closest('.poster-card');
        if (card) {
            // Don't open modal if clicking on buttons
            if (e.target.closest('.btn-play, .btn-plus')) {
                return;
            }

            const img = card.querySelector('img');
            const title = card.querySelector('h3');
            if (img && title) {
                openModal(title.textContent, img.src);
            }
        }
    });

    // Close modal handlers
    if (modalClose) {
        modalClose.addEventListener('click', closeModal);
    }

    if (modalBackdrop) {
        modalBackdrop.addEventListener('click', closeModal);
    }

    // Close on ESC key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && modal.classList.contains('active')) {
            closeModal();
        }
    });
}
