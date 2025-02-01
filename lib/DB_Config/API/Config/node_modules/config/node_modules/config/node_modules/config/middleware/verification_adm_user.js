import checkAdmin from '../utils/check_adm.js';
import checkUser from '../utils/check_user.js';

const verificationAdmUser = async (req, res, next) => {
    const { id_usuario, id_adm } = req.body || req.query;
    if (!id_usuario && !id_adm) {
        return res.status(400).send('id_usuario ou id_adm são obrigatórios');
    }

    try {
        const isUser = await checkUser(id_usuario);
        if (!isUser) {
            return res.status(404).json({error: `User not found for Id: ${id_usuario}` });
        }

        const isAdmin = await checkAdmin(id_adm);
        if (!isAdmin) {
            return res.status(404).json({error: `Adm not found for Id: ${id_adm}` });
        }
        next();
    } catch (err) {
        console.error('Error checking if user is user:', err);
        res.status(505).json({ error: 'Erro ao verificar dados do usuario ou dono adm' });
    }   
};

export default verificationAdmUser;