const express = require('express');

const app = express();

app.use(express.json());

let books = [
    { title: 'Harry Potter', id: 1 },
    { title: 'Twilight', id: 2 },
    { title: 'Lorien Legacies', id: 3 }
];

// GET - All books
app.get('/api/books', (req, res) => {
    res.send(books);
});

// GET - Book by ID
app.get('/api/books/:id', (req, res) => {
    const book = books.find(c => c.id === parseInt(req.params.id));

    if (!book) {
        return res.status(404).send('Book not found');
    }

    res.send(book);
});

// POST - Add a new book
app.post('/api/books', (req, res) => {
    const book = {
        title: req.body.title,
        id: books.length + 1
    };

    books.push(book);
    res.status(201).send(book);
});

// PUT - Update a book
app.put('/api/books/:id', (req, res) => {
    const book = books.find(c => c.id === parseInt(req.params.id));

    if (!book) {
        return res.status(404).send('Book not found');
    }

    book.title = req.body.title;

    res.send(book);
});

// DELETE - Delete a book
app.delete('/api/books/:id', (req, res) => {
    const book = books.find(c => c.id === parseInt(req.params.id));

    if (!book) {
        return res.status(404).send('Book not found');
    }

    books = books.filter(c => c.id !== parseInt(req.params.id));

    res.send(book);
});

const port = process.env.PORT || 8080;

app.listen(port, () => {
    console.log(`Listening on port ${port}..`);
});