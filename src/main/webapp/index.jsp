<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="com.bookcatalogue.book.model.*, java.util.*, com.bookcatalogue.book.dao.*"%>
<%
String formType = (String) request.getAttribute("formType");
List<Author> authorList = (List<Author>) request.getAttribute("authorList");
List<Genre> genreList = (List<Genre>) request.getAttribute("genreList");
List<Book> bookList = (List<Book>) request.getAttribute("bookList");
Book bookToUpdate = (Book) request.getAttribute("bookUpdate");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="author" content="Giuseppe Marchesiello">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">
<title>Book Catalogue</title>
</head>

<body>
	<main
		class="py-5 px-2 bg-light d-flex flex-column align-items-center gap-4"
		style="min-height: calc(100vh - 70px)">
		<h1 class="fs-1 fw-bold mb-4 text-center">Book Catalogue</h1>
		<section
			class="container bg-white rounded border border-dark d-flex flex-column align-items-center gap-3">
			<form action="SelectForm" method="post"
				class="p-4 text-center d-flex align-items-center gap-2 flex-wrap">
				<div class="d-flex justify-content-center align-items-center gap-2">
					<label for="form-type">What do You Want To do?</label> <select
						id="form-type" name="form-type" class="p-2 rounded" required>
						<option value="author">Add Author</option>
						<option value="genre">Add Genre</option>
						<option value="book">Add Book</option>
						<option value="list">See all Books</option>
					</select>
				</div>
				<button type="submit" class="btn btn-primary">Go</button>
			</form>
			<%
			if (formType != null) {
				if (formType.equals("author")) {
			%>
			<form action="AddAuthor" method="post"
				class="p-4 d-flex flex-column align-items-center gap-2 text-center">
				<h2>Add new Author:</h2>
				<div class="d-flex flex-column align-items-center gap-2">
					<label for="author-name">Name</label> <input type="text"
						name="name" id="author-name" class="p-2 rounded"
						placeholder="Name" required>
				</div>
				<div class="d-flex flex-column align-items-center gap-2">
					<label for="author-surname">Surname</label> <input type="text"
						name="surname" id="author-surname" class="p-2 rounded"
						placeholder="Surname" required>
				</div>
				<button type="submit" class="btn btn-primary">Add</button>
			</form>
			<%
			} else if (formType.equals("genre")) {
			%>
			<form action="AddGenre" method="post"
				class="p-4 d-flex flex-column align-items-center gap-2 text-center">
				<h2>Add new Genre:</h2>
				<div class="d-flex flex-column align-items-center gap-2">
					<label for="genre-name">Name</label> <input type="text" name="name"
						id="genre-name" class="p-2 rounded" placeholder="Name" required>
				</div>
				<button type="submit" class="btn btn-primary">Add</button>
			</form>
			<%
			} else if (formType.equals("book")) {
			if (authorList.size() > 0 && genreList.size() > 0) {
			%>
			<form action="AddBook" method="post"
				class="p-4 d-flex flex-column align-items-center gap-2 text-center">
				<h2>Add new Book:</h2>
				<div class="d-flex flex-column align-items-center gap-2">
					<label for="title">Title</label> <input type="text" name="title"
						id="title" class="p-2 rounded" placeholder="Title" required>
				</div>
				<div class="d-flex flex-column align-items-center gap-2">
					<label for="author">Author</label> <select id="author"
						name="author" class="p-2 rounded" required>
						<%
						for (Author currentAuthor : authorList) {
						%>
						<option value="<%=currentAuthor.getId()%>">
							<%=currentAuthor.getName()%>
							<%=currentAuthor.getSurname()%>
						</option>
						<%
						}
						%>
					</select>
				</div>
				<table class="table text-center">
					<tr>
						<th class="fw-bold fs-5">Genres</th>
					</tr>
					<tr>
						<td class="d-flex align-items-center gap-2 flex-wrap">
							<%
							for (Genre currentGenre : genreList) {
							%> <input type="checkbox" name="genres"
							value="<%=currentGenre.getId()%>" class="checkbox"><%=currentGenre.getName()%><br />
							<%
							}
							%>
						</td>
					</tr>
				</table>
				<button type="submit" class="btn btn-primary" id="book-form">Add</button>
			</form>
			<%
			} else {
			%>
			<p class="fw-bold text-center">You can't add a book If there are
				not Authors or Genres in the system</p>
			<%
			}
			} else if (formType.equals("list")) {
			%>
			<div class="w-100">
				<h2 class="text-center mb-3">List all Books:</h2>
				<%
				if (bookList.size() > 0) {
				%>
				<table class="table text-center w-100">
					<thead>
						<tr>
							<th scope="col">Title</th>
							<th scope="col">Author</th>
							<th scope="col">Genres</th>
							<th scope="col">Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Book currentBook : bookList) {
						%>
						<tr>
							<td><%=currentBook.getTitle()%></td>
							<td><%=currentBook.getAuthor().getName()%> <%=currentBook.getAuthor().getSurname()%></td>
							<td>
								<%
								for (Genre currentGenre : currentBook.getGenres()) {
								%> <%=currentGenre.getName()%><br /> <%
 }
 %>
							</td>
							<td
								class="d-flex justify-content-center align-items-center gap-2">
								<form action="RemoveBook" method="post">
									<input type="hidden" name="toDelete"
										value="<%=currentBook.getId()%>">
									<button type="submit" class="btn btn-danger">X</button>
								</form>
								<form action="ToUpdateForm" method="post">
									<input type="hidden" name="toUpdate"
										value="<%=currentBook.getId()%>">
									<button type="submit" class="btn btn-primary">Update</button>
								</form>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<%
				} else {
				%>
				<p class="fw-bold text-center">No Books in Database</p>
				<%
				}
				%>
			</div>
			<%
			} else if (formType.equals("update")) {
			if (authorList.size() > 0 && genreList.size() > 0 && bookToUpdate != null) {
			%>
			<form action="UpdateBook" method="post"
				class="p-4 d-flex flex-column align-items-center gap-2 text-center">
				<h2>Update Book:</h2>
				<input type="hidden" name="bookId" value="<%=bookToUpdate.getId()%>">
				<div class="d-flex flex-column align-items-center gap-2">
					<label for="title">Title</label> <input type="text" name="title"
						id="title" class="p-2 rounded" placeholder="Title" required
						value="<%=bookToUpdate.getTitle()%>">
				</div>
				<div class="d-flex flex-column align-items-center gap-2">
					<label for="author">Author</label> <select id="author"
						name="author" class="p-2 rounded" required>
						<%
						for (Author currentAuthor : authorList) {
						%>
						<option value="<%=currentAuthor.getId()%>"
							<%if (currentAuthor.getId() == bookToUpdate.getAuthor().getId()) {%>
							selected <%}%>>
							<%=currentAuthor.getName()%>
							<%=currentAuthor.getSurname()%>
						</option>
						<%
						}
						%>
					</select>
				</div>
				<table class="table text-center">
					<tr>
						<th class="fw-bold fs-5">Genres</th>
					</tr>
					<tr>
						<td class="d-flex align-items-center gap-2 flex-wrap">
							<%
							for (Genre currentGenre : genreList) {
							%> <input type="checkbox" name="genres"
							value="<%=currentGenre.getId()%>" class="checkbox"
							<%boolean check = false;
for (Genre comparedGenre : bookToUpdate.getGenres()) {
	if (comparedGenre.getId() == currentGenre.getId()) {
		check = true;
	}
}
if (check) {%>
							checked <%}%>> <%=currentGenre.getName()%><br /> <%
 }
 %>
						</td>
					</tr>
				</table>
				<button type="submit" class="btn btn-primary" id="book-form">Update</button>
			</form>
			<%
			}
			}
			}
			%>
		</section>
	</main>
	<script type="text/javascript">
        window.addEventListener('DOMContentLoaded', () => {
        	if (document.querySelector("#book-form")) {
        		document.querySelector("#book-form").addEventListener("click", (event) => {
                	let checked = false;
                	document.querySelectorAll(".checkbox").forEach(element => {
                		if(element.checked) {
                			checked = true;
                		}
                	});
                	if (!checked) {
                		event.preventDefault();
                		alert("Scegli almeno un ingrediente");
                	}
                });
        	}
        });
    </script>
</body>

</html>