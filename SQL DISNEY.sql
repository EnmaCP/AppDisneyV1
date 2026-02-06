PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS CATEGORIAS(
idCategoria INTEGER PRIMARY KEY AUTOINCREMENT,
Nombre TEXT NOT NULL,
slug TEXT NOT NULL --ES EXCLUSIVO PARA CREAR UNA URL AMIGABLE--
);

CREATE TABLE IF NOT EXISTS MOVIES (
idPelicula INTEGER PRIMARY KEY AUTOINCREMENT,
Titulo TEXT NOT NULL,
Descripcion TEXT,
posterURL TEXT,
ImagenHeroSectionURL TEXT,
videoURL TEXT,
AnyoEstreno INTEGER,
Destacado BOOLEAN DEFAULT 0, -- poner 1 si queremos que sea peli destacada--
idCategoria INTEGER,
FOREIGN KEY (idCategoria) REFERENCES CATEGORIAS(idCategoria)
);

CREATE TABLE IF NOT EXISTS PLAN(
idPlan INTEGER PRIMARY KEY AUTOINCREMENT,
Nombre TEXT NOT NULL,
Precio REAL NOT NULL, --Son para poner los decimales--
Ventajas TEXT
);

CREATE TABLE IF NOT EXISTS USUARIO(
idUsuario INTEGER PRIMARY KEY AUTOINCREMENT,
Nombre TEXT NOT NULL,
email TEXT NOT NULL UNIQUE,
contrasenya TEXT NOT NULL,
avatarURL TEXT DEFAULT 'https://thumbs.dreamstime.com/b/icono-plano-de-perfil-avatar-predeterminado-vector-usuario-medios-sociales-retrato-una-imagen-humana-desconocida-un-desconocido-184330869.jpg',
idPlan INTEGER,
FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan)
);

INSERT INTO CATEGORIAS (Nombre, slug) VALUES 
('Acción', 'accion'),
('Drama', 'drama'),
('Misterio', 'misterio'),
('Romance', 'romance'),
('Terror', 'terror');

