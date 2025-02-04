import connection from '../db/db.js';
const checkAdmin = async (id_adm) => {
    const sql = `SELECT * FROM adm WHERE id_adm = ?`;
    try {
        const results = connection.query(sql, [id_adm]);
        return results.length > 0;
    } catch (err) {
        console.error('Error checking if user is admin:', err);
        throw new Error('Error ao verificar adm');
    };
};

export default checkAdmin;