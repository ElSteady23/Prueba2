const axios = require('axios');
const mysql = require('mysql');

// Configuración de la conexión a MySQL
const connection = mysql.createConnection({
  host: 'localhost',  // Cambia esto si tu base de datos no está en localhost
  user: 'admin',       // Cambia esto por tu usuario de MySQL
  password: 'Fab11an23$', // Cambia esto por tu contraseña de MySQL
  database: 'prueba2' // Nombre de la base de datos
});

// Conectar a la base de datos
connection.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos:', err);
    return;
  }
  console.log('Conexión a la base de datos establecida');
});

// Consumir la API
axios.get('https://mindicador.cl/api')
  .then(response => {
    const data = response.data;
    // Ejemplo de insertar un indicador en la base de datos
    const sql = 'INSERT INTO indicadores (nombre, valor, fecha) VALUES ?';
    const values = [
      
      ['dolar', data.dolar.valor, new Date(data.dolar.fecha)]
      
    ];

    connection.query(sql, [values], (err, result) => {
      if (err) {
        console.error('Error insertando datos:', err);
        return;
      }
      console.log('Datos insertados:', result);
      connection.end(); // Cerrar la conexión después de la inserción
    });
  })
  .catch(error => {
    console.error('Error al consumir la API:', error);
  });

