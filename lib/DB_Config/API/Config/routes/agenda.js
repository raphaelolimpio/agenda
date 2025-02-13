import { Router } from 'express';
import { queryAsync } from '../db/db.js';

const router = Router();

router.get('/', async (req, res) => {
    const sql = 'SELECT * FROM agend';
    try {
        const results = queryAsync(sql);
        res.json(results);
    } catch (err) {
        console.error('Error getting agend:', err);
        res.status(500).json({ error: 'Error ao pegar agend' });
    }
});

router.get('/:id_agend', async (req, res) => {
    const { id_agend } = req.params;
    const sql = 'SELECT * FROM agend WHERE id_agend = ?';
    try {
        const results = queryAsync(sql, [id_agend]);
        if (results.length === 0) {
            return res.status(404).json({ message: 'Agend não encontrado' });
        }
        res.json(results[0]);
    } catch (err) {
        console.error('Error getting agend:', err);
        res.status(500).json({ error: 'Error ao pegar agend' });
    }
});

router.post('/', async (req, res) => {
    const { titulo, descricao, data } = req.body;
    
    if (!titulo || !descricao || !data) {
        return res.status(400).json({ error: 'Todos os campos são obrigatórios' });
    }

    try {
        const sql = 'INSERT INTO agenda (titulo, descricao, data) VALUES (?, ?, ?)';
        const results = await queryAsync(sql, [titulo, descricao, data]);
        
        res.json({ message: 'Evento criado com sucesso', id: results.insertId });
    } catch (err) {
        console.error('Erro ao criar evento:', err);
        res.status(500).json({ error: 'Erro ao criar evento' });
    }
});

router.put('/:id_agend', async (req, res) => {
    const { id_agend } = req.params;
    const { data, hora, id_user, id_adm } = req.body;
    const sql = 'UPDATE agend SET data = ?, hora = ?, id_user = ?, id_adm = ? WHERE id_agend = ?';
    try {
        const results = queryAsync(sql, [data, hora, id_user, id_adm, id_agend]);
        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Agend não encontrado' });
        }
        res.json({ message: 'Agend updated successfully', id: id_agend });
    } catch (err) {
        console.error('Error updating agend:', err);
        res.status(500).json({ error: 'Error ao atualizar agend' });
    }
});

router.delete('/:id_agend', async (req, res) => {
    const { id_agend } = req.params;
    const sql = 'DELETE FROM agend WHERE id_agend = ?';
    try {
        const results = queryAsync(sql, [id_agend]);
        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Agend não encontrado' });
        }
        res.json({ message: 'Agend deleted successfully', id: id_agend });
    } catch (err) {
        console.error('Error deleting agend:', err);
        res.status(500).json({ error: 'Error ao deletar agend' });
    }
});

export default router;
