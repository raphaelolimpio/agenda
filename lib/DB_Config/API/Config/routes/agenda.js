import { Router } from 'express';
import { query } from '../db/db.js';
const router = Router();

router.get('/agend', async (req, res) => {
    const sql = 'SELECT * FROM agend';
    try {
        const results = query(sql);
        res.json(results);
    } catch (err) {
        console.error('Error getting agend:', err);
        res.status(500).json({ error: 'Error ao pegar agend' });
    }
});

router.get('/agend/:id_agend', async (req, res) => {
    const { id_agend } = req.params;
    const sql = 'SELECT * FROM agend WHERE id_agend = ?';
    try {
        const results = query(sql, [id_agend]);
        if (results.length === 0) {
            return res.status(404).json({ message: 'Agend não encontrado' });
        }
        res.json(results[0]);
    } catch (err) {
        console.error('Error getting agend:', err);
        res.status(500).json({ error: 'Error ao pegar agend' });
    }
});

router.post('/agend', async (req, res) => {
    const { data, hora, id_user, id_adm } = req.body;
    const sql = 'INSERT INTO agend (data, hora, id_user, id_adm) VALUES (?, ?, ?, ?)';
    try {
        const results = query(sql, [data, hora, id_user, id_adm]);
        res.json({ message: 'Agend created successfully', id: results.insertId });
    } catch (err) {
        console.error('Error creating agend:', err);
        res.status(500).json({ error: 'Error ao criar agend' });
    }
});

router.put('/agend/:id_agend', async (req, res) => {
    const { id_agend } = req.params;
    const { data, hora, id_user, id_adm } = req.body;
    const sql = 'UPDATE agend SET data = ?, hora = ?, id_user = ?, id_adm = ? WHERE id_agend = ?';
    try {
        const results = query(sql, [data, hora, id_user, id_adm, id_agend]);
        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Agend não encontrado' });
        }
        res.json({ message: 'Agend updated successfully', id: id_agend });
    } catch (err) {
        console.error('Error updating agend:', err);
        res.status(500).json({ error: 'Error ao atualizar agend' });
    }
});

router.delete('/agend/:id_agend', async (req, res) => {
    const { id_agend } = req.params;
    const sql = 'DELETE FROM agend WHERE id_agend = ?';
    try {
        const results = query(sql, [id_agend]);
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
