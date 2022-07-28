package com.bookcatalogue.book.dao;

import java.util.ArrayList;
import java.util.List;

import com.bookcatalogue.book.model.Author;
import com.bookcatalogue.book.model.Book;
import com.bookcatalogue.book.model.Genre;
import com.bookcatalogue.book.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class Dao {
	public static List<Author> getAllAuthors() {
		List<Author> authorList = new ArrayList<>();
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
		entityManager.getTransaction().begin();
		TypedQuery<Author> query = entityManager.createQuery("select i from Author i", Author.class);
		authorList = query.getResultList();
		entityManager.getTransaction().commit();
		entityManager.close();
		return authorList;
	}

	public static List<Genre> getAllGenres() {
		List<Genre> genreList = new ArrayList<>();
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
		entityManager.getTransaction().begin();
		TypedQuery<Genre> query = entityManager.createQuery("select i from Genre i", Genre.class);
		genreList = query.getResultList();
		entityManager.getTransaction().commit();
		entityManager.close();
		return genreList;
	}
	
	public static List<Book> getAllBooks() {
		List<Book> bookList = new ArrayList<>();
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
		entityManager.getTransaction().begin();
		TypedQuery<Book> query = entityManager.createQuery("select i from Book i", Book.class);
		bookList = query.getResultList();
		entityManager.getTransaction().commit();
		entityManager.close();
		return bookList;
	}

	public static void addAuthor(String name, String surname) {
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
		entityManager.getTransaction().begin();
		Author author = new Author();
		author.setName(name);
		author.setSurname(surname);
		entityManager.persist(author);
		entityManager.getTransaction().commit();
		entityManager.close();
	}

	public static void addGenre(String name) {
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
		entityManager.getTransaction().begin();
		Genre genre = new Genre();
		genre.setName(name);
		entityManager.persist(genre);
		entityManager.getTransaction().commit();
		entityManager.close();
	}
	
	public static void addBook(String title, int authorId, String[] genres) {
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
		entityManager.getTransaction().begin();
		Author currentAuthor = entityManager.find(Author.class, authorId);
		List<Genre> currentGenres = new ArrayList<>();
		for (String current : genres) {
			currentGenres.add(entityManager.find(Genre.class, Integer.parseInt(current)));
		}
		Book book = new Book();
		book.setAuthor(currentAuthor);
		book.setGenres(currentGenres);
		book.setTitle(title);
		entityManager.persist(book);
		entityManager.getTransaction().commit();
	    entityManager.close();
	}
	
	public static void updateBook(String title, int authorId, String[] genres, int idBook) {
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
		entityManager.getTransaction().begin();
		Author currentAuthor = entityManager.find(Author.class, authorId);
		List<Genre> currentGenres = new ArrayList<>();
		for (String current : genres) {
			currentGenres.add(entityManager.find(Genre.class, Integer.parseInt(current)));
		}
		Book book = entityManager.find(Book.class, idBook);
		book.setAuthor(currentAuthor);
		book.setGenres(currentGenres);
		book.setTitle(title);
		entityManager.getTransaction().commit();
	    entityManager.close();
	}
	
	public static void removeBook(int id) {
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
		entityManager.getTransaction().begin();
		Book book = entityManager.find(Book.class, id);
		entityManager.remove(book);
		entityManager.getTransaction().commit();
	    entityManager.close();
	}
	
	public static Book getBookById(int id) {
		EntityManager entityManager = JPAUtil.getEntityManagerFactory().createEntityManager();
        entityManager.getTransaction().begin();
        Book book = entityManager.find(Book.class, id);
        entityManager.getTransaction().commit();
        entityManager.close();
        return book;
	}
}
