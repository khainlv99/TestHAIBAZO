package com.turnos.turnos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class MySQLServer {

    private static MySQLServer mySQLServer;

    private static final String USER = "root";
    private static final String PASS = "Khai@123456";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/turnos?createDatabaseIfNotExist=true";

    private Connection connection = null;

    private MySQLServer(){
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("Estableciendo la conexion...");
            connection = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Conexion exitosa a MySQL!");

        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos:");
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontró el driver de MySQL JDBC:");
            e.printStackTrace();
        }
    }

    public void sendQuery(String query){
        try{
            PreparedStatement preparedStatement = this.connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        }
        catch (SQLException e){
            System.out.println("Error al ejecutar query:");
            e.printStackTrace();
        }
    }

    public Connection getConnection(){
        return this.connection;
    }

    public static MySQLServer getInstance(){
        if(mySQLServer == null){
            mySQLServer = new MySQLServer();
        }
        return mySQLServer;
    }
}
