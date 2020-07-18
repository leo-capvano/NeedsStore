package controller;

import model.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.taglibs.standard.lang.jstl.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


@WebServlet("/UploadImage")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 7,
        maxRequestSize = 1024 * 1024 * 7 * 7)
public class UploadImage extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        if (utenteLoggato==null){
            throw new GenericException("Non sei autorizzato a visualizzare questa pagina");
        }


        String filePath = "";
        String filename = "";
        List<FileItem> items = new ArrayList<FileItem>();
        //salvo lista dei filenames delle img caricato per salvarli poi nel db
        ArrayList<String> filenames = new ArrayList<>();
        InputStream in = null;
        File uploadPath = new File("C:\\Users\\leoca\\Desktop\\immagini");
        if(ServletFileUpload.isMultipartContent(req)){ //controllo se il form è multipart
            try {
                //fa parte di apache common file upload, gestisce multipli file x singolo HTML
                ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
                items = sf.parseRequest(req); //recupero i vari files(items)

                for (FileItem item : items){
                    //rendo il nome unico con random()+filename originale
                    filename = ((int)(Math.random()*1000))+item.getName();
                    in = item.getInputStream();
                    //creo oggetto del nuovo file da uploadare
                    File newFile = new File(uploadPath, filename);
                    Files.copy(in,newFile.toPath());
                    filenames.add(filename);
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        Articolo newArticolo = (Articolo) req.getSession().getAttribute("newArticolo");

        //scrivi l'articolo nel db
        ArticoloDAO ardao = new ArticoloDAO();
        ardao.doPublish(newArticolo);

        //creare e scrivere tanti album per quanti sono gli items(foto caricate)
        for (int i=0; i<filenames.size(); i++){
            AlbumDAO aldao = new AlbumDAO();
            Album album = new Album(UUID.randomUUID().toString(),"/immagini/"+filenames.get(i),newArticolo.getIdArticolo());
            aldao.doInsertAlbum(album);
        }

        //articolo pubblicato
        resp.sendRedirect("homepage.jsp");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

}
