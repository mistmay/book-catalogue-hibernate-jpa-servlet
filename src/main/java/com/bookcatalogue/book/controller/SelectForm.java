package com.bookcatalogue.book.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookcatalogue.book.dao.Dao;
import com.bookcatalogue.book.model.Author;
import com.bookcatalogue.book.model.Book;
import com.bookcatalogue.book.model.Genre;

@WebServlet("/SelectForm")
public class SelectForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		String formType = request.getParameter("form-type");
		if (formType.equals("book")) {
			List<Author> authorList = Dao.getAllAuthors();
			List<Genre> genreList = Dao.getAllGenres();
			request.setAttribute("authorList", authorList);
			request.setAttribute("genreList", genreList);
		} else if (formType.equals("list")) {
			List<Book> bookList = Dao.getAllBooks();
			request.setAttribute("bookList", bookList);
		}
		request.setAttribute("formType", formType);
		dispatcher.forward(request, response);
	}

}
