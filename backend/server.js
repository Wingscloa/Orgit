const express = require('express');
const pool = require('./db');

const port = 3000;

const app = express();
app.use(express.json());


//routes
app.get('/', async (req,res) =>{
    try{
        const data = await pool.query('SELECT * FROM schools')
        res.status(200).send({children: data.rows }); 
    }
    catch (e){
        console.log(e);
        res.sendStatus(500);
    }
})


app.post('/', async (req,res) =>{
    const {name, location} = req.body
    try{
        await pool.query('INSERT INTO schools (name) VALUES ("ahoj")')
        res.status(200).send({message: "Succes"}); 
    }
    catch (e){
        console.log(e);
        res.sendStatus(500);
    }
})


app.get('/setup', async (req,res) =>{
    try{
        await pool.query('CREATE TABLE schools(id SERIAL PRIMARY KEY, name VARCHAR(100))')
    }
    catch (e){
        console.log(e);
        res.sendStatus(500);
    }
})


app.listen(port, () => console.log(`Server has been started on port : ${port}`));