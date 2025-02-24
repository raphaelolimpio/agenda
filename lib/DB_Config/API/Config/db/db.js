import mysql from 'mysql2';
import dotenv from 'dotenv';
import { promisify } from 'util';

dotenv.config();

const connection = mysql.createConnection({
  host: process.env.DB_HOST,         
  user: process.env.DB_USER,         
  password: process.env.DB_PASS,     
  database: process.env.DB_NAME,     
  port: process.env.DB_PORT          
});

connection.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados: ' + err.stack);
    return;
  }
  console.log('Conectado ao banco de dados MySQL como ID ' + connection.threadId);
});

const queryAsync = promisify(connection.query).bind(connection);

process.on('SIGINT', () => {
    connection.end((err) => {
      if (err) {
        console.error('Erro ao fechar a conexão com o banco de dados:', err);
      } else {
        console.log('Conexão com o banco de dados fechada.');
      }
      process.exit(0);
    });
  });



export { queryAsync, connection };
export default connection;
