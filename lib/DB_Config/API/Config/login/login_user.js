import { queryAsync } from '../db/db.js';
import bcrypt from 'bcrypt';
import { Router } from 'express';
const router = Router();

const checkLoginUser = (req, res, next) =>{
    const {email ,senha } = req.body;
    if (!email || !senha) {
        return res.status(400).send('Email e senha são obrigatórios');
    } 
    const emailRegex= /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        return res.status(400).send('Email inválido');
    };
    
    next();
};


router.post('/login', checkLoginUser, async (req, res) => {
    const {email ,senha } = req.body;
    const sql = `SELECT * FROM usuario WHERE email = ? AND senha = ?`;
    try {
        const results = await queryAsync(sql, [email]); 

        if (results.length === 0) {
            return res.status(404).send('User not found');
        }

        const usuario = results[0];

        const senhaCorreta = await bcrypt.compare(senha, usuario.senha);
        if (!senhaCorreta) {
            return res.status(400).json( {error:'Senha incorreta'});
        }
        res,json ({message: 'Login efetuado com sucesso'});
        
    } catch (err) {
        console.error('Error checking user:', err);
        return res.status(500).send('Erro ao verificar usuario');
    };
});

export default router;
