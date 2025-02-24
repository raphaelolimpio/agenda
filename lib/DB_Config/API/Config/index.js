import dotenv from 'dotenv';
import express, { json } from 'express';
import cors from 'cors';
import { queryAsync } from './db/db.js';

dotenv.config();
const app = express();
app.use(express.json());

import admRouter from './routes/adm.js';
import agendRouter from './routes/agenda.js';
import userRouter from './routes/usuario.js';
import admLoginRouter from './login/login_adm.js';
import userLoginRouter from './login/login_user.js';

app.use('/adm', admRouter);
app.use('/agenda', agendRouter);
app.use('/usario', userRouter);
app.use('/login/adm', admLoginRouter);
app.use('/login/user', userLoginRouter);


app.use(cors());
app.use(json());

app.get('/', async (req, res) => {
  try {
    const results = await queryAsync('SELECT NOW()');
    res.send('Conexão bem-sucedida ao MySQL: ' + results[0]['NOW()']);
  } catch (err) {
    res.status(500).send('Erro ao acessar o banco de dados');
    return;
  }
});
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});



