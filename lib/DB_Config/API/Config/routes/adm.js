import { Router } from 'express';
const router = Router();
import { hash } from 'bcrypt';
import { queryAsync } from '../db/db.js';

const saltRounds = 10;


router.get('/', async (req, res) => {
    try {
      const results = await queryAsync('SELECT * FROM adm', []); 
      res.json(results); 
    } catch (err) {
      console.error('Erro ao buscar admins:', err); 
      return res.status(500).json({ error: 'Erro ao buscar admins' });
    }
  });
  
router.post('/', async (req, res) => {
    const {nome, email, senha, telefone, cod_adm} = req.body;
    if (!nome || !email || !senha || !telefone || !cod_adm) {
        return res.status(400).json({error: 'todos os campos são obrigatórios'});
    }
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        return res.status(400).json({error: 'Email inválido'});
    };

    try {
        const checkEmailQuery  = 'SELECT * FROM adm WHERE email = ?';
        const emailExist = await queryAsync(checkEmailQuery, [email]);
        if (emailExist.length > 0) {
            return res.status(409).json({error: 'Email ja cadastrado'});
        }
        const hashedPassword = await hash(senha, saltRounds);
        const sql = 'INSERT INTO adm (nome, email, senha, telefone, cod_adm) VALUES (?, ?, ?, ?, ?)';
        const results = await queryAsync(sql, [nome, email, hashedPassword, telefone, cod_adm]);

        res.json({ message: 'Adm created successfully', id: results.insertId });
    } catch (err) {
        console.error('Error creating adm:', err);
        return res.status(500).json({ error: 'Error ao criar adm' });
    }
});

router.put('/:id', async (req, res) => {
    const {id} = req.params;
    const {nome, senha, telefone} = req.body;
    const sql = 'UPDATE adm SET nome = ?, senha = ?, telefone = ? WHERE id = ?';
    try {
        const results = await queryAsync(sql, [nome, senha, telefone, id]);
        if (results.affectedRows === 0) {
            return res.status(404).json({message: 'Adm não encontrado'});
        }
        res.json({message: 'Adm atualizado com sucesso', id: req.params.id});
    } catch (err) {
        console.error('Erro ao atualizar adm', err);
        return res.status(500).json({error: 'Erro ao atualizar adm'});
    };
});

router.delete('/:id', async (req, res) => {
    const {id} = req.params;
    const sql = 'DELETE FROM adm WHERE id = ?';
    try {
        const results = await queryAsync(sql, [id]);
        if (results.affectedRows === 0) {
            return res.status(404).json({message: 'Adm não encontrado'});
        }
        res.json({message: 'Adm deletado com sucesso', id: req.params.id});
    } catch (err) {
        console.error('Erro ao deletar adm', err);
        return res.status(500).json({error: 'Erro ao deletar adm'});
    };
});

router.get('/:id', async (req, res) => {
    const {id} = req.params;
    const sql = 'SELECT * FROM adm WHERE id = ?';
    try{
        const results = await queryAsync(sql, [id]);

        if (results.length === 0) {
            return res.status(404).json({message: 'Adm não encontrado'});
        }
        res.json(results[0]);
    } catch (err) {
        console.error('Erro ao buscar adm', err);
        return res.status(500).json({error: 'Erro ao buscar adm'});
    }
});

export default router;
