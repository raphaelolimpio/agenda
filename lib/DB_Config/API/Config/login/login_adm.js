import { queryAsync } from '../db/db.js';
import bcrypt from 'bcryptjs';  
import { Router } from 'express';
const router = Router();


/*************  ✨ Codeium Command ⭐  *************/
/**
 * Middleware to validate the login request body for an admin user.
 * Checks if the 'email' and 'senha' fields are present and valid.
 * If any field is missing or invalid, sends a 400 status response with an appropriate message.
 * If everything is valid, proceeds to the next middleware or route handler.
 *
 * @param {Object} req - The request object from Express, containing the body with 'email' and 'senha'.
 * @param {Object} res - The response object from Express, used to send error responses if needed.
 * @param {Function} next - The next middleware function in the stack.
 */

/******  082ad64b-313f-4d98-a63d-980874fa41a9  *******/
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
        const results = await queryAsync(sql, [email]); 
        
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
