import dotenv from 'dotenv'; 
import express, { json } from 'express';
import cors from 'cors';
import db from './db/db.js';

dotenv.config();
const app = express();


import admRouter from './routes/adm.js';
import agendRouter from './routes/agenda.js';
import userRouter from './routes/user.js';
import admLoginRouter from './login/login_adm.js';
import userLoginRouter from './login/login_user.js';



app.use('/adm', admRouter);
app.use('/agenda', agendRouter);
app.use('/user', userRouter);
app.use('/login', admLoginRouter);
app.use('/login', userLoginRouter);




app.use(cors());
app.use(json());


app.get('/', (req, res) => {
  db.query('SELECT NOW()', (err, results) => {
    if (err) {
      res.status(500).send('Erro ao acessar o banco de dados');
      return;
    }
    res.send('Conexão bem-sucedida ao MySQL: ' + results[0]['NOW()']);
  });
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});
