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
                    <span>${item.year || 'Unknown'}</span>
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

// Search Overlay Logic
// Search Overlay Logic
document.addEventListener("DOMContentLoaded", () => {
    const btnSearchNav = document.getElementById("btn-search-nav");
    const searchOverlay = document.getElementById("search-overlay");
    const closeSearchBtn = document.getElementById("close-search");
    const searchInput = document.getElementById("search-input");

    if (btnSearchNav && searchOverlay && closeSearchBtn) {
        // Open Search
        btnSearchNav.addEventListener("click", (e) => {
            e.preventDefault();
            searchOverlay.classList.add("active");
            setTimeout(() => searchInput.focus(), 100); // Focus input after transition
        });

        // Close on X button
        closeSearchBtn.addEventListener("click", () => {
            searchOverlay.classList.remove("active");
        });

        // Close on click outside (background)
        searchOverlay.addEventListener("click", (e) => {
            if (e.target === searchOverlay) {
                searchOverlay.classList.remove("active");
            }
        });

        // Close on Escape key
        document.addEventListener("keydown", (e) => {
            if (e.key === "Escape" && searchOverlay.classList.contains("active")) {
                searchOverlay.classList.remove("active");
            }
        });
    } else {
        console.error("Search elements not found in DOM");
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
});