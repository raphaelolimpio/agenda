import { query } from '../db/db.js';
import bcrypt from 'bcryptjs';  
import { Router } from 'express';
const router = Router();


const checkLoginAdm = (req, res, next) => {
    const { email, senha } = req.body;

    if (!email || !senha) {
        return res.status(400).send('Email e senha são obrigatórios');
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        return res.status(400).send('Email inválido');
    }

    next();
};

router.post('/login', checkLoginAdm, async (req, res) => {
    const { email, senha } = req.body;

    const sql = 'SELECT * FROM adm WHERE email = ?';
    try {
        const results = query(sql, [email]); 
        
        if (results.length === 0) {
            return res.status(404).send('Adm não encontrado');
        }

        const adm = results[0];

        const senhaCorreta = await bcrypt.compare(senha, adm.senha);
        if (!senhaCorreta) {
            return res.status(400).json({ error: 'Senha incorreta' });
        }

        res.status(200).json({ message: 'Login efetuado com sucesso' });
    } catch (err) {
        console.error('Error checking admin:', err);
        return res.status(500).send('Erro ao verificar administrador');
    }
});

export default router;
