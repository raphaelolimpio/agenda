import { Router } from 'express';
import { queryAsync } from '../db/db.js'; 
import { hash } from 'bcrypt';
const router = Router();
import verificationAdmUser from '../middleware/verification_adm_user.js';

const saltRounds = 10;

router.post('/', async (req, res) => {
    const { nome1, nome2, email, senha, telefone, cod_adm } = req.body;

    if (!nome1 || !email || !senha || !telefone || !cod_adm) {
        return res.status(400).send('Nome1, Email, Senha, Telefone e Código de Administrador são obrigatórios');
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        return res.status(400).send('Email inválido');
    }

    try {
        const emailExist = 'SELECT * FROM usuario WHERE email = ?';
        const results = queryAsync(emailExist, [email]);

        if (results.length > 0) {
            return res.status(409).send('Email já cadastrado');
        }

        const hashedPassword = await hash(senha, saltRounds);
        const sql = `INSERT INTO usuario (nome1, nome2, email, senha, telefone, cod_adm) VALUES (?, ?, ?, ?, ?, ?)`;
        const insertResult = queryAsync(sql, [nome1, nome2, email, hashedPassword, telefone, cod_adm]);

        res.json({ message: 'User created successfully', id: insertResult.insertId });
    } catch (err) {
        console.error('Error creating user:', err);
        res.status(500).send('Error ao criar user');
    }
});

router.put('/:id', verificationAdmUser, async (req, res) => {
    const { id_usuario } = req.params;
    const { nome1, nome2, email, senha, telefone } = req.body;

    const sql = `UPDATE usuario SET nome1 = ?, nome2 = ?, senha = ?, telefone = ? WHERE id_usuario = ? and id_adm = ?`;

    try {
        const results = queryAsync(sql, [nome1, nome2, email, senha, telefone, id_usuario, req.query.id_adm]);

        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Usuario não encontrado' });
        }

        res.json({ message: 'Usuario atualizado com sucesso', id: req.params.id });
    } catch (err) {
        console.error('Erro ao atualizar usuario', err);
        res.status(500).json({ error: 'Erro ao atualizar usuario' });
    }
});

router.delete('/:id', verificationAdmUser, async (req, res) => {
    const { id_usuario } = req.params;
    const { id_adm } = req.query;

    const sql = `DELETE FROM usuario WHERE id_usuario = ? and id_adm = ?`;

    try {
        const results = queryAsync(sql, [id_usuario, id_adm]);

        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Usuario não encontrado' });
        }

        res.json({ message: 'Usuario deletado com sucesso', id: req.params.id });
    } catch (err) {
        console.error('Erro ao deletar usuario', err);
        res.status(500).json({ error: 'Erro ao deletar usuario' });
    }
});

router.get('/:id', verificationAdmUser, async (req, res) => {
    const { id_usuario } = req.params;
    const { id_adm } = req.query;

    const sql = `SELECT * FROM usuario WHERE id_usuario = ?`;

    try {
        const results = queryAsync(sql, [id_usuario, id_adm]);

        if (results.length === 0) {
            return res.status(404).json({ message: 'Usuario não encontrado' });
        }

        res.json(results[0]);
    } catch (err) {
        console.error('Erro ao buscar usuario', err);
        res.status(500).json({ error: 'Erro ao buscar usuario' });
    }
});

router.get('/', verificationAdmUser, async (req, res) => {
    const { id_adm } = req.query;

    const sql = `SELECT * FROM usuario WHERE id_adm = ?`;

    try {
        const results = queryAsync(sql, [id_adm]);
        res.json(results);
    } catch (err) {
        console.error('Erro ao buscar usuarios', err);
        res.status(500).json({ error: 'Erro ao buscar usuarios' });
    }
});

export default router;
