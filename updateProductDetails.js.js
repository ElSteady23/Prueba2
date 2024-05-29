const axios = require('axios');
const mysql = require('mysql');

// Configuración de la conexión a MySQL
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'admin',
  password: 'Fab11an23$',
  database: 'prueba2'
});

// Conectar a la base de datos
connection.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos:', err);
    return;
  }
  console.log('Conexión a la base de datos establecida');
});

// Función para obtener el tipo de cambio del dólar desde la API y almacenarlo en la base de datos
async function updateExchangeRate() {
  try {
    const response = await axios.get('https://mindicador.cl/api');
    const valorDolar = response.data.dolar.valor;

    // Insertar el valor del dólar en la tabla mindicador
    const insertQuery = `
      INSERT INTO mindicador (codigo, valor, fecha) VALUES ('dolar', ?, CURDATE())
      ON DUPLICATE KEY UPDATE valor = VALUES(valor), fecha = VALUES(fecha)
    `;

    connection.query(insertQuery, [valorDolar], (err, result) => {
      if (err) {
        console.error('Error al actualizar el precio del dólar:', err);
        return;
      }
      console.log('Precio del dólar actualizado en la base de datos');
    });
  } catch (error) {
    console.error('Error al obtener el tipo de cambio:', error);
    throw error;
  }
}

// Función para obtener los detalles de los productos y el precio en dólares
async function getProductDetails() {
  try {
    // Actualizar el tipo de cambio del dólar en la base de datos
    await updateExchangeRate();

    // Obtener los detalles de los productos con el precio en CLP y USD
    const query = `
      SELECT 
          p.codigo,
          p.nombre AS modelo,
          m.nombre AS marca,
          pr.valor AS precio_clp,
          ROUND(pr.valor / (SELECT valor FROM mindicador WHERE codigo = 'dolar' ORDER BY fecha DESC LIMIT 1), 2) AS precio_usd,
          i.cantidad AS stock
      FROM 
          productos p
      JOIN 
          marcas m ON p.marca_id = m.id
      JOIN 
          precios pr ON p.id = pr.producto_id
      JOIN 
          inventario i ON p.id = i.producto_id
      WHERE 
          pr.fecha = (SELECT MAX(fecha) FROM precios WHERE producto_id = p.id);
    `;

    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error al obtener los detalles de los productos:', err);
        return;
      }

      console.log('Detalles de productos obtenidos:', results);
    });
  } catch (error) {
    console.error('Error en el proceso de obtener detalles de productos:', error);
  }
}

// Ejecutar la función para obtener los detalles de los productos
getProductDetails();

// Cerrar la conexión después de la ejecución
connection.end((err) => {
  if (err) {
    console.error('Error cerrando la conexión:', err);
    return;
  }
  console.log('Conexión a la base de datos cerrada');
});



//Explicación del Código
//Conexión a MySQL: Se establece una conexión a la base de datos MySQL.
//Obtener tipo de cambio: Se utiliza axios para obtener el tipo de cambio actual del dólar desde la API de mindicador.cl.
//Consulta SQL: Se construye una consulta SQL para obtener los detalles de los productos, uniendo las tablas productos, marcas, precios y inventario.
//Eliminar datos existentes: Se eliminan los datos existentes en la tabla productos_detallados para evitar duplicados.
//Insertar datos: Se insertan los datos obtenidos en la tabla productos_detallados.
//Cerrar conexión: Se cierra la conexión a la base de datos después de la inserción

