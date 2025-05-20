from typing import Dict, Iterator, List, Optional
from datetime import datetime

class Movie:
    def __init__(self, title: str, year: int, genre: str, rating: float = 0.0):
        self.title = self._validate_title(title)
        self.year = self._validate_year(year)
        self.genre = self._validate_genre(genre)
        self.rating = self._validate_rating(rating)

    def _validate_title(self, title: str) -> str:
        if not title.strip():
            raise ValueError("Название фильма не может быть пустым.")
        if not all(c.isalnum() or c.isspace() or c in "-:,'." for c in title):
            raise ValueError("Название содержит запрещённые символы.")
        return title.strip()

    def _validate_year(self, year: int) -> int:
        current_year = datetime.now().year
        if not 1888 <= year <= current_year:
            raise ValueError(f"Год должен быть в диапазоне 1888–{current_year}.")
        return year

    def _validate_genre(self, genre: str) -> str:
        if not genre.strip():
            raise ValueError("Жанр не может быть пустым.")
        return genre.strip()

    def _validate_rating(self, rating: float) -> float:
        if not 0.0 <= rating <= 10.0:
            raise ValueError("Рейтинг должен быть от 0.0 до 10.0.")
        return rating

    def __str__(self) -> str:
        return f"{self.title} ({self.year}), {self.genre}, ★ {self.rating:.1f}"

class MovieCollection:
    def __init__(self):
        self._movies: Dict[str, Movie] = {}

    def add_movie(self, movie: Movie) -> None:
        if movie.title in self._movies:
            raise ValueError(f"Фильм '{movie.title}' уже существует!")
        self._movies[movie.title] = movie
        print(f"Фильм '{movie.title}' добавлен.")

    def remove_movie(self, title: str) -> None:
        if title not in self._movies:
            raise ValueError(f"Фильм '{title}' не найден!")
        del self._movies[title]
        print(f"Фильм '{title}' удалён.")
if __name__ == "__main__":
    collection = MovieCollection()

    try:
        collection.add_movie(Movie("Inception", 2010, "Sci-Fi", 8.8))
        collection.add_movie(Movie("The Dark Knight", 2008, "Action", 9.0))
                   
        collection.add_movie(Movie("", 2025, "Drama"))  
    except ValueError as e:
        print(f"Ошибка: {e}")

    try:
        collection.add_movie(Movie("Bad@Movie", 1999, "Thriller"))  
    except ValueError as e:
        print(f"Ошибка: {e}")

    try:
        collection.add_movie(Movie("Old Movie", 1500, "Silent")) 
    except ValueError as e:
        print(f"Ошибка: {e}")

    print("\nФильмы в коллекции:")
    for movie in collection:
        print(movie)
