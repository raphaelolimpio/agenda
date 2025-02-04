import connection from '../db/db.js';
const checkUser = async (id_usuario) => {
    const sql = `SELECT * FROM usuario WHERE id_usuario = ?`;
    try {
        const [results] = connection.query(sql, [id_usuario]);
        return results.length > 0;
    } catch (err) {
        console.error('Error checking if user is user:', err);
        throw new Error('Error ao verificar user');
    };
};

export default checkUser;