const mysql = require('mysql');
const express = require('express');
var app = express();
var multer = require('multer');
const bodyparser = require('body-parser');


app.use(bodyparser.json());

var mysqlConnection = mysql.createConnection({
    host:'localhost',
    user: 'root',
    password:'',
    database: 'booking',
    multipleStatements: true
});

mysqlConnection.connect((err)=>{
    if(!err)
    console.log('DB connection succeed');
    else
    console.log('DB connection failed \n Error : '+ JSON.stringify(err,undefined, 2) );
});

app.listen(3000,()=>console.log('Express Server runs at port no:3000'));

//Get All Booking
app.get('/booking',(req,res)=>{
    mysqlConnection.query('SELECT * FROM book',(err, rows, fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
});

// //Get a booking

app.get('/booking/:id',(req,res)=>{
    mysqlConnection.query('SELECT * FROM book WHERE booking_id = ?',[req.params.id],(err, rows, fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
});

// //Delete An booking

app.delete('/del_booking/:id',(req,res)=>{
    mysqlConnection.query('DELETE FROM book WHERE booking_id = ?',[req.params.id],(err, rows, fields)=>{
        if(!err)
        res.send('Deleted successfully');
        else
        console.log(err);
    })
});


// //Insert An Property

app.post('/new_booking',(req,res)=>{
    let b = req.body;
    var sql = "SET @BookingId = ?; SET @UserId = ?; SET @PropId = ?; SET @Status = ?;\
    CALL BookingAddOrEdit(@BookingId,@UserId,@PropId,@Status);";

    mysqlConnection.query(sql,[b.booking_id, b.user_id, b.prop_id, b.status_queue],(err, rows, fields)=>{
        if(!err)
        rows.forEach(element => {
            if(element.constructor == Array)
            res.send('Your Booking ID is :'+ element[0].booking_id);
            });
        else
        console.log(err);
    })

});

     

//Update An Property

app.put('/update_booking',(req,res)=>{
    let b = req.body;
    var sql = "SET @BookingId = ?;SET @UserId = ?;SET @PropId = ?;SET @Status = ?;\
    CALL BookingAddOrEdit(@BookingId,@UserId,@PropId,@Status);";
    mysqlConnection.query(sql,[b.booking_id, b.user_id, b.prop_id, b.status_queue],(err, rows, fields)=>{ 
        if(!err)
        res.send('Updated Succesfully');
        else
        console.log(err);
    })
});