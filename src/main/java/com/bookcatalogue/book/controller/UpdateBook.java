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
import com.bookcatalogue.book.model.Book;

@WebServlet("/UpdateBook")
public class UpdateBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		int id = Integer.parseInt(request.getParameter("bookId"));
		String title = request.getParameter("title");
		int authorId = Integer.parseInt(request.getParameter("author"));
		String[] genres = request.getParameterValues("genres");
		Dao.updateBook(title, authorId, genres, id);
		List<Book> bookList = Dao.getAllBooks();
		request.setAttribute("bookList", bookList);
		request.setAttribute("formType", "list");
		dispatcher.forward(request, response);
	}

}