-- Películas de Acción (category_id = 1)
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES 
('Avengers: Endgame', 'Los héroes más poderosos de la tierra se enfrentan a Thanos.', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAhBrkgvM5cJgj841EsmPRRS4_rHh3S3BKs-WlllOzdJIzd9tpx8sCSBnPb03EmmGyXu2lwqAfnaOVthljrpBjuNqLs7jZpAgrm0xT4IdACiaOFjNBqrQolLlbrb04VY5-VHpNJlpEwpEOvDF1lmaGBVA6nYfcHk2KoGoUy0ZYnAvd34KJ4qz1rEvOOJadd9PYUv34ItleFZ1YVOrw-SieYFvhwwavCIFv1T-Z8G5NUupAo8tjRZKREb-U-EQm0PYhTXkc-emAX0gs', 'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/9/9b/Avenger_Endgame_Poster_Oficial.png/revision/latest?cb=20190326185910&path-prefix=es', 'https://youtu.be/svLSGZkTzC0?si=19uhYhtnw0PFRS2R', 2019, 1, 0),
('SpiderMan', 'Mordido por una araña genéticamente modificada, un estudiante de secundaria tímido y torpe obtiene increíbles capacidades como arácnido.', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBIeDzAzUQq9e1vqWBrbRFoIq4U3tzk1WBACDLkayBdvOhpCOugl6g49R1B-CHfTpLibd22nIt_rtWBn583Df5_CV6ecKLpEr_HkmG53z59RqIXV8YWgMkOj3Z5BXdATKn6gUsGEtGN8KRY2rBBBO0utFlydPwK6qava_9oVd53u4624WePdILIrJUuz-5v73q2HI3rHDX7uQSdHDq9Vyc4IdnJXYtUjDFxnV_Hmfs-Us-DAYThiMqC6_ORlyIZnccCt5pmUYWsNIk', 'https://static.wikia.nocookie.net/spiderman/images/8/85/Spider-Man2002Poster.png/revision/latest?cb=20131213162615&path-prefix=es', 'https://youtu.be/_yhFofFZGcc?si=VxpZivnGgDxZTkww', 2002, 1, 0),
('Dune','Arrakis, también denominado "Dune", se ha convertido en el planeta más importante del universo. A su alrededor comienza una gigantesca lucha por el poder que culmina en una guerra interestelar.','https://lh3.googleusercontent.com/aida-public/AB6AXuBO6zqTE0WLsfwYhKS7H4O4hTIiMYHuvs_wfgybxk5j7Z2Xl16xpU7jtQvAXnkLPFAwSqQSs0YLlrQ0Yn-sT4yOtOqB01A1022AApmprH9arrllfWy8drIrjYP2hpHrXAz9rvnHbTiNiakv3KWRieJvp3pSrrIYrHywO9BzACibIh3JuJwpfo8ZIK6yAvFEMzUn28NQ3FOVluSLIUzz3ZFgT8PmQdzYCv_u0tgkWr9w63tR73Q9xL0XKs0nNvbx--4K6Ba0h23mJSo','https://www.cinesa.es/media/hrjdbqmm/dune-2-poster.jpg', 'https://youtu.be/mSY_NbSmaUI?si=gzxiCDxdTq-6ooCf', 2021,1,0),
('Mandalorian','Las aventuras de Mando, un pistolero solitario y cazarrecompensas que se abre paso a través de las fronteras más remotas de la galaxia, lejos de la jurisdicción de la Nueva República.','https://lh3.googleusercontent.com/aida-public/AB6AXuA61qngZqsptCGjSuGtj3_SuFkmJV1Du62GaIY8PsgVVCfchGUdByAUeGt68cJUMUixgfCMVXlkn7vGOBkzlg2O9I8paWqEXbNDkuPPBpTdtRUrFd0OGeZmnPPDQ_09kpBpYcU-ls6qd_GDK-_t0mzUufakkXYLgDeMKipJsUhLnbiEVP_S3pU2R_MeGnXvLRzbyv17MJc7kOZYZXXBY0jvjhX7mxbmoafQFdiFaGJ6y8-65vZu3N9ZQAY2KhhqaPApUJKti0Y3wgk','https://static.posters.cz/image/1300/103609.jpg', 'https://youtu.be/aOC8E8z_ifw?si=igcJJsJFPFdm7O1K', 2019,1,0);
-- Películas de Drama (category_id = 2)
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES 
('Bohemian Rhapsody', 'Londres, 1970. El joven Farrokh, Freddie para los amigos, trabaja en el aeropuerto, estudia diseño gráfico y escribe canciones. Un día, tras escuchar al grupo Smile en un bar, se ofrece como cantante de la banda al enterarse de que se han quedado sin vocalista.', 'https://es.web.img3.acsta.net/pictures/18/05/21/12/50/1518397.jpg', 'https://upload.wikimedia.org/wikipedia/en/2/2e/Bohemian_Rhapsody_poster.png', 'https://youtu.be/mP0VHJYFOAU?si=zJXLCc-ilXJwRkYV', 2018, 2, 0),
('Titanic', 'Jack es un joven artista que gana un pasaje para viajar a América en el Titanic, el transatlántico más grande y seguro jamás construido.', 'https://pics.filmaffinity.com/Titanic-704052013-large.jpg', 'https://upload.wikimedia.org/wikipedia/en/1/18/Titanic_%281997_film%29_poster.png', 'https://youtu.be/wMZuro21wtE?si=iLAw06-7jPWv3wAo', 1998, 2, 0),
('The Shawshank Redemption', 'Andrew Dufresne es un hombre inocente que es acusado del asesinato de su mujer. Tras ser condenado a cadena perpetua, es enviado a la cárcel de Shawshank, en Maine.', 'https://cdn-images.dzcdn.net/images/cover/444b8089fecacd790fc5c53b6d0933aa/0x1900-000000-80-0-0.jpg', 'https://play-lh.googleusercontent.com/VPQQg8y0oTqnBk7NPdklj7P_dOmfk5K7dheS3LSAEXNuh-CeP8yLXeqxeoLYxlbVdov3LQRh51WCLMbtpcLI', 'https://youtu.be/NmzuHjWmXOc?si=7qHbYFSpsgfUzSms', 1995, 2, 0),
('Forrest Gump', 'Sentado en un banco en Savannah, Georgia, Forrest Gump espera al autobús. Mientras éste tarda en llegar, el joven cuenta su vida a las personas que se sientan a esperar con él. Aunque sufre un pequeño retraso mental, esto no le impide hacer cosas maravillosas.', 'https://m.media-amazon.com/images/I/61gJ0U3mAiL._AC_UF894,1000_QL80_.jpg', 'https://pics.filmaffinity.com/Forrest_Gump-212765827-large.jpg', 'https://youtu.be/bLvqoHBptjg?si=Ek6QC6XrOFPz8Mch', 1994, 2, 0),
('A Star Is Born', 'Jackson, una estrella de la música country con problemas de alcoholismo, descubre el talento de Ally, una joven cantante de la cual se enamora. Mientras la carrera de ella despega, Jackson percibe que sus días de gloria están llegando a su fin.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAJGXvOYngDUjDtAu2m0AziGIX-suhHQC1HA&s', 'https://m.media-amazon.com/images/M/MV5BNTgwNGU2ZDktYzI0Ni00ZGM2LTg3MWItYzlhZGMyNDk0NjdhXkEyXkFqcGc@._V1_.jpg', 'https://youtu.be/nSbzyEJ8X9E?si=pBZWuIX_zIxlQd0T', 2018, 2, 0);

-- Películas de Misterio (category_id = 3)
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES
('Shutter Island', 'Verano de 1954. Los agentes judiciales Teddy Daniels y Chuck Aule son enviados a una remota isla del puerto de Boston para investigar la desaparición de una peligrosa asesina recluida en el hospital ...', 'https://play-lh.googleusercontent.com/lrDTJU_tTz9FefyFjcW571Tf4G_57ofuY9BSk_8KVfvt6RTRCrQMGtSNAmYrLHNzkezFNQ=w240-h480-rw', 'https://m.media-amazon.com/images/M/MV5BN2FjNWExYzEtY2YzOC00YjNlLTllMTQtNmIwM2Q1YzBhOWM1XkEyXkFqcGc@._V1_.jpg', 'https://youtu.be/v8yrZSkKxTA?si=KRgE9wthxOvITDQB', 2010, 3, 0),
('Puñales por la Espalda', 'Un misterio moderno en el que un grupo de investigadores ha de descubrir al responsable del asesinato del patriarca de una excéntrica familia.', 'https://m.media-amazon.com/images/M/MV5BZmYxOTAxYjgtMWQ3NC00ZTFlLWJiYjMtOGNiMGIwZDMwNzEzXkEyXkFqcGc@._V1_.jpg', 'https://es.web.img2.acsta.net/pictures/19/10/28/17/07/1703422.jpg', 'https://youtu.be/dzt1BPkm97I?si=001CV3sJ-qGsRXsy', 2019, 3, 0),
('Se7en', 'El veterano teniente Somerset está a punto de jubilarse y ser reemplazado por el impulsivo detective David Mills. Ambos tendrán que colaborar en la resolución de unos asesinatos cometidos por un psicópata que se basa en los siete pecados capitales.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlaVBZqBUXXEOYx3umTFVXuyzXswurIrl--A&s', 'https://m.media-amazon.com/images/M/MV5BY2IzNzMxZjctZjUxZi00YzAxLTk3ZjMtODFjODdhMDU5NDM1XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg', 'https://youtu.be/xhzBmjdehPA?si=T8ALrOitRok9_N96', 1995, 3, 0),
('Zodiac', 'En los años sesenta y setenta, un asesino en serie se burla de la policía y los medios de comunicación enviándoles cartas y mensajes encriptados. Los investigadores de la policía y reporteros del periódico se obsesionan con el hecho de encontrar al elusivo asesino en serie.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo9fqxObXsLdFYCbh9TG3abGkIIY38SO9IHg&s', 'https://m.media-amazon.com/images/I/61E0FgTRRmL.jpg', 'https://youtu.be/yNncHPl1UXg?si=85RaKDBPx4w9S_4P', 2007, 3, 0),
('Desaparecida', 'Desaparecida, mundialmente conocida como The Vanishing, es una película neerlandesa de suspense psicológico de 1988 dirigida por George Sluizer, adaptada de la novela corta The Golden Egg de Tim Krabbé.', 'https://m.media-amazon.com/images/M/MV5BYmQ5NDY1NmItZWUyZi00NjY1LWE0ZTQtNTBmZmRlOWZkY2VhXkEyXkFqcGc@._V1_.jpg', 'https://pics.filmaffinity.com/Desaparecida-877105860-large.jpg', 'https://youtu.be/Z0PQmbaN8JM?si=y5Zu8amIqbcYWgK4', 1988, 3, 0);

-- Películas de Romance (category_id = 4)
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES 
('The Notebook', 'En una residencia de ancianos, un hombre lee a una mujer una historia de amor escrita en su viejo cuaderno de notas. Es la historia de Noah Calhoun y Allie Hamilton, dos jóvenes adolescentes de Carolina del Norte.', 'https://play-lh.googleusercontent.com/MGZioJEEiRHyC0kNqBBew_WPCbrK9a1ARy89CBgUbV5UcObaNDt5E0yTutuJKrDXwUbtzh-BUxlms9L_KA', 'https://m.media-amazon.com/images/I/91dXKp4WQJL.jpg', 'https://youtu.be/BjJcYdEOI0k?si=KeH3IivA56OaqPm2', 2004, 4, 0),
('La La Land', 'Mía y Sebastián son dos jóvenes que quieren abrirse camino en el mundo de Hollywood. Mía es una joven aspirante a actriz que trabaja como camarera mientras acude a castings y Sebastián toca el piano en bares. Un día sus caminos se cruzan e inmediatamente se enamoran.', 'https://resizing.flixster.com/6XuKxt7l5t0HypEmD84-jNAFlZs=/fit-in/705x460/v2/https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p12386480_p_v10_af.jpg', 'https://es.web.img3.acsta.net/pictures/16/11/30/17/44/581119.jpg', 'https://youtu.be/zBRkZZ6K1YU?si=6HkUaLJyYPPXOp-U', 2017, 4, 0),
('Orgullo y Prejuicio', 'En esta adaptación de la célebre novela de Jane Austen, la joven Lizzie conoce al apuesto y elegante señor Darcy, pero, a primera vista, le parece demasiado orgulloso y arrogante.', 'https://m.media-amazon.com/images/S/pv-target-images/15a41e61c30b3e9df74d61ac747fe3e1d5dc4ba30cf8ca3ac85a9148344efeba.jpg', 'https://pics.filmaffinity.com/Orgullo_y_prejuicio-766739677-large.jpg', 'https://youtu.be/Ov0PdD5c7m0?si=D4k0z_XxbqEt8sbM', 2005, 4, 0),
('Yo antes de ti', 'Louisa una chica inestable y creativa, reside en un pequeño pueblo de la campiña inglesa. Vive sin rumbo y va de un trabajo a otro para ayudar a su familia a llegar a fin de mes. Sin embargo, un nuevo trabajo pondrá a prueba su habitual alegría.', 'https://m.media-amazon.com/images/S/pv-target-images/20d5708d15616c1cacb57351d47118756a5abd3037583b62b8ebe44525ae54d9.jpg', 'https://m.media-amazon.com/images/M/MV5BZjU3NmJmYWItMDVhZC00NmM2LWI3YzEtYTg4MzA0YWZiYTQ2XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg', 'https://youtu.be/FRrc2X4Uzm4?si=8DzKz7fxheG5OdRf', 2016, 4, 0),
('Una cuestión de tiempo', 'Un hombre que tiene el don de revivir el pasado, decide conquistar el corazón de la bella Mary, pero pronto descubre que la senda del amor verdadero puede ser tan divertida como difícil... aunque se tenga la posibilidad de intentarlo una y otra vez.', 'https://m.media-amazon.com/images/S/pv-target-images/4d721bcb8fc19758e66e8242ebfb76dd26e2c0a85a4b21079761b5d6a43d5e8f.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/4d721bcb8fc19758e66e8242ebfb76dd26e2c0a85a4b21079761b5d6a43d5e8f.jpg', 'https://youtu.be/5DQAZtFHLEA?si=DYbOWaMCXIGL-JYy', 2013, 4, 0);

-- Películas de Terror (category_id = 5)
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES 
('The Conjuring', 'Basada en hechos reales. Narra los encuentros sobrenaturales que vivió la familia Perron en su casa de Rhode Island a principios de los 70.', 'https://es.web.img2.acsta.net/pictures/210/143/21014358_20130621122328102.jpg', 'https://m.media-amazon.com/images/M/MV5BMTM3NjA1NDMyMV5BMl5BanBnXkFtZTcwMDQzNDMzOQ@@._V1_FMjpg_UX1000_.jpg', 'https://youtu.be/ejMMn0t58Lc?si=b96FnHplgEEqWIGc', 2013, 5, 0),
('It', 'Varios niños de una pequeña ciudad del estado de Maine se alían para combatir a una entidad diabólica que adopta la forma de un payaso y desde hace mucho tiempo emerge cada 27 años para saciarse de sangre infantil.', 'https://upload.wikimedia.org/wikipedia/en/5/5a/It_(2017)_poster.jpg', 'https://m.media-amazon.com/images/M/MV5BZGZmOTZjNzUtOTE4OS00OGM3LWJiNGEtZjk4Yzg2M2Q1YzYxXkEyXkFqcGc@._V1_.jpg', 'https://youtu.be/_oBZ_zTz0Nw?si=PKVbVjzqj0AJuoMR', 2017, 5, 0),
('El resplandor', 'Jack Torrance es un hombre que se muda con su familia a un hotel aislado que debe cuidar, con la esperanza de salir del bloqueo creativo de su escritura. Mientras Jack no puede escapar del bloqueo, las visiones psíquicas de su hijo van en aumento.', 'https://m.media-amazon.com/images/M/MV5BYmUxZDU3NjktMzA1OS00OGUwLWJkOTctYzhjOGI5MTcyY2U3XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg', 'https://es.web.img3.acsta.net/pictures/14/04/15/10/46/568345.jpg', 'https://youtu.be/IiSjPcRWjYA?si=5j8S4dc4cG6VtXPq', 1980, 5, 0),
('Hereditary', 'Después de la muerte de la matriarca de los Graham, su hija, Annie, se muda a la casa con su familia. Annie espera olvidar los problemas que tuvo en su infancia allí, pero todo se tuerce cuando su hija empieza a ver figuras fantasmales.', 'https://upload.wikimedia.org/wikipedia/en/thumb/d/d9/Hereditary.png/250px-Hereditary.png', 'https://pics.filmaffinity.com/Hereditary-659865612-large.jpg', 'https://youtu.be/7jMdzpZgqb4?si=7dQGsDzMM7HbzwHV', 2018, 5, 0),
('Un lugar tranquilo', 'En un mundo invadido y arrasado por unos letales extraterrestres que se guían por el sonido, Evelyn y Lee Abbott sobreviven con sus hijos en una granja aislada en el bosque, sumidos en el más profundo silencio. Mientras no hagan ruido, estarán a salvo.', 'https://es.web.img2.acsta.net/pictures/18/02/15/13/03/3178762.jpg', 'https://es.web.img2.acsta.net/pictures/18/02/15/13/03/3178762.jpg', 'https://youtu.be/nvPdDhmLMAI?si=OmHmkRTG0wZcjXfK', 2018, 5, 0);

-- Película destacada para el Hero (Dune - Ciencia Ficción/Acción)
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES 
('Dune: Parte Dos', 'Paul Atreides se une a Chani y a los Fremen mientras busca venganza.', 'https://images.unsplash.com/photo-1541963463532-d68292c34b19?w=500', 'https://images.unsplash.com/photo-1541963463532-d68292c34b19?w=1920', 'https://youtu.be/Qv7I3wDfFzI?si=2tVBp2-MqZJG1EAc', 2024, 1, 1);


INSERT INTO PLAN (Nombre, Precio, Ventajas) VALUES 
('Estándar con Anuncios', 9.99, 'Video 1080p Full HD, 2 Dispositivos, Descargas permitidas'),
('Estándar', 13.99, 'Calidad 4K UHD y HDR, 4 dispositivos a la vez, Sonido Dolby Atmos, Sin anuncios'),
('Premium', 19.99, 'Todo lo de Premium, Acceso anticipado a estrenos, 6 dispositivos a la vez');

-- Categoria de Star Wars (category_id = 6)--
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES
('Star Wars I','La República Galáctica está sumida en el caos. Los impuestos de las rutas comerciales a los sistemas estelares exteriores están en disputa. Esperando resolver el asunto con un bloqueo de poderosas naves de guerra, la codiciosa Federación del Comercio ha detenido todos los envíos al pequeño planeta de Naboo.','https://static.wikia.nocookie.net/esstarwars/images/7/75/EPI_TPM_poster.png/revision/latest?cb=20240316183455','https://m.media-amazon.com/images/I/71CUn4X2DyL._AC_UF1000,1000_QL80_.jpg','https://youtu.be/n1CUHjrc9Sc?si=CzERrkuQLcIsWU-k', 1999, 0),
('Star Wars II','En el Senado Galáctico reina la inquietud. Varios miles de sistemas solares han declarado su intención de abandonar la República. Este movimiento separatista, liderado por el misterioso conde Dooku, ha provocado que al limitado número de caballeros Jedi les resulte difícil mantener la paz y el orden en la galaxia.','https://m.media-amazon.com/images/I/71BOzlsFAYL._AC_UF894,1000_QL80_.jpg','https://static.wikia.nocookie.net/esstarwars/images/d/dd/Attack-Clones-Poster.jpg/revision/latest?cb=20240331173853','https://youtu.be/gYbW1F_c9eM?si=bhEzk-gV844N0_1H', 2002, 0),
('Star Wars III','¡Guerra! La República se desmorona bajo los ataques del despiadado Lord Sith, el conde Dooku. Hay héroes en ambos bandos, pero el mal está por doquier.','https://m.media-amazon.com/images/M/MV5BMGVkMGUwZDctNTMwZS00YzIwLWIxY2UtOGZjZjY4ZGMxYzg0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg','https://static.wikia.nocookie.net/esstarwars/images/f/fa/Ep3_poster.jpg/revision/latest?cb=20060407220934','https://youtu.be/kqkfjBKmWc4?si=cgfOn3V5O5_rM7IS',2005, 0),
('Star Wars IV','La nave en la que viaja la princesa Leia es capturada por las tropas imperiales al mando del temible Darth Vader. Antes de ser atrapada, Leia consigue introducir un mensaje en su robot R2-D2, quien acompañado de su inseparable C-3PO logran escapar.', 'https://m.media-amazon.com/images/I/81CIXJxQ3TL.jpg','https://m.media-amazon.com/images/I/51H+wEI8UtL._AC_UF1000,1000_QL80_.jpg','https://youtu.be/beAH5vea99k?si=V2HiKzuZJzEQKk3B',1997,0);


-- Categoria de Pixar (category_id = 7)--
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES
('Toy Story','Los juguetes de Andy, un niño de seis años, temen que un nuevo regalo les sustituya en el corazón de su dueño. Woody, un vaquero que ha sido hasta ahora el juguete favorito, trata de tranquilizarlos hasta que aparece Buzz Lightyear.','https://imusic.b-cdn.net/images/item/original/137/8717418520137.jpg?v-a-2018-toy-story-1-dvd&class=scaled&v=1548020412','https://m.media-amazon.com/images/M/MV5BZTA3OWVjOWItNjE1NS00NzZiLWE1MjgtZDZhMWI1ZTlkNzYwXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg','https://youtu.be/VhCDgv4x_pU?si=avZDLMi7tZMmjUAP',1996,0),
('Los Increibles','Un superhéroe retirado lucha contra el aburrimiento en un suburbio y junto con su familia tiene la oportunidad de salvar al mundo.','https://static.wikia.nocookie.net/los-increibles/images/c/c0/Los-Increibles-Disney-Pixar-Caratula-DVD.jpg/revision/latest?cb=20150215005220&path-prefix=es','https://m.media-amazon.com/images/M/MV5BNGNhMDYxNjktZjM1OS00MjI4LTgxYTAtZjIzODQ4NDVjYzU4XkEyXkFqcGc@._V1_.jpg','https://youtu.be/dXf8VjUY800?si=WN80T5VSiuMF-88p', 2004,0),
('Cars','El aspirante a campeón de carreras Rayo McQueen parece que está a punto de conseguir el éxito. Su actitud arrogante se desvanece cuando llega a una pequeña comunidad olvidada que le enseña las cosas importantes de la vida que había olvidado.','https://m.media-amazon.com/images/I/71cUI86B9fL._AC_UF894,1000_QL80_.jpg','https://es.web.img3.acsta.net/c_310_420/pictures/14/05/28/11/24/435900.jpg','https://youtu.be/W_H7_tDHFE8?si=nykc6BXANR0HiXEk',2006,0),
('Ratatouille','Remy es una rata que aprecia la buena comida y tiene un paladar bastante sofisticado. Su sueño es convertirse algún día en un gran chef francés a pesar de la oposición de su familia.','https://static.wikia.nocookie.net/doblaje/images/1/1e/C6b038f42ea34a14434144f3ea55e0a0--disney-movie-posters-disney-films.jpg/revision/latest?cb=20200811235000&path-prefix=es','https://play-lh.googleusercontent.com/Xu-GvQz9C929tmaqcOIYDwUY8q7rPIKDvkKszlG9EDCgPcaffA8BfcYBNrUt7mUwq-Ga','https://youtu.be/b5ZNJoS2RtI?si=0703bIE4xsZOK3Pj', 2007,0);


-- Categoria de DreamWorks (category_id = 8)--
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES
('Shrek','Hace mucho tiempo, en una lejana ciénaga, vivía un ogro llamado Shrek. Un día, su preciada soledad se ve interrumpida por un montón de personajes de cuento de hadas que invaden su casa. Todos fueron desterrados de su reino por el malvado Lord Farquaad.','https://es.web.img3.acsta.net/pictures/14/03/06/10/13/369709.jpg','https://static.wikia.nocookie.net/doblaje/images/6/69/Shrekban.png/revision/latest?cb=20200731225428&path-prefix=es','https://youtu.be/CwXOrWvPBPk?si=qyyA4k7ienmUj68G',2001,0),
('Kung Fu Panda','Un panda patoso y bonachón es elegido para cumplir una antigua profecía: debe convertirse en un experto en artes marciales y defender a su gente de un leopardo de las nieves terrible.','https://m.media-amazon.com/images/S/pv-target-images/4cab81d9595c6f473f75d9d89d95fe134eed871e510533a941d1d69930a24c47.jpg','https://m.media-amazon.com/images/M/MV5BZDU5MDNiMGItYjVmZi00NDUxLTg2OTktNGE0NzNlNzM4NzgyXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg','https://youtu.be/NRc-ze7Wrxw?si=ChsqZUe0sUPGv5x7', 2008,0),
('Como Entrenar a tu Dragon','Hipo, un vikingo adolescente, comienza las clases de entrenamiento con dragones, y ve por fin una oportunidad para demostrar que es capaz de convertirse en guerrero, cuando hace amistad con un dragón herido.','https://m.media-amazon.com/images/S/pv-target-images/3b48c7641f6c89ce2f878f7f22400ce2bd32c4b41bcdd04383c93f69f684eead.jpg','https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgV-u6834rJfRooMB-3mpxHK8p_e7Dm9kka92EGFaglb7uPNw9qyAloCUINS1zSUD275rw5LvGnSX5GhVO8SxntzoyD0RyuNhkl7sE-AzubdQ-DQzIjLZQvv2PPLD7woovzV00VGZrFM525/s1600/COMO+ENTRENAR+A+TU+DRAGON.jpg','https://youtu.be/zUC2tcKYmEY?si=A2ZR_DyfoMIroMBM', 2010,0),
('Madagascar','Cuatro animales muy mimados del zoo de Nueva York naufragan en la isla de Madagascar y deben aprender a sobrevivir en un mundo salvaje.','https://m.media-amazon.com/images/I/81WJN6BTG0L._AC_UF1000,1000_QL80_.jpg','https://m.media-amazon.com/images/I/51zVz0czkaL._AC_UF894,1000_QL80_.jpg','https://youtu.be/y2_wbsLQtoQ?si=3MoKQsqL10R7z5Pc',2005,0);


-- Categoria de Marvel (category_id = 9)--
INSERT INTO MOVIES (Titulo, Descripcion, posterURL, ImagenHeroSectionURL, videoURL, AnyoEstreno, idCategoria, Destacado) VALUES
('Avengers: Endgame', 'Los héroes más poderosos de la tierra se enfrentan a Thanos.', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAhBrkgvM5cJgj841EsmPRRS4_rHh3S3BKs-WlllOzdJIzd9tpx8sCSBnPb03EmmGyXu2lwqAfnaOVthljrpBjuNqLs7jZpAgrm0xT4IdACiaOFjNBqrQolLlbrb04VY5-VHpNJlpEwpEOvDF1lmaGBVA6nYfcHk2KoGoUy0ZYnAvd34KJ4qz1rEvOOJadd9PYUv34ItleFZ1YVOrw-SieYFvhwwavCIFv1T-Z8G5NUupAo8tjRZKREb-U-EQm0PYhTXkc-emAX0gs', 'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/9/9b/Avenger_Endgame_Poster_Oficial.png/revision/latest?cb=20190326185910&path-prefix=es', 'https://youtu.be/svLSGZkTzC0?si=19uhYhtnw0PFRS2R', 2019, 1, 0),
('Doctor Strange','La vida del famoso neurocirujano Dr. Stephen Strange cambia para siempre cuando un terrible accidente de coche le arrebata el uso de sus manos.','https://static.wikia.nocookie.net/marvelcinematicuniverse/images/6/64/Doctor_Strange_-_Poster_2.png/revision/latest?cb=20191029195245&path-prefix=es','https://play-lh.googleusercontent.com/cjFhKj7jsHovZqIWZ45jerOygdkoS5dZgqccF3wfEEG-xYHhy0umEbwhXbeadCCl59I=w240-h480-rw','https://youtu.be/PqTILYUNU3s?si=0DMzQaZyn10mo3nS',2016,0),
('SpiderMan', 'Mordido por una araña genéticamente modificada, un estudiante de secundaria tímido y torpe obtiene increíbles capacidades como arácnido.', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBIeDzAzUQq9e1vqWBrbRFoIq4U3tzk1WBACDLkayBdvOhpCOugl6g49R1B-CHfTpLibd22nIt_rtWBn583Df5_CV6ecKLpEr_HkmG53z59RqIXV8YWgMkOj3Z5BXdATKn6gUsGEtGN8KRY2rBBBO0utFlydPwK6qava_9oVd53u4624WePdILIrJUuz-5v73q2HI3rHDX7uQSdHDq9Vyc4IdnJXYtUjDFxnV_Hmfs-Us-DAYThiMqC6_ORlyIZnccCt5pmUYWsNIk', 'https://static.wikia.nocookie.net/spiderman/images/8/85/Spider-Man2002Poster.png/revision/latest?cb=20131213162615&path-prefix=es', 'https://youtu.be/_yhFofFZGcc?si=VxpZivnGgDxZTkww', 2002, 1, 0),
('Black Panther','Hace millones de años, un meteorito de poderoso vibranium impactó en África. Cuando llegó la era del hombre, la mayoría de los habitantes de aquel territorio se unieron bajo el mando de un guerrero ...','https://m.media-amazon.com/images/M/MV5BMTg1MTY2MjYzNV5BMl5BanBnXkFtZTgwMTc4NTMwNDI@._V1_.jpg','https://lumiere-a.akamaihd.net/v1/images/p_blackpanther_19754_4ac13f07.jpeg?region=0,0,540,810','https://youtu.be/JK-wAfAvJ0g?si=mYQfwRLHL5PHoMbr',2018,0);

INSERT INTO CATEGORIAS (Nombre, slug) VALUES 
('Star wars','star_wars'),
('Pixar','pixar'),
('National Geographic','national_geographic'),
('Marvel','marvel'),
('Star','star');