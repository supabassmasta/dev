var http = require('http');
var fs = require('fs');
var formidable = require('formidable');

console.log("Program started");

// html file containing upload form
var upload_html = fs.readFileSync("upload_file.html");
var dl_2MB  = fs.readFileSync("2MB.gif");
var dl_10MB  = fs.readFileSync("10MB.zip");
var dl_20MB  = fs.readFileSync("20MB.zip");
 
// replace this with the location to save uploaded files
var upload_path = "/tmp/";
 
http.createServer(function (req, res) {
    if (req.url == '/uploadform') {
      res.writeHead(200);
      res.write(upload_html);
      return res.end();
    } else if (req.url == '/fileupload') {
        var form = new formidable.IncomingForm();
        form.parse(req, function (err, fields, files) {
            console.log('fields', fields);
            console.log('files', files);
            // oldpath : temporary folder to which file is saved to
            var oldpath = files.filetoupload.filepath;
            var newpath = upload_path + files.filetoupload.originalFilename;
            console.log('oldpath');
             // copy the file to a new location
             fs.rename(oldpath, newpath, function (err) {
                 if (err) throw err;
                 // you may respond with another html page
                 res.write('File uploaded and moved!');
                 res.end();
             });
                 //res.write('File uploaded and moved!');
                 //res.end();
        });
    } else if (req.url == '/2MB.gif') {
      res.writeHead(200);
      res.write(dl_2MB);
      return res.end();
    } else if (req.url == '/10MB.zip') {
      res.writeHead(200);
      res.write(dl_10MB);
      return res.end();
    } else if (req.url == '/20MB.zip') {
      res.writeHead(200);
      res.write(dl_20MB);
      return res.end();
    }
}).listen(8086);
